---
slug: 01-define-entity
id: boiy7lxa32ql
type: challenge
title: Topic 1 - Setting up the demonstration project and implementing data access
  Web UI
teaser: Learn how to get the code for the demonstration application from source control,
  set up the Panache extension for Quarkus and define data entities in the demonstration
  application
notes:
- type: text
  contents: |-
    In this scenario, you will get an introduction to **Panache**, one of the many features of [Quarkus](https://quarkus.io).

    |What you need to know before you start|
    |----|
    |In order to get full benefit from taking this track you should...<br>• Have experience programming applications in Java using the [Maven](https://maven.apache.org/) framework.<br>• Have a working knowledge using Java annotations. <br>• Have hands on knowledge executing queries in a relational database. <br>• Have a general understanding of [Object Relational Mapping](https://en.wikipedia.org/wiki/Object%E2%80%93relational_mapping) (ORM). <br>• Have a basic familiarity with Quarkus as demonstrated in this [Getting Started](https://learn.openshift.com/middleware/courses/middleware-quarkus/getting-started) scenario.|

    # What is Panache?

    Hibernate ORM is the de facto JPA implementation and offers you the full breadth of an Object Relational Mapper. But many simple mappings can be complex and hard to implement. However, using Hibernate ORM with **Panache** adds a layer of ease to working with data under Quarkus.

    # What are the benefits of using Panache?

    Panache offers the following benefits:

    * By extending `PanacheEntity` in your entities, you will get an ID field that is auto-generated. However, if you require a custom ID strategy, you can extend `PanacheEntityBase` instead and provide the ID yourself.
    * Panache exposes public fields. Thus, there is no need to implement functionless getters and setters (those that get or set the value of a field). You simply refer to fields like `Person.name` without the need to write a `Person.getName()` implementation. Panache will auto-generate any getters and setters required. Still, you can develop your own getters/setters that do more than get/set.
    * The [`PanacheEntityBase`](https://github.com/quarkusio/quarkus/blob/main/extensions/panache/hibernate-orm-panache/runtime/src/main/java/io/quarkus/hibernate/orm/panache/PanacheEntityBase.java) abstract superclass comes with many useful static methods such as `list()`, `find()`, `findById()`,` findAll()` and `steam()` to name a few. Also, you can add your own methods in your derived entity class. Much like traditional object-oriented programming, it's recommended that you place custom queries as close to the entity as possible, ideally within the entity definition itself. Users can just start using an entity such as `Person` by typing `Person`, and getting auto-completion for all the operations in a single place.
    * Query expressions become more concise. For example you can write `Person.find("order by name")` or `Person.find("name = ?1 and status = ?2", "stef", Status.Alive)`. Or even better, you can write `Person.find("name", "stef")` to find an entity according to the `name`, `stef`.


    # Learning more

    You can learn more about Panache at [quarkus.io](https://quarkus.io).
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/quarkus/panache
difficulty: basic
timelimit: 300
---
In this topic, you will create a simple RESTful application generated using Quarkus tooling. Then you'll define a new data entity that will be used in the application. The data entity will then be persisted in a relational database through [JDBC](https://access.redhat.com/documentation/en-us/red_hat_amq/7.7/html-single/configuring_amq_broker/index#jdbc_persistence).

# Inspecting the Java runtime

This topic comes with a Java runtime (JRE) preinstalled. Let's verify that the JRE is up and running.

----

`Step 1:` Click the **Terminal 1** tab on the horizontal menu bar over the window to the left.

----

`Step 2:`  Run the following command in the **Terminal 1** window to verify that the JRE is installed and available:

```
$JAVA_HOME/bin/java --version
```

You'll get output similar to the following:

```console
openjdk 17.0.6 2023-01-17
OpenJDK Runtime Environment Temurin-17.0.6+10 (build 17.0.6+10)
OpenJDK 64-Bit Server VM Temurin-17.0.6+10 (build 17.0.6+10, mixed mode, sharing)
```

If the command fails, wait a few moments and try again. (The JRE is installed in a background process and might take a few minutes to finish installing depending on system load).


# Importing the demonstration application's source code

`Step 3:` Run the following command in the **Terminal 1** window to to install the demonstration application's source code:

```
cd /root/projects && rm -rf rhoar-getting-started && git clone https://github.com/openshift-instruqt/rhoar-getting-started
```

# Inspecting the project

`Step 4:` Run the following command in the **Terminal 1** window to navigate to the source code's working directory:

```
cd /root/projects/rhoar-getting-started/quarkus/panache && pwd
```

You'll get the following output:

```
/root/projects/rhoar-getting-started/quarkus/panache
```

 Let's take a look at the source code files. Initially, the project is almost empty and doesn't do anything. But, understanding the underlying file system is useful.

----

`Step 5:` Click the **Visual Editor** tab on the horizontal menu bar over the window to the left.

----

`Step 6:` Review the various files in the source code by navigating through the directory tree on the left side of the Visual Editor.

As you can see, there are some files in the project that have already been prepared for you.

For example, under `src/main/resources/META-INF/resources` you'll see the `HTML` file as shown in the figure below.

![File system](..\assets\file-system.png)

The `HTML` file represents the demonstration application's web site.

Also, there are some skeletal model files and utility files. These files are similar to what you might get when generating sample projects [using the Quarkus Project Generator](https://code.quarkus.io).

# Adding the Postgres extension to Quarkus

In order to get Quarkus to support Panache and PostgreSQL, you need to add a few extensions to the demonstration application using the Quarkus Maven Plugin.

----

`Step 7:` Return to **Terminal 1** and run the following command to add the Hibernate ORM/Panache and PostgreSQL JDBC extensions:

```
mvn quarkus:add-extension -Dextensions="hibernate-orm-panache, jdbc-postgresql"
```

You will see a lot of screen output and then when the execution is successful, you see output similar to the following:

```console
[INFO] [SUCCESS] /?  Extension io.quarkus:quarkus-hibernate-orm-panache has been installed
[INFO] [SUCCESS] /?  Extension io.quarkus:quarkus-jdbc-postgresql has been installed
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

You've installed the extensions.

|NOTE:|
|----|
|There are [many more Quarkus extensions](https://quarkus.io/extensions/) for popular frameworks such as [Eclipse Vert.x](https://vertx.io), [Apache Camel](http://camel.apache.org/), [Infinispan](http://infinispan.org/), and [Spring DI Compatibility](https://redhat-developer-demos.github.io/quarkus-tutorial/quarkus-tutorial/spring.html) (e.g. `@Autowired`), to name a few.|

# Defining a Person entity

The purpose of the demonstration application is to be a queryable database of people. Each person in the database has fields for `name`, `birth date`, and  `eye color`.

You will to create a Person entity that has these fields.

----

`Step 8:` Go to the **Visual Editor** tab and use the directory tree to navigate to the file `Person.java` in the directory `src/main/java/org/acme/person/model` as shown in the figure below.

![Person Entity](..\assets\person-entity.png)

----

`Step 9:` Click on the file named `Person.java` in the Visual Editor directory tree to open the file for editing.

----

`Step 10:` Copy the code below and paste it into `Person.java` **replacing all of the preexisting code**. The code describes an [`@Entity` bean](https://access.redhat.com/documentation/en-us/red_hat_jboss_web_server/1.0/html/hibernate_annotations_reference_guide/entity-mapping-association):

```java
package org.acme.person.model;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;

import io.quarkus.hibernate.orm.panache.PanacheEntity;

@Entity
public class Person extends PanacheEntity {
    // the person's name
    public String name;

    // the person's birth date
    public LocalDate birth;

    // the person's eye color
    @Enumerated(EnumType.STRING)
    @Column(length = 8)
    public EyeColor eyes;

    // TODO: Add more queries
}
```

----

`Step 11:` Click on the `Disk` icon or press `CTRL+S` keys to save the file as shown in the figure below:

![Save File](..\assets\save-file.png)

|NOTE:|
|----|
|The code you just copied and pasted into the the file `Person.java` has a `//TODO` line.<br><br>**DO NOT DELETE** the `//TODO` line. You will use that line in an upcoming topic.|

Notice that `Person.java` has defined the three fields `name`, `birth`, and `eyes` mentioned previously, where `eyes` is the field for eye color.

Also notice that the code uses the Java Persistence API's `@Enumerated` field type at `Line 23` with the `Person` entity's eye color.

However, there is no definition for eye color. You'll need to create the Java file that defines eye color. That file you'l create will define an `enum` that lists different eye colors.

----

`Step 12:` Using the Visual Editor directory tree, navigate to the directory, `src/main/java/org/acme/person/model/`.

----

`Step 13:` Click the `New File` icon to the right of the `src/main/java/org/acme/person/model/` directory to open a new file. Name the file `EyeColor.java` as shown in the figure below.

![Create file](..\assets\create-eye-color.png)

----

`Step 14:` Copy and paste the code below into the newly created file  `EyeColor.java`:

```java
package org.acme.person.model;

public enum EyeColor {
    BLUE, GREEN, HAZEL, BROWN
}
```

----

`Step 15:` Click on the `Disk` icon to or press `CTRL+S` keys to save the `EyeColor.java` file.

Next, you'll create a `PersonResource` class, which you will use to define a RESTful endpoint in the demonstration application.

# Defining the RESTful endpoint

`Step 16:` Using the **Visual Editor**, create a new file named `PersonResource.java` in the directory `src/main/java/org/acme/person/`.

----

`Step 17:` Copy and paste the code below into the newly created file  `PersonResource.java`:

```java
package org.acme.person;

import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

import javax.enterprise.event.Observes;
import javax.transaction.Transactional;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.acme.person.model.DataTable;
import org.acme.person.model.EyeColor;
import org.acme.person.model.Person;

import io.smallrye.common.annotation.Blocking;
import io.quarkus.panache.common.Parameters;
import io.quarkus.runtime.StartupEvent;
import io.quarkus.hibernate.orm.panache.PanacheQuery;

@Path("/person")
@Blocking
public class PersonResource {

    @GET
    @Produces(MediaType.APPLICATION_JSON)
    public List<Person> getAll() {
        return Person.listAll();
    }

    // TODO: add basic queries

    // TODO: add datatable query

    // TODO: Add lifecycle hook

}
```
|NOTE:|
|----|
|The code you just copied and pasted into the the file `PersonResource.java` has a number of  `//TODO` lines.<br><br> **DO NOT DELETE** the `//TODO` lines. You will be using those lines in an upcoming topic.|

---

`Step 18:` Click on the `Disk` icon to or press `CTRL+S` keys to save the `PersonResource.java` file.


As you can see, you've implemented your first Panache-based query. This query is encapsulated in the `PersonResource.getAll()` method.

The `PersonResource.getAll()`  method will return a list of people as a JSON array

The `PersonResource.getAll()`  method is executed when you access the `GET /person` endpoint. This endpoint is defined using the standard JAX-RS `@Path` and `@GET` and `@Produces` annotations.

# Adding sample data

Let's add the code that will inject sample data to the database when the application starts.

`Step 19:` Using the Visual Editor, create a file named `import.sql` in the directory `src/main/resources/`.

----

`Step 20a:` Click the `import.sql` in the Visual Editor's directory tree to open it for editing.

`Step 20b:` Copy and past the following code into `import.sql`:

```sql
INSERT INTO person(id, name, birth, eyes) VALUES (nextval('hibernate_sequence'), 'Farid Ulyanov', to_date('1974-08-15', 'YYYY-MM-dd'), 'BLUE');
INSERT INTO person(id, name, birth, eyes) VALUES (nextval('hibernate_sequence'), 'Salvador L. Witcher', to_date('1984-05-24', 'YYYY-MM-dd'), 'BROWN');
INSERT INTO person(id, name, birth, eyes) VALUES (nextval('hibernate_sequence'), 'Huynh Kim Hue', to_date('1999-04-25', 'YYYY-MM-dd'), 'HAZEL');
```

The SQL statements displayed above will add records for three fake people to the database upon application startup.

`Step 20c:` Click on the `Disk` icon or press the `CTRL+S` keys to save the `import.sql` file.

# Congratulations!

In this topic you downloaded the source code from GitHub. You created a Panache entity named `Person`. You added the `EyeColor` enum. Also, you created a `PersonResource` for the application's RESTful API feature. Finally, you created the code to inject sample data into the application at start up.

----

**NEXT:** Deploying a database to OpenShift and enabling live coding under Quarkus