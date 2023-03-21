---
slug: 03-create-beans
id: sf8e3buti9wj
type: challenge
title: Topic 3 - Implementing Spring dependency injection in Quarkus
notes:
- type: text
  contents: Topic 3 - Implementing Spring dependency injection in Quarkus
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/quarkus/fruit-taster
- title: Terminal 2
  type: terminal
  hostname: crc
difficulty: intermediate
timelimit: 800
---

In addition to using Java's Contexts and Dependency Injection (CDI) annotations for dependency injection management, Quarkus provides a compatibility layer for Spring's `spring-di` extension framework.

This topic demonstrates how your Quarkus application can leverage the well known Dependency Injection annotations included in the Spring Framework.

Let’s proceed by creating some beans using various Spring annotations.

## Creating a functional interface

First we will create a functional interface named `StringFunction` that some of the beans will implement and which will be injected into another bean later on.

|What is a functional interface?|
|----|
|A functional interface is an interface that contains exactly one abstract method. A functional interface can have any number of default, static methods but can contain only one abstract method.<br>Functional Interfaces are part of the base Java platform and are not Spring-specific.|

A functional interface provides target types for lambda expressions and method references that we'll define shortly.

----

`Step 1:` Click the **Visual Editor** tab over the terminal window on the left and navigate to the directory `fruit-taster/src/main/java/org/acme/`

----

`Step 2:` Click the `Create File` icon at the directory `fruit-taster/src/main/java/org/acme/` in the **Visual Editor** filesystem tree and create a file named `StringFunction.java`.

The file `StringFunction.java` is where you'll create a functional interface named `StringFunction`.

----

`Step 3:` Add the following code to the file `StringFunction.java`


```java
package org.acme;

import java.util.function.Function;

public interface StringFunction extends Function<String, String> {

}
```

----

`Step 4:` Save the file `StringFunction.java` by clicking the `Disk` icon or striking the `CTRL+S` keys as you did in previous steps.

Next you will add an `AppConfiguration` class which will use the Spring’s Java Config style for defining a bean.

The class `AppConfiguration` will be used to create a `StringFunction` bean. The behavior you'll implement in the `StringFunction` bean will convert all text passed as parameter to upper case characters.

----

`Step 5:` Click the `Create File` icon at the directory `fruit-taster/src/main/java/org/acme/` in the **Visual Editor** filesystem and create a file named `AppConfiguration.java`.

----

`Step 5:` Add the following code to the file `AppConfiguration.java`

```java
package org.acme;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfiguration {

    @Bean(name = "capitalizeFunction")
    public StringFunction capitalizer() {
        return String::toUpperCase;
    }
}
```

----

`Step 6:` Save the file `AppConfiguration.java` by clicking the `Disk` icon or striking the `CTRL+S` keys as you did in previous steps.

## Implementing behavior for a functional interface

Now you'll define another bean that will implement behavior for the functional interface `StringFunction` using Spring’s `Stereotype Annotation` style. This bean will implement no-op behavior that simply returns the value of the parameter input as is.

----

`Step 7:` In the **Visual Editor** navigate to the directory `fruit-taster/src/main/java/org/acme/`

----

`Step 8:` Click the `Create File` icon at the directory `fruit-taster/src/main/java/org/acme/` in the **Visual Editor** filesystem and create a file named `NoOpSingleStringFunction.java`.

----

`Step 8:` Add the following code to the file `NoOpSingleStringFunction.java`:

```java
package org.acme;

import org.springframework.stereotype.Component;

@Component("noopFunction")
public class NoOpSingleStringFunction implements StringFunction {

    @Override
    public String apply(String s) {
        return s;
    }
}
```

----

`Step 9:` Save the file `NoOpSingleStringFunction.java` by clicking the `Disk` icon or striking the `CTRL+S` keys as you did in previous steps.

## Adding injectable configuration

Quarkus provides support for injecting configuration values from a resource file using Spring’s `@Value` annotation.

You're now going to see this injection process in action.

----

`Step 10:` Go to the **Visual Editor** tab and open the file `fruit-taster/src/main/resources/application.properties` by clicking on the filename in the editor's directory tree.

----

`Step 11:` Add the text below as a new line in the file `application.properties`. (Be careful not to overwrite the text that's already in the file.)

```text
taste.message = tastes great
```

----

`Step 12:` Save the file `application.properties` by clicking the `Disk` icon or striking the `CTRL+S` keys as you did in previous steps.

Next you'll create a new Spring Bean to use the `taste.message = tastes great` configuration value.


----

`Step 13:` Click the `Create File` icon at the directory `fruit-taster/src/main/java/org/acme/` in the **Visual Editor** filesystem and create a file named `MessageProducer.java`.

----

`Step 14:` Open the file `MessageProducer.java` and add the following code:


```java
package org.acme;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

@Service
public class MessageProducer {

    @Value("${taste.message}")
    String message;

    public String getTaste() {
        return message;
    }
}
```

Notice that the code uses the ` @Value` annotation to automatically inject the value associated with the `taste.message` key as defined in the resource file `application.properties`. The value associated with the `taste.message` key is assigned to the instance variable `message`. Spring's `Stereotype Annotation` style make this automation possible.

----

`Step 15:` Save the file `MessageProducer.java` by clicking the `Disk` icon or striking the `CTRL+S` keys as you did in previous steps.


## Tying them all together

The final bean you are going create will tie together all the work you've done with the previous beans.

You're going to create a class named `TasterBean` which will use a variety of `Stereotype Annotations` in conjunction with the `StringFunction` functional interface you created previously.

Let's create `TasterBean`

----

`Step 16:` In the **Visual Editor** navigate to the directory `fruit-taster/src/main/java/org/acme/`

----

`Step 17:` Click the `Create File` icon at the directory `fruit-taster/src/main/java/org/acme/` in the **Visual Editor** filesystem and create a file named `TasterBean.java`.

----


`Step 18:` Click the file named `TasterBean.java` and add the following code to the file

```java
package org.acme;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Component
public class TasterBean {

    private final MessageProducer messageProducer;

    @Autowired
    @Qualifier("noopFunction")
    StringFunction noopStringFunction;

    @Autowired
    @Qualifier("capitalizeFunction")
    StringFunction capitalizerStringFunction;

    @Value("${taste.suffix:!}")
    String suffix;

    public TasterBean(MessageProducer messageProducer) {
        this.messageProducer = messageProducer;
    }

    public String taste(String fruitName) {
        final String initialValue = fruitName + ": " + messageProducer.getTaste() + " " + suffix;
        return noopStringFunction.andThen(capitalizerStringFunction).apply(initialValue);
    }
}
```

`Step 19:` Save the file `TasterBean.java` by clicking the `Disk` icon or striking the `CTRL+S` keys as you did in previous steps.

Although the `TasterBean` has only about 30 lines of code, but those lines of code are doing a lot of work, most of which is leveraging the power provided by Spring annotations.

Let's do a brief analysis of the code.

Notice that Spring annotations are being used to inject behavior for the member functions `noopStringFunction` and `capitalizerStringFunction` which are declared as type `StringFunction`.

Remember that `StringFunction` is the functional interface that you created at the beginning of this topic.

The functions `noopStringFunction` and `capitalizerStringFunction` are injected via `@Autowired`.  The function `noopStringFunction` does nothing. The function `capitalizerStringFunction` transform its result INTO ALL CAPS.

Also notice that `TasterBean` constructor does **not** need the `@Autowired` annotation since there is a single constructor.

Furthermore, the `@Value` annotation on `suffix` also has  a default value defined, which in this case will be used since we did not define `taste.suffix` in the `application.properties` file previously.

This new `TasterBean` has a method `taste()` which will report how each fruit tastes.

**Congratulations!**

You've done a lot of detailed work in this topic.

Now that the data model, repository, and accessor beans are in place, let's move to the final step where you'll expose the fruits to the outside world using Spring Web annotations.

----

**NEXT:** Using Spring Web Annotations in Quarkus