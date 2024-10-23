---
slug: 04-add-model
id: yvk6uux5dqrw
type: challenge
title: Topic 4 - Modifying the Coffee class
notes:
- type: text
  contents: Topic 4 - Modifying the Coffee class
tabs:
- id: wxnxbpwbz4rz
  title: Terminal 1
  type: terminal
  hostname: crc
- id: xt5y5xdxowjt
  title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/quarkus/reactive-sql
difficulty: basic
timelimit: 240
---
Previously you added coffee type data to the PostgresSQL database. Also, you created `GET`, `POST`, `PUT` and `DELETE` endpoints to the demonstration application.

In this topic you will build out the `Coffee` class by inserting a method that will retrieve a particular coffee type according to a specific `id`.

First, let's analyze the existing code.

----

`Step 1:` Using the **Visual Editor**, navigate to the file `src/main/java/org/acme/reactive/Coffee.java` as shown in the figure below:

![Open coffee](../assets/open-coffee.png)

Notice that the `Coffee` class has only fields as shown in the code snippet below:

```java

    public Long id;

    public String name;

```

The `Coffee` class represents a data entity for a coffee type. Thus, having the fields `id` and `name` makes sense. The field `id` is the unique identifier of the coffee record in the PostgresSQL database. The `name` field describes the name of the coffee type, for example `Americano`.

----

`Step 2:` In the **Visual Editor**, scroll through the file `src/main/java/org/acme/reactive/Coffee.java`.

Notice that the `Coffee` class has the methods `findAll(PgPool client)`, `save(PgPool client)`, `update(PgPool client)`, and `delete(PgPool client, Long id)`. These methods do the work of getting all coffee types from the PostgresSQL database, as well as saving, updating, and deleting a particular coffee type. All of the methods use a [`PgPool`](https://pgpool.net/mediawiki/index.php/Main_Page) object since we are going to use a PostgreSQL database and are using the PostgreSQL reactive driver.

The outstanding work is to add intelligence to the `Coffee` class that will enable the class to retrieve a particular coffee type according to `id`. You'll add this intelligence now by inserting a method named `findById()`.

----

`Step 3a:` In the **Visual Editor**, click on the file `src/main/java/org/acme/reactive/Coffee.java` to open it for editing.

`Step 3b:` Add this content after the `// TODO FindById` comment:

```java
    public static Uni<Coffee> findById(PgPool client, Long id) {
        return client.preparedQuery("SELECT id, name FROM coffee WHERE id = $1").execute(Tuple.of(id))
                .onItem().transform(RowSet::iterator)
                .onItem().transform(iterator -> iterator.hasNext() ? from(iterator.next()) : null);
    }
```

Notice that an `PgPool` object is passed to the `findById()` method as the type of the `client` parameter.

The `client` does the work of preparing the query and applying successive `onItem` reactive methods to transform the result. The result is returned as a `Uni<Coffee>` as part of the demonstration application's Mutiny reactive API.


# Congratulations!

You've reviewed and upgraded the data access classes in the demonstration application.

----

**NEXT:** Redeploying the demonstration application instance running on OpenShift
