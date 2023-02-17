---
slug: 04-create-web
id: l3jomtr9s9hh
type: challenge
title: Topic 4 - Using Spring Web Annotations in Quarkus
notes:
- type: text
  contents: Topic 4 - Using Spring Web Annotations in Quarkus
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/quarkus/fruit-taster
- title: Terminal 2
  type: terminal
  hostname: crc
difficulty: intermediate
timelimit: 800
---
This topic shows you how your Quarkus application can leverage the well known Spring Web annotations to define RESTful services.

In addition to allowing you to use [JAX-RS annotation](https://access.redhat.com/documentation/en-us/red_hat_jboss_fuse/6.2/html/apache_cxf_development_guide/jaxrsbaseannotations) to define REST endpoints, Quarkus provides the `spring-web` extensions which are the compatibility layer for Spring Web


## Creating Controllers

First you are going to use the Spring Web annotation `@RestController` to create a controller class the will manage web access to the REST endpoint `/fruits` that will be hosted by the demonstration application.

----

`Step 1:` Click the **Visual Editor** tab on the horizontal menu bar over the terminal window to the left, navigate to the directory `fruit-taster/src/main/java/org/acme/` and create a file named `FruitController.java`.

----

`Step 2:`  Open the file `FruitController.java` in the **Visual Editor** and add the following code:

```java
package org.acme;

import java.util.List;
import java.util.Optional;

import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

@RestController
@RequestMapping("/fruits")
public class FruitController {

    private final FruitRepository fruitRepository;

    public FruitController(FruitRepository fruitRepository) {
        this.fruitRepository = fruitRepository;
    }

    @GetMapping(produces = "application/json")
    public Iterable<Fruit> findAll() {
        return fruitRepository.findAll();
    }


    @DeleteMapping("/{id}")
    public void delete(@PathVariable(name = "id") long id) {
        fruitRepository.deleteById(id);
    }

    @PostMapping(path = "/name/{name}/color/{color}", produces = "application/json")
    public Fruit create(@PathVariable(name = "name") String name, @PathVariable(name = "color") String color) {
        return fruitRepository.save(new Fruit(name, color));
    }

    @PutMapping(path = "/id/{id}/color/{color}", produces = "application/json")
    public Fruit changeColor(@PathVariable(name = "id") Long id, @PathVariable(name = "color") String color) {
        Optional<Fruit> optional = fruitRepository.findById(id);
        if (optional.isPresent()) {
            Fruit fruit = optional.get();
            fruit.setColor(color);
            return fruitRepository.save(fruit);
        }

        throw new IllegalArgumentException("No Fruit with id " + id + " exists");
    }

    @GetMapping(path = "/color/{color}", produces = "application/json")
    public List<Fruit> findByColor(@PathVariable(name = "color") String color) {
        return fruitRepository.findByColor(color);
    }
}
```

----

`Step 3:` Save the file `FruitController.java` by clicking the `Disk` icon or striking the `CTRL+S` keys as you did in previous steps.


Take a look at the code you just added to `FruitController.java`

Notice the use of the Spring annotations `@GetMapping`, `@DeleteMapping`,  `@PutMapping`, and `@PathVariable`. These annotations expose a set of RESTful API endpoints like so:

* `GET /fruits` - Retrieve all Fruits as a JSON array
* `DELETE /fruits/{id}` - Delete by ID
* `POST /fruits/name/{name}/color/{color}` - create a new Fruit with a name and color
* `PUT /fruits/id/{id}/color/{color}` - Update a fruit with a new color
* `GET /fruits/color/{color}` - Retrieve all fruits of the specified color

These endpoints allow you to work with the REST resources published by the demonstration application.

# Exercising the REST endpoint

Now that you've created `FruitController` , we can test some of the endpoints.

----

`Step 4:`  Click the **Terminal 1** tab in horizontal menu bar over the top of the terminal window to the left.

----

`Step 5:`  Run the following command in the **Terminal 1** window.

```
curl -w "\n" localhost:8080/fruits/ | jq .
```

The command above uses `curl` to make a GET request against the `fruits` endpoint. Then the response is piped on to the `jq` utility which displays a pretty rendering of the response JSON. (The `jq` utility was installed previously as part of the track's setup)

You'll get the following output:

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

|NOTE:|
|----|
|You may need to run the `curl` again, if it didn't execute properly in the **Terminal 1** window.<br><br>If you get a `parse error:`, it is likely you missed executing a previous step and the Quarkus live reload went into an error state. Thus, you'll need to go back to the previous topic and run some of the steps again.|


----

`Step 6:` Run the the following command in the **Terminal 1** window to add a fruit with the name `apple` and the color `red` to the data store using the REST API.

```
curl -X POST -s http://localhost:8080/fruits/name/apple/color/red
```

You'll get the following output:

```json
{"id":6,"name":"apple","color":"red"}
```

----

`Step 7:`  Run the the following command in the **Terminal 1** window to get all `red` fruits:

```
curl -s http://localhost:8080/fruits/color/red | jq
```

You get output as follows:

```json
[
  {
    "id": 1,
    "name": "cherry",
    "color": "red"
  },
  {
    "id": 5,
    "name": "strawberry",
    "color": "red"
  },
  {
    "id": 6,
    "name": "apple",
    "color": "red"
  }
]
```

Notice the presence of `apple` which we just added earlier.

----

`Step 8:`  Run the the following command in the **Terminal 1** window to change the color of the `apple` to `green`:

```
curl -X PUT -s http://localhost:8080/fruits/id/6/color/green
```

You'll get the following output:

```json
{"id":6,"name":"apple","color":"green"}
```

----

`Step 9:`  Run the the following command in the **Terminal 1** window to change retrieve all `green` fruits:

```
curl -s http://localhost:8080/fruits/color/green | jq
```

You'll get the following output:

```json
[
  {
    "color": "green",
    "id": 4,
    "name": "avocado"
  },
  {
    "color": "green",
    "id": 6,
    "name": "apple"
  }
]
```

Looking at the output above you can infer that you did indeed change the color of your `apple` to `green`.

## Exercising beans using Spring DI Annotations

As a final task let's create another controller bean that uses Spring DI annotations to infer configuration settings.

----

`Step 10:` Navigate to the directory `fruit-taster/src/main/java/org/acme` using the  **Visual Editor** and click the `Create File` icon to create a new file for the taster controller for tasting Fruits. Name this file `TasterController.java`.

----

`Step 11:` Click on the filename `TasterController.java` in **Visual Editor** directory tree and add the following code:

```java
package org.acme;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import org.springframework.web.bind.annotation.PathVariable;

@RestController
@RequestMapping("/taster")
public class TasterController {

    private final FruitRepository fruitRepository;

    private final TasterBean tasterBean;

    public TasterController(FruitRepository fruitRepository, TasterBean tasterBean) {
        this.fruitRepository = fruitRepository;
        this.tasterBean = tasterBean;
    }

    @GetMapping(produces = "application/json")
    public List<TasteResult> tasteAll() {
        List<TasteResult> result = new ArrayList<>();

        fruitRepository.findAll().forEach(fruit -> {
            result.add(new TasteResult(fruit, tasterBean.taste(fruit.getName())));
        });
        return result;
    }

    @GetMapping(path = "/{color}", produces = "application/json")
    public List<TasteResult> tasteByColor(@PathVariable(name = "color") String color) {
        List<TasteResult> result = new ArrayList<>();
        fruitRepository.findByColor(color).forEach(fruit -> {
            result.add(new TasteResult(fruit, tasterBean.taste(fruit.getName())));
        });
        return result;
    }

    public class TasteResult {
        public Fruit fruit;
        public String result;

        public TasteResult(Fruit fruit, String result) {
            this.fruit = fruit;
            this.result = result;
        }

    }
}
```
---

`Step 12:` Save the file `TasterController.java` by clicking the `Disk` icon or striking the `CTRL+S` keys as you did in previous steps.

Again, we're using Spring Rest annotations such as `@GetMapping` but we're also injecting the `FruitRepository` and `TasterBean`  created previoulsy in the constructor of `TasterController` like so:

```java
    public TasterController(FruitRepository fruitRepository, TasterBean tasterBean) {
        this.fruitRepository = fruitRepository;
        this.tasterBean = tasterBean;
    }
```

Now the `TasterController` exposes two additional RESTful endpoints:

* `GET /taster` - taste all fruits and report result
* `GET /taster/{color}` - Taste only fruits of the specified color

Is the app still running? Let's check it out by exercising the new endpoints

----

`Step 13:` Run the following command in  **Terminal 1** to taste all the fruits:

```
curl -s http://localhost:8080/taster | jq
```

You will see the following output:

```json
[
  {
    "fruit": {
      "color": "red",
      "id": 1,
      "name": "cherry"
    },
    "result": "CHERRY: TASTES GREAT !"
  },
  {
    "fruit": {
      "color": "orange",
      "id": 2,
      "name": "orange"
    },
    "result": "ORANGE: TASTES GREAT !"
  },
  {
    "fruit": {
      "color": "yellow",
      "id": 3,
      "name": "banana"
    },
    "result": "BANANA: TASTES GREAT !"
  },
  {
    "fruit": {
      "color": "green",
      "id": 4,
      "name": "avocado"
    },
    "result": "AVOCADO: TASTES GREAT !"
  },
  {
    "fruit": {
      "color": "red",
      "id": 5,
      "name": "strawberry"
    },
    "result": "STRAWBERRY: TASTES GREAT !"
  }
]
```

----

`Step 14:` Run the following command in  **Terminal 1** to taste only the `green` fruits:

```
curl -s http://localhost:8080/taster/green | jq
```

You will get the following output

```json
[
  {
    "fruit": {
      "color": "green",
      "id": 4,
      "name": "avocado"
    },
    "result": "AVOCADO: TASTES GREAT !"
  }
]
```

## Adding a suffix

Let's add some suffix text to the output of the RESTful endpoints

----

`Step 15:` Return to the **Visual Editor** window by clicking on the tab in the horizontal menu bar over the terminal window.

----

`Step 16:` Navigate to the directory `fruit-taster/src/main/resources` using the **Visual Editor** filesystem tree.

----

`Step 16:` Click on the filename `application.properties` to open the file for editing.

----

`Step 17:` Append the following code to the end of the file `application.properties`.

```text
taste.suffix = (if you like fruit!)
```

----

`Step 18:` Save the file `application.properties` by clicking the `Disk` icon or striking the `CTRL+S` keys as you did in previous steps.

----

`Step 19:` Run the following command in the **Terminal 1** window to taste yellow fruits:

```
curl -s http://localhost:8080/taster/yellow | jq
```

You will see the following output:

```json
[
  {
    "fruit": {
      "color": "yellow",
      "id": 3,
      "name": "banana"
    },
    "result": "BANANA: TASTES GREAT (IF YOU LIKE FRUIT!)"
  }
]
```

Notice the presence of the new suffix! It was added to the endpoint output automatically when you updated the file `application.properties`. And, you didn't need to restart the application.

Quarkus apps make it super easy to code, test, and re-code on the fly.

**Congratulations!**

You've exercised the RESTful API you created previously and you also added two new endpoints with additional behavior using the automated capabilities of Quarkus.

----

**NEXT:** Deploying the demonstration app in a JAR file