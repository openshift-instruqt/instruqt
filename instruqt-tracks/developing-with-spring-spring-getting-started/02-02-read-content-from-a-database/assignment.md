---
slug: 02-read-content-from-a-database
id: wjgexwsejw3e
type: challenge
title: Step 2
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/spring-rhoar-intro/
difficulty: basic
timelimit: 600
---
# Read content from a database

In Step 1 you learned how to get started with our project. In this step, we will add functionality for our Fruit basket application to display content from the database.

**1. Adding JPA (Hibernate) to the application**

Since our applications (like most) will need to access a database to read retrieve and store fruits entries, we need to add Java Persistence API to our project.

The default implementation in Spring Boot is Hibernate which has been tested as part of the Red Hat Runtimes.

>**NOTE:** Hibernate is another Open Source project that is maintained by Red Hat and it will soon be productized (as in fully supported) in Red Hat Runtimes.

From *Visual Editor* Tab, add Hibernate to our project by opening the `pom.xml` file and adding after the `<!-- TODO: Add JPA dependency here -->` comment this code:

```xml
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-data-jpa</artifactId>
    </dependency>
```

When testing starting locally or when running test we also need to use a local database. H2 is a small in-memory database that is perfect for testing but is not recommended for production environments. To add H2 add the following dependency at the comment `<!-- TODO: ADD H2 database dependency here -->` in the `pom.xml`:

```xml
        <dependency>
          <groupId>com.h2database</groupId>
          <artifactId>h2</artifactId>
          <scope>runtime</scope>
        </dependency>
```

Save the file.

**2. Create an Entity class**

We are going to implement an Entity class that represents a fruit. This class is used to map our object to a database schema.

First, we need to create the java class file. From the *Visual Editor* Tab, create this file: `src/main/java/com/example/service/Fruit.java`.

![File](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-getting-started-spring/create-file-fruit-sb.png)

Open the `Fruit.java` file then copy the below content into the file:

```java
package com.example.service;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Fruit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    private String name;

    public Fruit() {
    }

    public Fruit(String type) {
        this.name = type;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
}
```

Save the file.

 **3. Create a repository class for our content**

The repository should provide methods for insert, update, select and delete operations on Fruits from the database. We use Spring Data which provides us with lots of boilerplate code. All we have to do is to add an interface that extends the `CrudRepository<Fruit, Integer>` interface provided by Spring Data.

First, we need to create the java class file.  From the *Visual Editor* Tab, create this file: `src/main/java/com/example/service/FruitRepository.java`

Copy the below content into the file:

```java
package com.example.service;

import org.springframework.data.repository.CrudRepository;

public interface FruitRepository extends CrudRepository<Fruit, Integer> {
}
```

Save the file.

**4. Populate the database with initial content**

To pre-populate the database with content, Hibernate offers a nifty feature where we can provide a SQL file that populates the content.

First, we need to create the SQL  file.  From the *Visual Editor* Tab, create this file: `src/main/resources/import.sql`

Copy the below content into the file:

```sql
insert into fruit (name) values ('Cherry');
insert into fruit (name) values ('Apple');
insert into fruit (name) values ('Banana');
```

Save the file.

**5. Add a test class**
Verify that we can use the `FruitRepository` for retrieving and storing Fruit objects by creating a test class.

First, we need to create the java class file. From the *Visual Editor* Tab, create this file: ``src/test/java/com/example/ApplicationTest.java``

Copy the below content into the file:

```java
package com.example;

import static org.assertj.core.api.Assertions.assertThat;

import java.util.Optional;

import org.junit.jupiter.api.Test;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import com.example.service.Fruit;
import com.example.service.FruitRepository;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
@Transactional
public class ApplicationTest {

    @Autowired
    private FruitRepository fruitRepository;

    @Test
    public void testGetAll() {
        assertThat(this.fruitRepository.findAll())
          .isNotNull()
          .hasSize(3);
    }

    @Test
    public void getOne() {
        assertThat(this.fruitRepository.findById(1))
          .isNotNull()
          .isPresent();
    }

    @Test
    public void updateAFruit() {
        Optional<Fruit> apple = this.fruitRepository.findById(2);

        assertThat(apple)
          .isNotNull()
          .isPresent()
          .get()
          .extracting(Fruit::getName)
          .isEqualTo("Apple");

        Fruit theApple = apple.get();
        theApple.setName("Green Apple");
        this.fruitRepository.save(theApple);

        assertThat(this.fruitRepository.findById(2))
          .isNotNull()
          .isPresent()
          .get()
          .extracting(Fruit::getName)
          .isEqualTo("Green Apple");
    }

    @Test
    public void createAndDeleteAFruit() {
        int orangeId = this.fruitRepository.save(new Fruit("Orange")).getId();
        Optional<Fruit> orange = this.fruitRepository.findById(orangeId);
        assertThat(orange)
          .isNotNull()
          .isPresent();

        this.fruitRepository.delete(orange.get());

        assertThat(this.fruitRepository.findById(orangeId))
          .isNotNull()
          .isNotPresent();
    }

    @Test
    public void getWrongId() {
        assertThat(this.fruitRepository.findById(9999))
          .isNotNull()
          .isNotPresent();
    }
}
```

Save the file.

Take some time to review the tests. The `testGetAll` test returns all fruits in the repository, which should be three because of what the content in `import.sql`. The `getOne` test will retrieve the fruit with id 1 (e.g., the Cherry) and then check that it's not null. The `getWrongId` check that if we try to retrieve a fruit id that doesn't exist and check that fruitRepository return null.

**6. Run and verify**

We can now test that our `FruitRepository` can connect to the data source, retrieve data and
Run the application by executing the below command in Terminal 1:

```
mvn verify -f /root/projects/rhoar-getting-started/spring/spring-rhoar-intro
```

In the console you should now see the following:

```
Results :

Tests run: 5, Failures: 0, Errors: 0, Skipped: 0
```

## Congratulations

You have learned how to create and test a data repository that can create, read, update and delete content from a database. We have been testing this with an in-memory database, but later we will replace this with a full blow SQL server running on OpenShift, but first, we should create REST services that the web page can use to update content.
