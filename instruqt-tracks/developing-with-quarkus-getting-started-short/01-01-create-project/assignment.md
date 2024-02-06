---
slug: 01-create-project
id: ia8vpw1gqjex
type: challenge
title: Topic 1 - Getting started with a Quarkus Project
teaser: Topic 1 - Getting started with a Quarkus Project
notes:
- type: text
  contents: |-
    In this track, you will get an introduction to [Quarkus](https://quarkus.io).

    |What you need to know before you start:|
    |----|
    |In order to get full benefit from taking this track you should...<br>• Have experience programming applications in Java using the [Maven](https://maven.apache.org/) framework.<br>• Understand how Maven uses the Project Object Model (POM) to manage artifacts and plugins.<br>• Know how Maven applications are described and built using a Maven [`pom.xml`](https://maven.apache.org/guides/introduction/introduction-to-the-pom.html) file.|

    <br>

    # What is Quarkus?

    Quarkus is a Kubernetes Native Java stack tailored for [GraalVM](https://www.graalvm.org/) and [OpenJDK HotSpot](https://openjdk.java.net/groups/hotspot/). Quarkus is also crafted from the best of breed Java libraries and standards. Amazingly fast boot time, incredibly low RSS memory (not just heap size!) offering near instant scale up and high density memory utilization in container orchestration platforms like Kubernetes. Quarkus uses a technique called compile time boot. [Learn more](https://quarkus.io/vision/container-first).

    Quarkus maximizes the Developer Productivity with the following features:
    * [Zero-config Live coding](https://quarkus.io/guides/maven-tooling#dev-mode/)
    * [Dev Services](https://quarkus.io/guides/dev-services)
    * [Continuous testing](https://quarkus.io/guides/continuous-testing)
    * [Dev UI](https://quarkus.io/guides/dev-ui)
    * [Command Line Interface (CLI)](https://quarkus.io/guides/cli-tooling)
    * [Remote Development](https://quarkus.io/guides/maven-tooling#remote-development-mode)

    Application requirements have changed over the last few years. For any application to succeed in the era of big data, IoT or cloud computing, adhering to the principles and practices of the [reactive architecture style](https://developers.redhat.com/coderland/reactive/reactive-intro) is essential.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/quarkus
- title: Terminal 2
  type: terminal
  hostname: crc
- title: Dev UI
  type: service
  hostname: crc
  path: /q/dev
  port: 8080
difficulty: basic
timelimit: 600
---
# Getting Started with Quarkus
In this topic you will use Quarkus to create an API application that publishes a `/hello` endpoint. Also, you will use dependency injection to build on the `/hello` endpoint to publish an additional endpoint `/hello/greeting` by creating a **Greeting** bean.

The Maven project you're going to create has the following structure:
* An `org.acme.quickstart.GreetingResource` resource exposed on `/hello`
* An associated unit test
* A landing page that is accessible on `http://localhost:8080` after starting the application
* An example `Dockerfile`s for a variety of build targets (native, jvm, etc)
* The application configuration file

# Creating a basic project using Quarkus

`Step 1:` Run the following command in the **Terminal 1** window to the left to go to the working directory for the Quarkus application you're going to create. (The directory was created as part of the tracks setup process.)

```
cd /root/projects/quarkus/ && pwd
```

You'll get the following output.

```
/root/projects/quarkus/
```

----

`Step 2:` Run the following command in the **Terminal 1** window to create the basic Maven project.

```
mvn io.quarkus:quarkus-maven-plugin:2.16.2.Final:create \
    -DprojectGroupId=org.acme \
    -DprojectArtifactId=getting-started \
    -DclassName="org.acme.quickstart.GreetingResource" \
    -Dpath="/hello"
```

The `mvn` command shown above invokes the installation process that creates all the files and artifacts needed to get the application up and running.

The snippet of code below shows you the output you'll get at the end of the installation process. The date information will be different in your output.

```
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

# Up Next

In the next step, you'll learn how to run the Quarkus application, as well as some development features that Quarkus provides.