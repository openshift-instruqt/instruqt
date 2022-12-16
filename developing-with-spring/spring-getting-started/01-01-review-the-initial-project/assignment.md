---
slug: 01-review-the-initial-project
id: xapvoenkbw0f
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    In this scenario, you will learn more about developer application using Spring Boot using [Red Hat Runtimes](https://www.redhat.com/en/products/runtimes).

    ## What you will learn
    You will learn how to get started with building a CRUD (Create, Read, Update and Delete) web application.

    ## How is Spring Boot supported on OpenShift?

    Spring is one of the most popular Java Frameworks and offers an alternative to the Java EE programming model. Spring is also very popular for build application based on Microservices Architecture. Spring Boot is a popular tool in the Spring eco system that helps with organizing/using 3rd party libraries together with Spring and also provides a mechanism for boot strapping embeddable runtimes, like Apache Tomcat. Bootable applications (sometimes also called fat jars) fits the container model very well since in a container platform like OpenShift responsibilities like starting, stopping and monitoring applications are then handled by the container platform instead of an Application Server.

    Red Hat fully supports Spring and Spring Boot for usage on the OpenShift platform as part of Red Hat Runtimes. Red Hat also provides full support for Apache Tomcat, Hibernate and Apache CXF (for REST services) when used in a Spring Boot application on Red Hat Runtimes.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/spring-rhoar-intro
- title: Fruit App
  type: service
  hostname: crc
  path: /
  port: 8080
difficulty: basic
timelimit: 600
---
# Import the code

Let's refresh the code we'll be using. Run the following command to clone the sample project in Terminal 1:

```
cd /root/projects && rm -rf rhoar-getting-started && git clone https://github.com/openshift-katacoda/rhoar-getting-started && cd rhoar-getting-started/spring/spring-rhoar-intro
```

# Review the base structure of the application

For your convenience, this scenario has been created with a base project using the Java programming language and the Apache Maven build tool.

Initially, the project is almost empty and doesn't do anything. Start by reviewing the content by executing from the *Visual Editor* Tab.


As you can see, there are some files that we have prepared for you in the project. Under src/main/resources/index.html we have, for example, prepared an HTML file for you. Except for the jkube directory and the index.html, this matches very well what you would get if you generate an empty project from the [Spring Initializr](https://start.spring.io) web page. For the moment you can ignore the content of the jkube folder (we will discuss this later).

One that differs slightly is the `pom.xml`. Please open the and examine it a bit closer (but do not change anything at this time)

``pom.xml``

As you review the content, you will notice that there are a lot of **TODO** comments. **Do not remove them!** These comments are used as a marker and without them, you will not be able to finish this scenario.

Notice that we are not using the default BOM (Bill of material) that Spring Boot project typically use. Instead, we are using a BOM provided by Red Hat as part of the [Snowdrop](http://snowdrop.me/) project.

```xml
  <dependencyManagement>
    <dependencies>
      <dependency>
        <groupId>me.snowdrop</groupId>
        <artifactId>spring-boot-bom</artifactId>
        <version>${spring-boot.bom.version}</version>
        <type>pom</type>
        <scope>import</scope>
      </dependency>
    </dependencies>
  </dependencyManagement>
```

We use this bill of material to make sure that we are using the version of for example Apache Tomcat that Red Hat supports.

**1. Adding web (Apache Tomcat) to the application**

Since our applications (like most) will be a web application, we need to use a servlet container like Apache Tomcat or Undertow. Since Red Hat offers support for Apache Tomcat (e.g., security patches, bug fixes, etc.), we will use it.

>**NOTE:** Undertow is another an open source project that is maintained by Red Hat and therefore Red Hat plans to add support for Undertow shortly.


To add Apache Tomcat to our project all we have to do is to add the following lines in `pom.xml` at the `<!-- TODO: Add web (tomcat) dependency here pass:[-->]` marker in Visual Editor:

```xml
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-web</artifactId>
    </dependency>
```

Click on the `Disk` icon to save the files or press `CTRL-S`:

![Visual Editor](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-getting-started-spring/save-pom-file.png)

**2. Test the application locally**

As we develop the application, we might want to test and verify our change at different stages. We can do that locally, by using the `spring-boot` maven plugin.

Run the application by executing the below command in Terminal 1:

```
mvn spring-boot:run
```

>**NOTE:** The Katacoda terminal window is like your local terminal. Everything that you run here you should be able to execute on your local computer as long as you have a `Java JDK 11` and `Maven`. In later steps, we will also use the `oc` command line tool.

**3. Verify the application**

To begin with, open the app from the *Fruit App* Tab.

You should now see an HTML page that looks like this:

![Local Web Browser Tab](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-getting-started-spring/web-page.png)

As you can probably guess by now the application we are building is a Fruit repository where we create, read, update and delete different kinds of fruits.


> **NOTE:** None of the button works at this stage since we haven't implemented services for them yet, but we will shortly do that.

## Congratulations

You have now successfully executed the first step in this scenario.

Now you've seen how to get started with Spring Boot development on Red Hat OpenShift Application Runtimes

In next step of this scenario, we will add the logic to be able to read a list of fruits from the database.

Make sure to stop the Spring Boot app via pressing `CTRL-C` in Terminal 1.
