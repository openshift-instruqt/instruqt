---
slug: 03-add-resource
id: jkic6vwct0mz
type: challenge
title: Topic 3 - Creating the reactive CoffeeResource endpoints
notes:
- type: text
  contents: Topic 3 - Creating the reactive CoffeeResource endpoints
tabs:
- id: obkewnarsrlb
  title: Terminal 1
  type: terminal
  hostname: crc
- id: 7awab8dr2l5n
  title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/quarkus/reactive-sql
difficulty: basic
timelimit: 240
---
In the previous topic you created a PostgreSQL database for the demonstration application. Also you added the extensions to Quarkus.

In this topic you will add RESTful endpoints to the `CoffeeResource`. You'll modify the application and add relevant methods.

The `CoffeeResource` is already provided in the demonstration application's source code. The work to be done is to add additional functionality to the existing source code.

First you'll add code that will automatically create a table in the PostgresSQL database and insert three types of coffee, `Americano`, `Latte`, and `Mocha`.

----

`Step 1a:` In the **Visual Editor**, navigate to the file `src/main/java/org/acme/reactive/CoffeeResource.java` as shown in the figure below.

![Open Coffee Resource](../assets/open-coffeesource.png)

`Step 1b:` Click on the file `src/main/java/org/acme/reactive/CoffeeResource.java` to open it for editing.

`Step 1c:` Copy and paster the following code after the comment `// TODO initdb`:

```java
        client.query("DROP TABLE IF EXISTS coffee").execute()
                .flatMap(r -> client.query("CREATE TABLE coffee (id SERIAL PRIMARY KEY, name TEXT NOT NULL)").execute())
                .flatMap(r -> client.query("INSERT INTO coffee (name) VALUES ('Americano')").execute())
                .flatMap(r -> client.query("INSERT INTO coffee (name) VALUES ('Latte')").execute())
                .flatMap(r -> client.query("INSERT INTO coffee (name) VALUES ('Mocha')").execute()).await()
                .indefinitely();
```

`Step 1d:` Click on the `Disk` icon or press `CTRL+S` to save the file.

Next, you'll add the RESTful API methods. You'll add a `GET` method that sill return all coffee types. Also, you'll add `GET` method that returns a specific coffee type according to `id`.

The `getSingle` method that returns a single coffee type uses the `PathParam` to indicate the the `id` passed from the query string value defined by the `@Path` annotation.

----

`Step 2a:` Add the following code after the `// TODO GET` comment:

```java
    @GET
    public Multi<Coffee> get() {
        return Coffee.findAll(client);
    }

    @GET
    @Path("{id}")
    public Uni<Response> getSingle(@PathParam("id") Long id) {
        return Coffee.findById(client, id)
            .onItem().transform(fruit -> fruit != null ? Response.ok(fruit) : Response.status(Status.NOT_FOUND))
            .onItem().transform(ResponseBuilder::build);
    }

```

`Step 2b:` Click on the `Disk` icon or press `CTRL+S` to save the file.

Now add the `POST` and `PUT` request methods.

----

`Step 3a:` Add the following code after the `// TODO POST` comment:

```java

    @POST
    public Uni<Response> create(Coffee coffee) {
        return coffee.save(client)
                .onItem().transform(id -> URI.create("/coffee/" + id))
                .onItem().transform(uri -> Response.created(uri).build());
    }

    @PUT
    @Path("{id}")
    public Uni<Response> update(@PathParam("id") Long id, Coffee coffee) {
        return coffee.update(client)
            .onItem().transform(updated -> updated ? Status.OK : Status.NOT_FOUND)
            .onItem().transform(status -> Response.status(status).build());
    }
```

`Step 3b:` Click on the `Disk` icon or press `CTRL+S` to save the file.

Finally add the DELETE method, so that there's an endpoint for deleting a coffee type from the Quarkus demonstration application.

----

`Step 4a:` Add the following code after the `// TODO DELETE` comment:

```java
    @DELETE
    @Path("{id}")
    public Uni<Response> delete(@PathParam("id") Long id) {
        return Coffee.delete(client, id)
                .onItem().transform(deleted -> deleted ? Status.NO_CONTENT : Status.NOT_FOUND)
                .onItem().transform(status -> Response.status(status).build());
    }
```

`Step 4b:` Click on the `Disk` icon or press `CTRL+S` to save the file.

# Congratulations!

You've added the `coffee` type data to the PostgresSQL database. Also, you created `GET`, `POST`, `PUT` and `DELETE` endpoints to the demonstration application

**NEXT:** Modifying the `Coffee` class