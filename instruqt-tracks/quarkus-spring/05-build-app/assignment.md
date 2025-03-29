---
slug: build-app
id: 1enmycpmfhue
type: challenge
title: Topic 5 - Running the demonstration app in an executable JAR
notes:
- type: text
  contents: Topic 5 - Deploying the demonstration app in an executable JAR
tabs:
- id: lj5x4zd6dv9j
  title: Terminal 1
  type: terminal
  hostname: crc
  cmd: /bin/bash
- id: tliczeg9p17z
  title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/quarkus/fruit-taster
- id: 1fbvuxr1erub
  title: Terminal 2
  type: terminal
  hostname: crc
  cmd: /bin/bash
difficulty: intermediate
timelimit: 800
enhanced_loading: null
---
## Building an executable JAR

Quarkus applications can be built as executable JARs or native binary images. In this topic you'll create an executable JAR to deploy the demonstration application app.

----

`Step 1:` Run the following command in **Terminal 1** to package the demonstrations application

```bash
mvn clean package -DskipTests -f /root/projects/quarkus/fruit-taster
```

You'll see a lot of screen output. When `mvn clean package` completes you'll see output similar to the following:

```
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

----

`Step 2:` Run the following command in **Terminal 1** to get a list of the `.jar` file that were just created.

```
ls -l /root/projects/quarkus/fruit-taster/target/*.jar /root/projects/quarkus/fruit-taster/target/quarkus-app/*.jar
```

You'll see output similar to the following:

```
-rw-r--r--. 1 root root 13412 Apr  6 16:16 /root/projects/quarkus/fruit-taster/target/fruit-taster-1.0.0-SNAPSHOT.jar
-rw-r--r--. 1 root root   600 Apr  6 16:16 /root/projects/quarkus/fruit-taster/target/quarkus-app/quarkus-run.jar
```

**WHERE:**

* `target/fruit-taster-1.0.0-SNAPSHOT.jar` - contains just the classes and resources of the projects The SNAPSHOT .jar file is the regular artifact produced by the Maven build

* `target/quarkus-app/quarkus-run.jar` - is an executable jar. Be aware that `quarkus-run.jar` not an [über-jar](https://developers.redhat.com/blog/2017/08/24/the-skinny-on-fat-thin-hollow-and-uber) because the dependencies are copied into several subdirectories and would need to be included in any layered container image.

|NOTE:|
|----|
|Quarkus uses the `fast-jar` packaging by default. The fast-jar packaging format is introduced as an alternative to the default jar packaging format. The main goal of this new format is to introduce faster startup times to Maven build processes.

## Running the executable JAR

`Step 3:` Run the following command in **Terminal 1** to invoke the demonstration application using the `quarkus-run.jar`:

```
java -Dquarkus.http.port=8081 -jar /root/projects/quarkus/fruit-taster/target/quarkus-app/quarkus-run.jar
```

You'll see a lot of screen output. When the application is up and running you'll see:

```
_  ____  __  _____   ___  __ ____  ______
 --/ __ \/ / / / _ | / _ \/ //_/ / / / __/
 -/ /_/ / /_/ / __ |/ , _/ ,< / /_/ /\ \
--\___\_\____/_/ |_/_/|_/_/|_|\____/___/
2022-04-06 17:58:34,814 INFO  [io.quarkus] (main) fruit-taster 1.0.0-SNAPSHOT on JVM (powered by Quarkus xx.xx.xx) started in2.428s. Listening on: http://0.0.0.0:8081
2022-04-06 17:58:34,820 INFO  [io.quarkus] (main) Profile prod activated.
2022-04-06 17:58:34,820 INFO  [io.quarkus] (main) Installed features: [agroal, cdi, hibernate-orm, hibernate-orm-panache, jdbc-h2, jdbc-postgresql, narayana-jta, rest, rest-jackson, smallrye-context-propagation, spring-data-jpa, spring-di, spring-web, vertx]
```

You've just started the Fruit Tasting demonstration application from a JAR file that has the Quarkus extensions.

Let's confirm the that RESTful endpoints are functional.

----

`Step 4:` Click the **Terminal 2** tab on the horizontal menu bar over the terminal window to the left.

----

`Step 5:` Run the following command in **Terminal 2** to exercise the `/fruits` endpoint published by the demonstration application.

```
curl -s http://localhost:8081/fruits | jq
```

You'll get the following output

```json
[
  {
    "id": 1,
    "name": "cherry",
    "color": "red"
  },
  {
    "id": 2,
    "name": "orange",
    "color": "orange"
  },
  {
    "id": 3,
    "name": "banana",
    "color": "yellow"
  },
  {
    "id": 4,
    "name": "avocado",
    "color": "green"
  },
  {
    "id": 5,
    "name": "strawberry",
    "color": "red"
  }
]
```

## Congratulations!

You've now built and deployed a Java application as an executable JAR. Also, you exercised a RESTful endpoint published by the application. Next, let's give the demonstration application native capabilities by creating a Quarkus native app into Red Hat OpenShift.

----

**NEXT:** Creating a Quarkus native app running in OpenShift
