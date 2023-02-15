---
slug: 03-add-query-endpoints
id: ulgrpbliyx9q
type: challenge
title: Topic 3 - Adding queries to the source code of the demonstration project
teaser: Learn how to add database queries to Java data entities in the demonstration
  project
notes:
- type: text
  contents: Topic 3 - Adding queries to the source code of the demonstration project
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/quarkus/panache
- title: Terminal 2
  type: terminal
  hostname: crc
difficulty: basic
timelimit: 300
---
In the previous topic you created a basic RESTful Java application with Quarkus. Also, you created a single Panache-based query.

In this topic, you'll add a few more queries to the demonstration application in order to demonstrate the ease of implementing Panache queries.

# Creating a remote dev connection

Now you are ready to run your programming environment in development mode and connect the local environment to the remote application running in the OpenShift cluster.

----

`Step 1:` Run the following code in **Terminal 1:** to have the Quarkus plugin bind to the remote application:

```
mvn quarkus:remote-dev -Dquarkus.live-reload.url=$APP_URL -f /root/projects/rhoar-getting-started/quarkus/panache
```

There will be some screen output. Then, the application will start running continuously in the **Terminal 1** console window.

Eventually you will see log output in the **Terminal 1** console similar to the following:

```console
[INFO] Checking for existing resources in: /root/projects/rhoar-getting-started/quarkus/panache/src/main/kubernetes.
2023-02-15 16:19:44,375 INFO  [io.qua.dep.QuarkusAugmentor] (main) Quarkus augmentation completed in 4006ms
2023-02-15 16:19:46,325 INFO  [io.qua.ver.htt.dep.dev.HttpRemoteDevClient] (Remote dev client thread) Sending quarkus-run.jar
2023-02-15 16:19:46,342 INFO  [io.qua.ver.htt.dep.dev.HttpRemoteDevClient] (Remote dev client thread) Sending app/people-1.0-SNAPSHOT.jar
2023-02-15 16:19:46,349 INFO  [io.qua.ver.htt.dep.dev.HttpRemoteDevClient] (Remote dev client thread) Connected to remote server
```

Your instance of the Quarkus demonstration application running locally is now connected to the remote instance that's running within the OpenShift cluster.

The Live Code Quarkus feature makes it so that changes that you make in the local application instance will cascade immediately into the remote application in OpenShift. Cool!

Leave this connection up and running in **Terminal 1**. Live ccode will use the connection in the next step.

# Adding more queries

Let’s modify the application by adding some additional queries.

Much like the best practice in object-oriented programming, Panache and Quarkus recommend that you place your custom entity queries as close to the entity definition as possible. In this case, the closest place to put queries is in the entity definition itself. Thus, you'll place the additional queries in the `Person` entity bean.

----

`Step 2a:` Go to **Visual Editor** tab and navigate to the directory, `src/main/java/org/acme/person/model/` as shown in the figure below.

![Select Person](../assets/selected-person-model.png)

`Step 2b:` Click on the file named `Person.java` to open it for editing.

`Step 2c:`

Add the following two new queries after the comment line `// TODO: Add more queries`:

```java
    public static List<Person> findByColor(EyeColor color) {
        return list("eyes", color);
    }

    public static List<Person> getBeforeYear(int year) {
        return Person.<Person>streamAll()
        .filter(p -> p.birth.getYear() <= year)
        .collect(Collectors.toList());
    }
```

----

`Step 3:` Save the file `Person.java` by clicking the `Disk` icon or pressing the `CTRL+S` keys.

One query shown above `findByColor(EyeColor color)` finds a list of people in the database according to eye color. The other query,  `getBeforeYear(int year)` finds list of people at or before a particular birth year.

NOTE: All list methods in Panache-based entities that extend from `PanacheEntity` have equivalent stream versions. Thus, `list` has a `stream` variant and `listAll`-->`streamAll`, for example.

You just implemented custom queries in the `Person` entity bean. Next, let's add RESTful endpoints to `PersonResource` in order to access these queries.

----

`Step 4a:` Open the file `src/main/java/org/acme/person/PersonResource.java` in the Visual Editor.

`Step 4b:` Add the code below after the comment line  `// TODO: add basic queries`:

```java
    @GET
    @Path("/eyes/{color}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Person> findByColor(@PathParam(value = "color") EyeColor color) {
        return Person.findByColor(color);
    }

    @GET
    @Path("/birth/before/{year}")
    @Produces(MediaType.APPLICATION_JSON)
    public List<Person> getBeforeYear(@PathParam(value = "year") int year) {
        return Person.getBeforeYear(year);
    }
```

----

`Step 5:` Save the file `PersonResource.java` by clicking the `Disk` icon or pressing the `CTRL+S` keys.

You have now added two new endpoints to the demonstration application's RESTful API. The endpoints are `/eyes/{color}` and `/birth/before/{year}`.

Let's exercise these new endpoints.

# Inspecting the results

As mentioned in previous topics, Quarkus notices all of the changes made to a project's source code. When a change is made, Quarkus Live Coding cascades the changed code into the application's remote instance in the OpenShift cluster.

Let's exercise live coding by conducting an informal test that verifies that the new endpoints work as expected.

You're going to use the **Terminal 2** console to exercise the new endpoints because the **Terminal 1** console is running the local instance of the demonstration application.

----

`Step 5a:` Click the **Terminal 2** tab on the horizontal menu bar over the interactive window to the left.

`Step 5b:` Run the following command in the **Terminal 2** window. The command executes a `curl` command against the demonstration application's RESTful endpoint that retrieves people according to eye color. In this case, you're retrieving people with `BLUE` eyes:

```console
curl -s $APP_URL/person/eyes/BLUE | jq
```

You will see only one person with BLUE eyes:

```json
[
  {
    "id": 1,
    "birth": "1974-08-15",
    "eyes": "BLUE",
    "name": "Farid Ulyanov"
  }
]
```
Executing the `curl` command confirms that the live coding is working as expected.

----

`Step 6:` Run the following code in the **Terminal 2** window to retrieve people born in 1990 or earlier:

```
curl -s $APP_URL/person/birth/before/1990 | jq
```

You will see 2 people born in 1990 or earlier:

```json
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

Again, as you can see, the new endpoints are working as expected.

# Congratulations!

In this topic you inserted additional code that extended the `Person` model and added two new endpoints to the demonstration application's RESTful API.

In the next topic you'll learn how Panache can provide paging and filtering capabilities that create high performance front-ends, even when having to process thousands of records.

----

**NEXT:** Adding paging and filtering capabilities to the demonstration application