---
slug: 01-review-the-initial-project
id: 4hzzp2umtohl
type: challenge
title: Step 1
notes:
- type: text
  contents: |+
    In this scenario you will learn more about developing Spring Boot applications using the [Red Hat Runtimes](https://www.redhat.com/en/products/runtimes) platform. We will be building a simple Spring Boot application which produces messages to and consumes messages from a [Red Hat AMQ](https://www.redhat.com/en/technologies/jboss-middleware/amq) resource. AMQ provides fast, lightweight, and secure messaging for Internet-scale applications. AMQ components use industry-standard message protocols and support a wide range of programming languages and operating environments. AMQ gives you the strong foundation you need to build modern distributed applications.

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
# Import the code

Let's refresh the code we'll be using. Run the following command to clone the sample project in Terminal 1:

```
cd /root/projects && rm -rf rhoar-getting-started && git clone https://github.com/openshift-katacoda/rhoar-getting-started && cd rhoar-getting-started/spring/spring-messaging
```

# Review the base structure of the application

For your convenience, this scenario has been created with a base project using the Java programming language and the Apache Maven build tool.

As you review the content, you will notice that there are a lot of **TODO** comments. **Do not remove them!** These comments are used as markers for later exercises in this scenario.

**1. Add JMS Dependencies**

To add Spring JMS to our project go to the **Visual Editor** Tab, and add the following line in `pom.xml` after the `<!-- TODO: Add JMS dependency here -->` line in Visual Editor:

```xml
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-artemis</artifactId>
    </dependency>
    <dependency>
        <groupId>com.fasterxml.jackson.core</groupId>
        <artifactId>jackson-databind</artifactId>
    </dependency>
```

Along with the JMS dependencies this starter also brings in the ActiveMQ Broker. The Broker manages connections to the Queue and acts as the mediator between the application and ActiveMQ. The `jackson-databind` dependency is for marshalling and unmarshalling the messages we will send. We will cover this later.

Right now the application will not compile because we are missing our Message object in the provided code. In our next step we'll fill in those required classes.

Click on the `Disk` icon to save the files or press `CTRL-S`:

![Visual Editor](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-messaging/save-pom-messaging-file.png)

## Congratulations

You have now successfully executed the first step in this scenario. In the next step we will setup the code necessary to send and receive JMS messages.
