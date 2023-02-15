---
slug: 03-add-query-endpoints
id: hrbr5kyx0szd
type: challenge
title: Topic 3 - Adding reactive queries to the Person entity
notes:
- type: text
  contents: Topic 3 - Adding reactive queries to the Person entity
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Terminal 2
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/quarkus/panache-reactive
difficulty: basic
timelimit: 500
---
In the previous topic you created a basic RESTful Java application with Quarkus and a single Panache-based query in the `PersonResource.java` file. In this topic you'll add a few more queries to demonstrate the reactive nature of Panache queries vs. ordinary Hibernate/JQL queries.

# Establishing a remote dev connection

`Step 1:` Run the following command in **Terminal 1** to run the demonstration application in dev mode and connect it to the remote application running of OpenShift:

```
mvn quarkus:remote-dev -Dquarkus.live-reload.url=$APP_URL -f /root/projects/rhoar-getting-started/quarkus/panache-reactive
```

You'll see continuous screen output in **Terminal 1** as shown below:

```console
Listening for transport dt_socket at address: 5005
2022-06-01 17:51:27,854 INFO  [org.jbo.threads] (main) JBoss Threads version 3.4.0.Final
[INFO] Checking for existing resources in: /root/projects/rhoar-getting-started/quarkus/panache-reactive/src/main/kubernetes.
2022-06-01 17:51:30,054 INFO  [io.qua.dep.QuarkusAugmentor] (main) Quarkus augmentation completed in 2745ms
2022-06-01 17:51:31,903 INFO  [io.qua.ver.htt.dep.dev.HttpRemoteDevClient] (Remote dev client thread) Sending lib/deployment/appmodel.dat
2022-06-01 17:51:31,929 INFO  [io.qua.ver.htt.dep.dev.HttpRemoteDevClient] (Remote dev client thread) Sending quarkus-run.jar
```
The **Terminal 1** console window is now dedicated to running the demonstration application locally in `dev mode`.

You'll use **Terminal 2** to execute command line instructions in the console moving forward.

Because Live Coding is in force, any changes you make locally will be reflected immediately in the remote instance of the application running on OpenShift.

## Adding reactive queries

You are now going to add some reactive queries to the `Person` entity. The reason you are adding the queries directly into the entity is because Panache and Quarkus advocate a best practice in which you place custom entity queries as close to the entity definition as possible. In this case, the closest placement is to put the queries in the `Person.java` file.

----

`Step 2a:` In the **Visual Editor** tab, navigate to the folder `src/main/java/org/acme/person/model/` and click on the file `Person.java` to open it for editing as shown in the figure below.

![Open person.java](../assets/open-person-java-02.png)

`Step 2b:` Add the following two new queries after the comment `// TODO: Add more queries` beneath `LINE 36` in the `Person.java` file:

```java
    public static Uni<List<Person>> findByColor(EyeColor color) {
          return list("eyes", color);
    }

    public static Multi<Person> getBeforeYear(int year) {
          return Person.<Person>streamAll()
            .filter(p -> p.birth.getYear() <= year);
    }
```

`Step 2c:` Click on the `Disk` icon or press `CTRL+S` to save the contents of `Person.java`.

**UNDERSTANDING REACTIVE QUERIES**

The query `findByColor(EyeColor color)` retrieves a list of people based on eye color from the demonstration application's database. The query `getBeforeYear(int year)` gets a list of people that have birthdays on or before a particular birth year.

Notice that `getBeforeYear` is implemented using the [Java Streams API](https://docs.oracle.com/javase/8/docs/api/java/util/stream/package-summary.html).

All list methods in Panache-based entities (those that extend from `PanacheEntity`) have equivalent stream versions. So `list` has a `stream` variant, `listAll`-->`streamAll` and so on.

Now that the custom entity queries have been implemented in the `Person` entity class, you need to add RESTful endpoints to `PersonResource` to access those queries.

# Adding endpoints to the demonstration application's RESTful API

`Step 3a:` In the **Visual Editor** tab, navigate to the folder `src/main/java/org/acme/person/` and click on the file `PersonResource.java` to open it for editing as shown in the figure below.

![Reopen PersonResource](../assets/reopen-personresource-java.png)

`Step 3b:` Add the following code to the file `PersonResource.java` after the comment `// TODO: add basic queries` after `LINE 37`:

```java
    @GET
    @Path("/eyes/{color}")
    @Produces(MediaType.APPLICATION_JSON)
    public Uni<List<Person>> findByColor(@PathParam("color") EyeColor color) {
        return Person.findByColor(color);
    }

    @GET
    @Path("/birth/before/{year}")
    @Produces(MediaType.APPLICATION_JSON)
    public Multi<Person> getBeforeYear(@PathParam("year") int year) {
        return Person.getBeforeYear(year);
    }
```

`Step 3c:` Click on the `Disk` icon or press `CTRL+S` to save the contents of `PersonResource.java`.

**IMPORTANT CONCEPTS TO UNDERSTAND**

The code shown above in `Step 4b` uses `Uni<T>` and `Multi<T>` types. These types are defined in the [Mutiny library](https://javadoc.io/doc/io.smallrye.reactive/mutiny/latest/index.html). They are intended to support data streams in an asynchronous, reactive manner. Once declared, `Uni<T>` and `Multi<T>` do the work of establishing and managing the internal asynchronous pipelines. All the developer needs to be concerned with is the data that's emitted from the pipeline.

## Inspecting the results

When you make these changes, Quarkus will notice all of them and live reload them across the remote connection.

Check that the remote update works as expected by testing the new endpoints. You'll find all of the people with `BLUE` eyes.

First you'll need to redefine the environment variable `$APP_URL` you used in previous topic, in order to get access to the application's RESTful API using `curl` within the **Terminal 2** console window.

----

`Step 4:` Run the following command in **Terminal 2** to call the RESTful endpoint that returns `Person` data according to the eye color `BLUE`:

```
curl -s "$APP_URL/person/eyes/BLUE" | jq
```

You will see **one** person with BLUE eyes:

```console
[
  {
    "id": 1,
    "birth": "1974-08-15",
    "eyes": "BLUE",
    "name": "Farid Ulyanov"
  }
]
```

This output also confirms that our remote live coding is working as expected.

----

`Step 5:` Run the following command in **Terminal 2** to call the RESTful endpoint that returns people born in the year 1990 or earlier:

```
curl -s "$APP_URL/person/birth/before/1990" | jq
```

You will see **two** people born in 1990 or earlier:

```console
[
  {
    "id": 1,
    "birth": "1974-08-15",
    "eyes": "BLUE",
    "name": "Farid Ulyanov"
  },
  {
    "id": 2,
    "birth": "1984-05-24",
    "eyes": "BROWN",
    "name": "Salvador L. Witcher"
  }
]
```

The `Person` entity's superclass is `PancheEntity`. `PancheEntity`. comes with many useful static methods that you can add into your entity class.


## Congratulations!

In this topic you got the demonstration application up and running to take advantage of Live Coding. Also you added code to the `PersonResource.java` and `Person.java` classes in order to support addition reactive queries.

In the next topic you'll learn how Panache Reactive can be applied to entities that are used by high performance front-ends, even in the face of hundreds of thousands, even millions of records.

----

**NEXT:** Adding paging and filtering to the demonstration application