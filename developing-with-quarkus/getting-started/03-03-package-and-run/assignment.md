---
slug: 03-package-and-run
id: hqbxyieiepx1
type: challenge
title: Topic 3 - Packaging a custom bean in to a .jar file
teaser: Topic 3 - Packaging a custom bean in to a .jar file
notes:
- type: text
  contents: Topic 3 - Packaging a custom bean in to a .jar file
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/quarkus/getting-started
- title: Terminal 2
  type: terminal
  hostname: crc
difficulty: basic
timelimit: 500
---
In the previous step you added a custom CDI bean to the app. Now you're going to package and run the bean as a self-contained JAR file.

# Packaging the application into a self-container JAR file

`Step 1:` Run the following command in **Terminal 1** to package the application.

```
mvn package -f /root/projects/quarkus/getting-started
```

When you run the command above you'll see a lot of screen output. You'll get output similar to the following.

```console
INFO] Building jar: /root/projects/quarkus/getting-started/target/getting-started-1.0.0-SNAPSHOT.jar
[INFO]
[INFO] --- quarkus-maven-plugin:2.0.0.Final:build (default) @ getting-started ---
[INFO] [org.jboss.threads] JBoss Threads version 3.4.0.Final
[INFO] [io.quarkus.deployment.QuarkusAugmentor] Quarkus augmentation completed in 2979ms
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  28.818 s
[INFO] Finished at: 2022-04-01T16:02:41Z
[INFO] ------------------------------------------------------------------------
```

Running the command above produces two `.jar` files:

* `target/getting-started-1.0.0-SNAPSHOT.jar` - contains just the classes and resources of the projects along with the regular artifact produced by the Maven build

* `target/quarkus-app/quarkus-run.jar` is the executable jar. Be aware that `target/quarkus-app/quarkus-run.jar` is not an [über-jar](https://access.redhat.com/documentation/en-us/red_hat_build_of_quarkus/1.3/html/getting_started_with_quarkus/proc-quarkus-packaging_quarkus-getting-started) because the dependencies are copied into several subdirectories that would need to be included in any layered container image.

----

`Step 2:` Go to **Terminal 1** and run the following command in the terminal window.

```
cd /root/projects/quarkus/getting-started/ && ls -l target/*.jar target/quarkus-app/*.jar
```

You see output similar to following:

```
-rw-r--r--. 1 root root 5817 Apr  1 19:06 target/getting-started-1.0.0-SNAPSHOT.jar
-rw-r--r--. 1 root root 5322 Apr  1 19:01 target/getting-started-dev.jar
-rw-r--r--. 1 root root  619 Apr  1 19:06 target/quarkus-app/quarkus-run.jar
```

Notice that the output above shows the two `.jar` files just discussed.

|NOTE:|
|----|
|Quarkus uses the [fast-jar packaging](https://developers.redhat.com/blog/2021/04/08/build-even-faster-quarkus-applications-with-fast-jar) by default. The fast-jar packaging format is introduced as an alternative to the default jar packaging format. The main goal of this new format is to facilitate faster startup times.

# Running the executable JAR

`Step 3`: Run the following command in **Terminal 1** to invoke the packaged application as represented by the `quarkus-run.jar` file.

```
java -jar target/quarkus-app/quarkus-run.jar
```

----

`Step 4`: Click the **Terminal 2** tab on the horizontal menu bar over the terminal window on the left.

----

`Step 5`: Run the following command in **Terminal 2** to exercise the endpoint `/hello/greeting/quarkus`.

```
curl -w "\n" localhost:8080/hello/
```

You will see the following output

```
Hello RESTEasy
```
Note that the endpoint uses the same hostname as before. Also note that since you're running the application as a fast-jar, Quarkus runs in production mode and does not enable continuous testing or other developer features.

|NOTE:|
|----|
|The `Class-Path` entry in the `MANIFEST.MF` within the **runner jar** explicitly lists the jar files of the subdirectories under `target/quarkus-app`.<br>If you want to deploy your application to use another location you need to copy the **runner jar** as well as the folder structure under the `target/quarkus-app` directory. If you want to create an [Uber-jar](https://access.redhat.com/documentation/en-us/red_hat_build_of_quarkus/1.3/html/getting_started_with_quarkus/proc-quarkus-packaging_quarkus-getting-started) with everything included, you can use the command `mvn package -DuberJar`.|

# Cleaning up your work

`Step 6`: Go back to **Terminal 1**, click in the terminal window and press the `CTL+C` keys at the terminal command prompt. The demonstration application will stop.

# Congratulations!

You've packaged up the demonstration application as an executable JAR. Also, you learned a bit more about the mechanics of packaging. In the next step, you'll continue your journey and build a native executable. Then you'll learn the details about creating and packaging  a native executable into a Linux container.

-----

**NEXT:** Creating a native executable