---
slug: 01-add-extension
id: a4g31p1707dx
type: challenge
title: Topic 1 - Initializing the demonstration application
notes:
- type: text
  contents: |-
    In this track, you will get an introduction to the reactive programming model of Quarkus

    |What you need to know before you start|
    |----|
    |In order to get full benefit from taking this track you should...<br>• Have experience programming applications in Java using the [Maven](https://maven.apache.org/) framework.<br>• Have a working knowledge using Java annotations.<br>• Have a working knowledge of working with [Object Relational Mapping](https://en.wikipedia.org/wiki/Object%E2%80%93relational_mapping) (ORM) technology to enable Java code to interact with a database.<br>• Have a basic familiarity with Quarkus as demonstrated in this [Getting Started](https://learn.openshift.com/middleware/courses/middleware-quarkus/getting-started) scenario.|

    # Quarkus Unifies Imperative and Reactive Programming

    Application requirements have changed drastically over the last few years. For any application to succeed in the era of cloud computing, big data or IoT, [going reactive](https://developers.redhat.com/blog/2017/06/30/5-things-to-know-about-reactive-programming) is becoming the architecture style to follow.

    Quarkus combines both imperative coding and the non-blocking reactive styles for developing applications.

    Quarkus uses [Vert.x](https://vertx.io/docs/vertx-pg-client/java/) and [Netty](https://netty.io/) at its core. And uses a bunch of reactive frameworks and extensions on top to enable the developers. Quarkus is not just for HTTP microservices, but also for event-driven architectures. The secret behind this is to use a single reactive engine that supports both imperative and reactive code.

    ![Reactive](../assets/vert-x-arch.png)

    Quarkus is intended to support both imperative and reactive coding. Quarkus HTTP support is based on a non-blocking and reactive engine (Eclipse Vert.x and Netty). All the HTTP requests an application receives are handled by event loops on the IO Thread. Requests are then routed towards the code that manages the request. Depending on the destination, the request can invoke the code managing the request on a worker thread via the Servlet/Jax-RS or use the reactive route IO Thread.

    In this track you'll 'create a `Coffee Resource` endpoint by using JAX-RS with Quarkus backed by the Reactive SQL drivers. The demonstration application uses the PostgreSQL Reactive SQL Driver. You'll add methods for listing, adding and removing items from a list of coffee types.

    # Reactive SQL
    Historically, relational databases have not been reactive. However in recent years, advances have been made in database architecture. Today, data access via JSC can now be done reactively.

    Some of the advantages of using reactive SQL with Quarkus are:
    - A simple API focusing on scalability and low overhead.
    - Reactive and non-blocking I/O which are able to handle many database connections with a single thread.

    Learn more at [quarkus.io](https://quarkus.io)
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects
difficulty: basic
timelimit: 240
---
# Inspecting the Java runtime

`Step 1:` The Java runtime (JRE) is preinstalled in the track. Verify that the JRE is properly installed by running the following command in the **Terminal 1** console to the left:

```
$JAVA_HOME/bin/java --version
```

You get output similar to the following:

```
openjdk 11 2018-09-25
OpenJDK Runtime Environment 18.9 (build 11+28)
OpenJDK 64-Bit Server VM 18.9 (build 11+28, mixed mode)
```

|NOTE:|
|----|
|If the command fails, wait a few moments and try again (it is installed in a background process and make take a few moments depending on system load.|


## Importing the code

Next, install the source code for the demonstration application.

----

`Step 2:` Run the following command in **Terminal 1** to clone the sample project into the interactive learning environment:

```
cd /root/projects && rm -rf rhoar-getting-started && git clone https://github.com/openshift-katacoda/rhoar-getting-started
```

You'll get the following output:

```
Cloning into 'rhoar-getting-started'...
remote: Enumerating objects: 2572, done.
remote: Counting objects: 100% (122/122), done.
remote: Compressing objects: 100% (59/59), done.
remote: Total 2572 (delta 95), reused 63 (delta 63), pack-reused 2450
Receiving objects: 100% (2572/2572), 1.04 MiB | 16.69 MiB/s, done.
Resolving deltas: 100% (893/893), done.
```

# Understanding the demonstration project

The demonstration application is a CRUD app that has a front end that lists different types of coffee and provides options to remove and add more a coffee type.

Access to the different coffee types is facilitated in code using a `CoffeeResource`. You'll add code to the `CoffeeResource` to enable access to the demonstration application as a RESTful API. The endpoints in the RESTful API will be implemented as [JAX-RS](https://www.oracle.com/technical-resources/articles/java/jax-rs.html) methods.

On the back end, you'll use a [PostgreSQL](https://www.postgresql.org/) database that stores the coffee data for reading and writing.

The demonstration application uses [Mutiny](https://smallrye.io/smallrye-mutiny/). Mutiny is an event-driven reactive programming library for Java. You'll use Mutiny to observe events and react to them. Mutiny is intended to support asynchronous programming and non-blocking I/O.

You'll use Mutiny as a reactive PostgresSQL client.

|NOTE|
|----|
|To learn more about reactive programming under Quarkus, read the [Getting Started with Reactive guide](https://quarkus.io/guides/getting-started-reactive#mutiny).|

The demonstration application ships with bare bones code you will build throughout the track. You'll start with a basic Maven-based application that has the usual `pom.xml` entries for a Quarkus application. Also, a front-end HMTL file that shows the list of coffee types is located at `src/main/resources/META-INF/resources/index.html`.


# Adding the Reactive PostgresSQL extension

As mentioned above, PostgresSQL is the database used on the back end to store coffee type data. Also, the demonstration will use the reactive PostgresSQL client extension for Quarkus.

----

`Step 3:` Run the following command in **Terminal 1** to add the PostgresSQL client extension for Quarkus to the demonstration application.

```
mvn quarkus:add-extension -Dextensions="reactive-pg-client" -f /root/projects/rhoar-getting-started/quarkus/reactive-sql
```

You will see a good deal of output on the screen. You'll see the following output when the installation process completes:

```
INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  11.349 s
[INFO] Finished at: 2022-05-17T18:24:51Z
[INFO] ------------------------------------------------------------------------
```

|NOTE:|
|----|
|The first time you add the extension, new dependencies might be downloaded via Maven. This should only happen once, after that things will go faster.|

Executing the command shown above will add the necessary entries in the demonstration application's `pom.xml` file, like so:

```xml
<dependency>
    <groupId>io.quarkus</groupId>
    <artifactId>quarkus-reactive-pg-client</artifactId>
</dependency>
```

The addition to `pom.xml` brings the Reactive PostgreSQL extension into the Maven environment.

There are a few other extensions that are already part of the `pom.xml` file. For example, `resteasy-jackson` is used for encoding Java objects as JSON objects.

**Congratulations:**

You've initialized the demonstration application.

----

**NEXT:** Deploying the demonstration application and database into Red Hat OpenShift
