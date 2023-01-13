---
slug: 01-review-the-initial-project
id: eisemfxau3my
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    In this scenario you will learn more about developing Spring Boot Microservices using the [Red Hat Runtimes](https://www.redhat.com/en/products/runtimes) platform. You will learn about Externalized Configurations and how we can use Externalized Configurations to change specific values/variables without having to take down the entire application.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/microservices-externalized-config
- title: Fruit App
  type: service
  hostname: crc
  path: /
  port: 8080
difficulty: basic
timelimit: 1000
---
# Import the code
Let's refresh the code we'll be using. Run the following command to clone the sample project in Terminal 1:

```
cd /root/projects && rm -rf rhoar-getting-started && git clone https://github.com/openshift-katacoda/rhoar-getting-started && cd rhoar-getting-started/spring/microservices-externalized-config
```

# Review the base structure of the application
**1. Understanding the Application**

The project is a simple Greeting application, where a user inputs a fruit name and is greeted by our service. From the *Visual Editor* Tab, open the file in this path: `src/main/java/com/example/service/FruitController.java`. You can see the logic used to respond to our user. The interesting part of this logic is right here, where we retrieve the message:

```java
String message = String.format(properties.getMessage(), name);
```

If we take a closer look at this `properties` object, we see that it's of type `MessageProperties`. When we look at that file `src/main/java/com/example/service/MessageProperties.java` we see an annotation linking to a configuration prefix, `@ConfigurationProperties("greeting")`, which is pointing to our `src/main/resources/application-local.properties` file.

Our `application-local.properties` file contains only one property, `greeting.message`. This is the message that we return and display to the user. In order to get an understanding of the flow, let's run the application locally. On the terminal build the project:

```
mvn spring-boot:run
```

When the application finishes building, open the *Fruit App* Tab. You should see the same message that is in the `application-local.properties` file.

Be sure to stop the application with `CTRL-C`.

## Congratulations

You have now successfully executed the first step in this scenario. in the next step we're going to be deploying the project and testing it our for ourselves, as well as modifying this greeting through External Configuration.