---
slug: 01-review-the-initial-project
id: fllsmefecexx
type: challenge
title: Step 1
notes:
- type: text
  contents: |+
    In this scenario you will learn more about developing Spring Boot applications using the [Red Hat Runtimes](https://www.redhat.com/en/products/runtimes) platform. We will be building a RESTful application using Spring Rest.

tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/spring-rest-services
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
cd /root/projects && rm -rf rhoar-getting-started && git clone https://github.com/openshift-katacoda/rhoar-getting-started && cd rhoar-getting-started/spring/spring-rest-services
```

# Get project set up

**1. Adding Spring MVC and Tomcat to the application**

Since our application will be a web application, we need to use a servlet container like Apache Tomcat or Undertow to handle incoming connections from clients. Since Red Hat offers support for Apache Tomcat (e.g., security patches, bug fixes, etc.), we will use it here.

In addition we are going to utilize the Spring MVC project which contains many of the abstractions we will use to build our APIs. Observe the following code block in the `pom.xml` in Visual Editor.

```xml
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
```

You may notice that there is no `<version>` tag here. That's because the version numbers are managed and automatically derived by the BOM mentioned in the previous trainings.

**2. Test the application locally**

Run the application by executing the following command in Terminal 1:

```
mvn spring-boot:run
```

You should eventually see a log line like `Started Application in 4.497 seconds (JVM running for 9.785)`. Open the application by clicking on the *Fruit App* Tab. Then stop the application by pressing **<kbd>CTRL</kbd>+<kbd>C</kbd>**.

## Congratulations

You have now successfully executed the first step in this scenario.
