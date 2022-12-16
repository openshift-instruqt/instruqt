---
slug: 02-create-message-listeners
id: nkgqo43lga7g
type: challenge
title: Step 2
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/spring-messaging
difficulty: basic
timelimit: 750
---
# Create JMS Message Listeners

The Java Message Service (JMS) is a standard designed to allow applications to create, send, and receive Messages to form loosely coupled asynchronous components. Messaging between components is typically asynchronous and is a very common pattern in distributed systems.

Spring Boot offers abstractions for the JMS standard that make it very quick and easy to create messages from Java objects, send them to destination queues using the familiar Template pattern (akin to Spring's RestTemplate or JdbcTemplate), and to create Receivers (or Listeners) for specific types of messages on Queues.


**1. Create a Message Listener**

First we need a message object. Spring Boot allows us to code in the context of our own Java models when dealing with messages. For this purpose we will create a simple `Fruit` object which contains a String `body`.

First, we need to create the java class file. From the *Visual Editor* Tab, Open the file: `src/main/java/com/example/domain/Fruit.java`.

Replace with the below content into the file:

```java
package com.example.domain;

import java.util.List;
import java.util.Random;

public class Fruit {
    private String name;
    private static final List<String> FRUITS = List.of("Apple", "Banana", "Watermelon");

    private static String getRandomFruit() {
        Random rand = new Random();
        int index = rand.nextInt(FRUITS.size());
        return FRUITS.get(index);
    }

    public Fruit() {
        this.name = getRandomFruit();
    }

    public Fruit(String name) {
        this.name = name;
    }

    public String getFruit() {
        return this.name;
    }

    public void setFruit(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Fruit{ Name ='" + this.name + '\'' + " }";
    }
}
```

Save the file.

Do the same for `src/main/java/com/example/domain/MemCache.java` which adds/retrieves messages to/from the cache.

```java
package com.example.domain;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.List;
import java.util.Queue;

import org.springframework.stereotype.Service;

@Service
public class MemCache {
    private static final int CACHE_MAX_SIZE = 5;
    private Queue<Fruit> messages = new ArrayDeque<>(CACHE_MAX_SIZE);

    public long getCount() {
        return this.messages.size();
    }

    public void addMessage(Fruit fruit) {
        this.messages.add(fruit);

        if (this.messages.size() > CACHE_MAX_SIZE) {
            this.messages.remove();
        }
    }

    public List<Fruit> getMessages() {
        return new ArrayList<>(this.messages);
    }
}
```

Save the file.

Just a Plain Old Java Object (POJO)!

To receive our Ping messages from a JMS Queue we'll need a class that listens for Queue messages. These components (typically called `Receivers`) in Spring Boot are `@Component`-annotated classes with a method annotated with `@JmsListener`.  From the *Visual Editor* Tab, open this file: `src/main/java/com/example/service/FruitReceiver.java`

Then, replace with the below content into the file:

```java
package com.example.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.jms.annotation.JmsListener;
import org.springframework.stereotype.Component;

import com.example.domain.Fruit;
import com.example.domain.MemCache;

@Component
public class FruitReceiver {
    private static final Logger LOGGER = LoggerFactory.getLogger(FruitReceiver.class);
    private final MemCache cache;

    public FruitReceiver(MemCache cache) {
        this.cache = cache;
    }

    @JmsListener(destination = "${queue.name}")
    public void receiveMessage(Fruit fruit) {
        LOGGER.info("Received: {}", fruit);
        this.cache.addMessage(fruit);
    }
}
```

Save the file.

We annotate the class with `@Component` to get the class picked up by Spring's Component Scanning. Spring will manage this class' lifecycle and dependencies for us.

The `@JmsListener` annotation is what sets this class up for JMS Message handling. We're essentially creating a binding: whenever a message of type `Fruit` is sent to the target Queue (called a `destination` here) this method will be called by Spring for processing. Spring will attempt to deserialize the message to an object and then pass that object to our method here.

The `"${queue.name}"` String in the destination utilizes the Spring Expression Language to allow parameterization of Queue names. This allows us to place the name of the Queue in our `.properties` files which can change between environments without the need for a code change. You can see the properties for openshift running by opening the `src/main/resources/application-openshift.properties` file.

There also exists a second annotation parameter, `connectionFactory`, that we can use if we have a custom `ConnectionFactory` Bean but we don't use that here because we are defaulting to use the `ConnectionFactory` Spring Boot automatically creates.

The actual body of the message is mostly just integration with the included web application. We have an in-memory Cache service which we increment a count and store the Ping we received for display later.

**2. Message Serialization**

Notice that the argument to our `receiveMessage()` method is our domain class: a `Fruit`. We're not accepting any custom types or wrapper objects (although Spring does support arguments of their `Message<T>` type). This is because Spring magic, under the hood, can convert the raw messages coming into the Queue into our custom objects if we meet a few criteria. For our purposes we are going to send and receive these messages as JSON strings because Spring Boot makes JSON support a breeze.

In the first step of this scenario we included the `jackson-databind` dependency in the `pom.xml`. Jackson is a library that has tight integration with Spring Boot which enables marshalling and unmarshalling JSON to and from our objects respectively. For our JMS messages this means Spring Boot will automatically marshall our objects to JSON when we send them and unmarshal JSON to our objects when we receive them. We need to create a Configuration class to utilize this functionality. Open the `src/main/java/com/example/config/MessageConfig.java`.

Then, replace with the below content into the file (or use the `Copy to Editor` button):

```java
package com.example.config;;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.jms.support.converter.MappingJackson2MessageConverter;
import org.springframework.jms.support.converter.MessageConverter;
import org.springframework.jms.support.converter.MessageType;

@Configuration
public class MessageConfig {
    @Bean
    public MessageConverter jacksonJmsMessageConverter() {
        MappingJackson2MessageConverter converter = new MappingJackson2MessageConverter();
        converter.setTargetType(MessageType.TEXT);
        converter.setTypeIdPropertyName("_type");
        return converter;
    }
}
```

Save the file.

This `@Configuration` class has a single Bean - `MessageConverter`. Spring Boot uses this class to automatically serialize/deserialize JMS messages. Registering this Bean means that Spring Boot will automatically pick it up and use it for our JMS Messages. `MessageConverter` is the base type and `MappingJackson2MessageConverter` is the Jackson implementation of this base class.

**3. Sending JMS Messages**

Now that we have a listener and a Message model we now need a Message Producer. Normally these would be coming from external systems but for our purposes we are going to send messages to ourselves. To do that we need a Producer class. Click on the following link which will open an empty file in the editor: ``src/main/java/com/example/service/FruitPublisher.java``

Then, copy part of the below content into the file:

```java
package com.example.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.jms.core.JmsTemplate;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.example.domain.Fruit;

@Component
public class FruitPublisher {
    private static final Logger LOGGER = LoggerFactory.getLogger(FruitPublisher.class);
    private final JmsTemplate jmsTemplate;

    @Value("${queue.name}")
    private String queueName;

    public FruitPublisher(JmsTemplate jmsTemplate) {
        this.jmsTemplate = jmsTemplate;
    }

    @Scheduled(fixedRate = 3000L)
    public void sendTick() {
        Fruit fruit = new Fruit();
        LOGGER.info("Publishing fruit {} to destination {}", fruit, this.queueName);
        this.jmsTemplate.convertAndSend(this.queueName, fruit);
    }

}
```

Save the file.

Spring provides an abstraction called the `JmsTemplate` for sending messages to a JMS Queue. Spring Boot automatically configures this class for us so we need to `@Autowire` one into our `@Component`. Next we need to send the message. There are many variations of sending messages on the `JmsTemplate` class. We use the `.convertAndSend(String, Object)` variant which will marshall our Object to JSON (since we added the MessageConverter above) and then attempt to send to the target queue. We send a new `Fruit` message with a current timestamp on it to identify when it was sent.

The `@Value` annotation is our way of pulling the Queue name from our properties files. Spring populates those variables for us.

The `@Scheduled` interface is just a convenience annotation which prompts the Spring Container to call this method every 3000 milliseconds (3 seconds). The exact details is out of scope for this scenario. Just know that this method will automatically fire every 3 seconds.

**4. No local execution**

Typically, you would be running the application locally prior to deploying to OpenShift. Without a local message broker available, the local execution step will be skipped and you'll be deploying the application directly to OpenShift in the following two steps.

## Congratulations

You have now learned how to how to create JMS Queue listeners and how to send JMS Messages with Spring Boot! In the next step we will deploy this application to OpenShift and deploy a Red Hat AMQ queue via the Red Hat Integration - AMQ Broker operator.
