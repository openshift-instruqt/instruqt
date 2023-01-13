---
slug: 01-review-the-initial-project
id: iztanwh3f8dh
type: challenge
title: Step 1
notes:
- type: text
  contents: |+
    In this scenario you will learn more about developing Spring Boot applications using the [Red Hat Runtimes](https://www.redhat.com/en/products/runtimes) platform. We will be building a simple Spring Boot application with a Database Persistence layer backed by Spring Data JPA and Hibernate.

tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 1000
---
# Import the code

Let's refresh the code we'll be using. Run the following command in Terminal 1 to clone the sample project:

```
cd /root/projects && rm -rf rhoar-getting-started && git clone https://github.com/openshift-katacoda/rhoar-getting-started && cd rhoar-getting-started/spring/spring-db-access
```

# Review the base structure of the application

For your convenience, this scenario has been created with a base project using the Java programming language and the Apache Maven build tool. Initially the project contains a couple web-oriented files which are out of scope for this module. See the Spring Rest Services module for more details. These files are in place to give a graphical view of the Database content.

As you review the content you will notice that there are a couple **TODO** comments. **Do not remove them!** These comments are used as markers for later exercises in this scenario.

In the next section we will add the dependencies and write the class files necessary to run the application.

# Inspect Java runtime

An appropriate Java runtime has been installed for you. Ensure you can use it by running this command:

```
java --version
```

The command should report the version in use, for example (the versions and dates may be slightly different than the below example):

```console
openjdk 11 2018-09-25
OpenJDK Runtime Environment 18.9 (build 11+28)
OpenJDK 64-Bit Server VM 18.9 (build 11+28, mixed mode)
```

If the command fails, wait a few moments and try again (it is installed in a background process and make take a few moments depending on system load).