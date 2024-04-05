---
slug: 01-create-project
id: ghga9mnfy7cx
type: challenge
title: Topic 1 - Getting Quarkus up and running
notes:
- type: text
  contents: |-
    This track demonstrates how Spring and Spring Boot developers can use Spring annotations for Spring Data, Web, and Dependency Injection when building Quarkus applications.

    |What you need to know before you start|
    |----|
    |In order to get full benefit from taking this track you should...<br>• Have experience programming applications in Java using the [Maven](https://maven.apache.org/) framework.<br>• Have a working knowledge of application programming using [Spring Boot](https://spring.io/projects/spring-boot). <br>• Some introductory experience creating Java/Maven applications using Quarkus|

    <br>

    Quarkus enables Spring developers to become productive quickly using their existing knowledge and familiarity of the Spring APIs.

    You'll build a simple application that uses Spring Data to integrate with an underlying database via JPA. Also. you'll inject beans using Spring DI and expose them as RESTful endpoints via Spring Rest.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
  cmd: /bin/bash
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/quarkus/
- title: Terminal 2
  type: terminal
  hostname: crc
  cmd: /bin/bash
difficulty: intermediate
timelimit: 800
---
# Inspecting the Java runtime

The Java Runtime, which is essential for both Quarkus and Spring Boot, has been preinstalled for use by all topics in this track. Let's start out by confirming that the runtime is installed.

----
`Step 1:` Run the following command in the **Terminal 1** window to the left to verify that Java is installed.

```
java --version
```

You'll get output similar to the following:

```
openjdk 17.0.6 2023-01-17
OpenJDK Runtime Environment Temurin-17.0.6+10 (build 17.0.6+10)
OpenJDK 64-Bit Server VM Temurin-17.0.6+10 (build 17.0.6+10, mixed mode, sharing)
```

If the command fails, wait a few moments and try again. (The Java Runtime is installed in a background process and make take a few moments depending on system load).


## Creating a basic project

Let's create the basic Quarkus **Hello World** application and include the necessary Spring extensions.

----

`Step 2:` Run the following command in **Terminal 1** to navigate to the working directory for the demonstration application

```
cd /root/projects/quarkus && pwd
```

You'll see the following ouput:

```
/root/projects/quarkus
```

----

`Step 3:` Run the following command in **Terminal 1** to create the demonstration project named **Fruit Taster**.

```
 mvn io.quarkus:quarkus-maven-plugin:3.9.2:create \
    -DprojectGroupId=org.acme \
    -DprojectArtifactId=fruit-taster \
    -Dextensions="spring-data-jpa,spring-web,spring-di,jdbc-postgres, jdbc-h2"
```

You will see a lot of output to the screen. At the end of the application creation process you'll see output similar to the following:

```
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

You've just created the demonstration project using the Quarkus Maven Plugin to generate a basic Maven project in the `fruit-taster` subdirectory. The project includes the following extensions to enable Spring annotations and APIs:

* **spring-data-jpa** - Adds Spring Data annotations such as `@CrudRepository` allowing integration with database-backed JPA repositories
* **spring-web** - Adds Spring Web annotations such as `@RestController`, `@RequestMapping`, `@PathVariable`, `@GetMapping`, etc
* **spring-di** - Adds Spring DI annotations such as `@Autowired`, `@Configuration`, `@Component`, etc
* **jdbc-postgres** - Driver for Postgresql database. Note this driver is the `jdbc` variant. Reactive programmers may be interested in the [Reactive Postgres Client](https://quarkus.io/guides/reactive-postgres-client).
* **jdbc-h2** - You will also use the h2 database for local development

## Starting the app

Once the demonstration project is created using Maven, it needs to be started.

----

`Step 4:` Run the following command in **Terminal 1** to start the demonstration application which is stored in the working directory, `/root/projects/quarkus/fruit-taster`. The application will start in **[Live Coding](https://quarkus.io/developer-joy/)** mode.


```bash
mvn quarkus:dev -Dquarkus.http.host=0.0.0.0 -Dquarkus.analytics.disabled=true -f /root/projects/quarkus/fruit-taster
```

Eventually you'll see output similar to the following:

```console
__  ____  __  _____   ___  __ ____  ______
 --/ __ \/ / / / _ | / _ \/ //_/ / / / __/
 -/ /_/ / /_/ / __ |/ , _/ ,< / /_/ /\ \
--\___\_\____/_/ |_/_/|_/_/|_|\____/___/
INFO  [io.quarkus] (Quarkus Main Thread) fruit-taster 1.0.0-SNAPSHOT on JVM (powered by Quarkus xx.xx.xx) started in xxxs. Listening on: http://0.0.0.0:8080
INFO  [io.quarkus] (Quarkus Main Thread) Profile dev activated. Live Coding activated.
INFO  [io.quarkus] (Quarkus Main Thread) Installed features: Installed features: [agroal, cdi, hibernate-orm, hibernate-orm-panache, jdbc-h2, jdbc-postgresql, narayana-jta, rest, rest-jackson, smallrye-context-propagation, spring-data-jpa, spring-di, spring-web, vertx]

--
Tests paused, press [r] to resume, [h] for more options>
```
|NOTE:|
|----|
|The first time you build the app, new dependencies may be downloaded via Maven. This should only happen once. After the initial download things will go even faster.|

----

`Step 5:` Click the **Terminal 2** tab on the horizontal menu bar over the terminal window to the left.

----

`Step 6:` Run the following command in **Terminal 2** to verify that the **Fruit Taster App** is running

```console
curl -w "\n" localhost:8080/greeting/
```

You will see the following output:

```
Hello Spring
```


The app is up and running.

**Congratulations!**

You just installed and run the demonstration app. However, the app doesn't use any Spring annotations yet.

----

**NEXT:** Adding data access to the demonstration application