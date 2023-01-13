---
slug: 03-create-rest-services
id: e8fklskjqvc1
type: challenge
title: Step 3
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/spring-rhoar-intro
- title: Fruit App
  type: service
  hostname: crc
  path: /
  port: 8080
difficulty: basic
timelimit: 600
---
# Create REST services for the fruit web application


**1. Add a service**

First, Create a new `src/main/java/com/example/service/FruitController.java` file in Visual Editor.

Then, copy the below content into the file:

```java
package com.example.service;

import java.util.Objects;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/fruits")
public class FruitController {

    private final FruitRepository repository;

    public FruitController(FruitRepository repository) {
        this.repository = repository;
    }

    @GetMapping(produces = MediaType.APPLICATION_JSON_VALUE)
    public Iterable<Fruit> getAll() {
        return this.repository.findAll();
    }

//TODO: Add additional service calls here
}
```

Save the file.

Take a minute and review the `FruitController`. At this stage is pretty simple and only has one method that exposes an endpoint for HTTP GET request for path `/api/fruits`, as specified in the class annotation `@RequestMapping(value = "/api/fruits")`. We should now be able to see a list of fruits on the web page.

**2. Test the service from a web browser locally**

Run the application by executing the below command in Termnial 1:

```bash
mvn spring-boot:run -DskipTests -f /root/projects/rhoar-getting-started/spring/spring-rhoar-intro
```

>**NOTE:** We skip the tests to speed up the start and since we do not have any tests for the REST service. Please note that the `spring-boot-crud-booster` [here](https://github.com/snowdrop/spring-boot-crud-booster) has test cases for REST, please review them if interested.

In the interest of time, we will skip creating test cases for the service and instead test it directly in our web browser.

When the console reports that Spring is up and running access the *Fruit App* Tab.

If everything works the web page should look something like this:

![Fruit List](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-getting-started-spring/fruit-list.png)

Press <kbd>CTRL</kbd>+<kbd>C</kbd> to stop the application.

**3. Create additional service for update, create and delete**

Add the following methods to the Fruit Controller at the TODO marker.

```java
    @ResponseStatus(HttpStatus.CREATED)
    @PostMapping(consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public Fruit post(@RequestBody(required = false) Fruit fruit) {
        verifyCorrectPayload(fruit);

        return this.repository.save(fruit);
    }

    @GetMapping(path = "/{id}", produces = MediaType.APPLICATION_JSON_VALUE)
    public Fruit get(@PathVariable("id") Integer id) {
        verifyFruitExists(id);

        return this.repository.findById(id).orElse(null);
    }

    @PutMapping(path = "/{id}", consumes = MediaType.APPLICATION_JSON_VALUE, produces = MediaType.APPLICATION_JSON_VALUE)
    public Fruit put(@PathVariable("id") Integer id, @RequestBody(required = false) Fruit fruit) {
        verifyFruitExists(id);
        verifyCorrectPayload(fruit);

        fruit.setId(id);
        return this.repository.save(fruit);
    }

    @ResponseStatus(HttpStatus.NO_CONTENT)
    @DeleteMapping("/{id}")
    public void delete(@PathVariable("id") Integer id) {
        verifyFruitExists(id);

        this.repository.deleteById(id);
    }

    private void verifyFruitExists(Integer id) {
        if (!this.repository.existsById(id)) {
            throw new RuntimeException(String.format("Fruit with id=%d was not found", id));
        }
    }

    private void verifyCorrectPayload(Fruit fruit) {
        if (Objects.isNull(fruit)) {
            throw new RuntimeException("Fruit cannot be null");
        }

        if (!Objects.isNull(fruit.getId())) {
            throw new RuntimeException("Id field must be generated");
        }
    }
```

Save the file.

**5. Run and verify**

Build and start the application again

```bash
mvn spring-boot:run -DskipTests -f /root/projects/rhoar-getting-started/spring/spring-rhoar-intro
```

Now that we have implemented all the services we are now able to see fruits on the page, and also update, create and delete them.

When the console reports that Spring is up and running access the app from the *Fruit App* Tab.

Press <kbd>CTRL</kbd>+<kbd>C</kbd> to stop the application.

## Congratulations

You have now learned how to how to create REST Services that access a database.

In next step of this scenario, you will learn how to access and login to your openshift environment.
