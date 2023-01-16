---
slug: 02-create-rest-services
id: xomky6qhyq5j
type: challenge
title: Step 2
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/spring-rest-services
- title: Fruit App
  type: service
  hostname: crc
  path: /
  port: 8080
difficulty: basic
timelimit: 1000
---
# Create REST services for the fruit web application

RESTful web services are one of the core use cases for the Spring Boot framework as Spring makes it very easy to create HTTP APIs serving a variety of data types. We'll be learning how to use the standard HTTP verbs: GET, POST, PUT, and DELETE, how to use path segments, and how to return JSON content in this scenario.

**1. Review the Model**

We have already created the model for our Fruit objects due to it being necessary for the Repository. Click on the following link which will open the empty file in the editor: `src/main/java/com/example/service/Fruit.java`. As you can see it is just a Plain-Old-Java-Object (POJO) with some JPA-specific annotations. Don't worry about the annotations. They are not important for this module.

**2. Add a Controller**

Next we need to create a Spring Controller to handle HTTP requests to our application. The `@RestController` annotation on a Java class marks the class as a Controller (intended to be of the REST variety) which Spring will register automatically for you on application start.

First, we need to create the java class file. From the *Visual Editor* Tab, create this file: `src/main/java/com/example/service/FruitController.java`.

![File](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-spring-rest-services/create-file-fc-sb.png)

Open the `FruitController.java` file then copy the below content into the file:

```java
package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/fruits")
public class FruitController {

    @Autowired FruitRepository repository; // Ignore this

    // TODO GET mappings
    // TODO POST mapping
    // TODO PUT mapping
    // TODO DELETE mapping

}
```

The `@RestController` annotation tells Spring that this is a special kind of Controller meant to be returning data (not views) when called. If we used the standard Spring `@Controller` annotation instead we would have to also annotate the `getAll()` method (and any other API methods for that matter) with the `@ResponseBody` annotation. `@RestController` implies the `@ResponseBody` annotation for us so we don't have to type it every time!

`@RequestMapping` is our way to tell Spring which URIs this Controller services. In this case we say we service the `/api/fruits` URI. Spring will thus route HTTP requests to that URI to this Controller.

Click on the `Disk` icon to save the files or press `CTRL-S`:

![Visual Editor](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-spring-rest-services/save-fc-file.png)

**2. Add GET Mappings**

At the moment our Controller doesn't actually do any work. We need to add some handler methods. Let's start with the two HTTP GET methods, one for fetching all fruits and one for fetching a specific fruit.

From *Visual Editor* Tab, copy the following at the `<!-- // TODO GET mappings -->` line:

```java
    @GetMapping
    public List<Fruit> getAll() {
        return repository.findAll();
    }

    @GetMapping("/{id}")
    public Fruit getFruit(@PathVariable("id") Long id) {
        return repository.findById(id).orElse(null);
    }
```

Save the file.

To mark a method as a handler for HTTP GET verbs we use the `@GetMapping` annotation. There are a couple arguments that can be passed as arguments to the annotation. The most common argument is a `path` String. Like `@RequestMapping` (which `@GetMapping` is a specialized form of), if we provide a `path` to the annotation it tells Spring that `HTTP GET` requests to that path are to be handled by that method. In the absence of a path String, however, it tries to fall back to the `current path context`. In this case it falls back to the path we specified in the `@RequestMapping` annotation at the class level. This means that the actual route for this method is `GET /api/fruits`.

The second `@GetMapping` for finding a specific Fruit by ID also inherits the path specified by `@RequestMapping` (and all subsequent Mapping annotations in this class will as well). The second one, however, adds context to that path by specifying it's own path. In the second method the route is `GET /api/fruits/{id}` where `id` is a `Path Variable`. This means that whatever value is specified in the last segment will be captured as the variable `id` which we declare to be a Long. This method would therefore be servicing routes like `GET /api/fruits/1`.

**3. Test the service from a web browser locally**

Run the application by executing the below command in Terminal 1:

```
cd /root/projects/rhoar-getting-started/spring/spring-rest-services
mvn spring-boot:run
```

When the console reports that Spring is up and running access the app from the *Fruit App* Tab.

You should see something like this:

![Visual Editor](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-spring-rest-services/get-fruits.png)

 These values are seeded values we've added to the project for you. What is important to note is that Spring automatically serialized our Fruit models to JSON, created the appropriate HTTP header for clients, and returned that response to the client without any extra code from us!

>**NOTE:** JSON is not the only Media Type supported in Spring Boot. JSON is simply the default chosen by the framework.

You can also try adding a `/1` to the end of the browser URL. It should just return `{"name":"Cherry"}`.

Press **<kbd>CTRL</kbd>+<kbd>C</kbd>** to stop the application when you are done.

**4. Add POST Mapping**

Next let's add a handler for accepting HTTP POST requests to create new entries.

From *Visual Editor* Tab, copy the following at the `// TODO POST mapping"` line:

```java
    @PostMapping
    public Fruit createFruit(@RequestBody Fruit fruit) {
        return repository.save(fruit);
    }
```

Save the file.

For a `@PostMapping` we are expecting a JSON Request Body to be sent to our application that follows the `Fruit` form. As a reminder from above, a Fruit in JSON form looks like `{"name":"Cherry"}`. This Request Body will be automatically deserialized from JSON to a Java Object by Spring if we have a POJO that matches. In this case we have our `Fruit` class. The `@RequestBody` annotation instructs Spring to try to deserialize the Request JSON into a `Fruit` object and inject it as an argument to our handler method. We can then do whatever we need to do with the Java Object (in this case - save it off). We have omitted input checking for brevity but always remember to sanitize your inputs in real applications!

Run the application again by executing the command:

```
mvn spring-boot:run
```

This time we will use the included web application into the *Fruit App* Tab to POST new Fruits to the application. Add a Fruit name into the `Add a Fruit` text box and click the `Save` button. If all is well it should show up in the right-hand `Fruits List` view.

Press **<kbd>CTRL</kbd>+<kbd>C</kbd>** to stop the application.

**5. Add PUT Mapping**

Next let's add a handler for accepting HTTP PUT requests to update existing entries.

From *Visual Editor* Tab, copy the following at the `// TODO PUT mapping` line:


```java
    @PutMapping("/{id}")
    public Fruit updateFruit(@PathVariable("id") Long id, @RequestBody Fruit fruit) {
        fruit.setId(id);
        return repository.save(fruit);
    }
```

Save the file.

Just like the `@GetMapping` above this PUT handler handles requests to a path segment of the `/api/fruits` URI. In this case it handles routes like `PUT /api/fruits/1`. The route defines the ID being updated and the `@RequestBody`, just like in the POST mapping, contains the JSON payload for the Fruit change.

Run the application again by executing the command:

```
mvn spring-boot:run
```

Again we will use the included web application in the *Fruit App* Tab to edit existing Fruits with a HTTP PUT to the application. Click the `Edit` button on one of the Fruits. It's name will populate the `Add a Fruit` text box. Change it to something else and click the `Save` button. If all is well it should show up in the right-hand `Fruits List` view with the new name.

Press **<kbd>CTRL</kbd>+<kbd>C</kbd>** to stop the application.

**6. Add DELETE Mapping**

Finally, let's add a handler for accepting HTTP DELETE requests to delete existing entries.

From *Visual Editor* Tab, copy the following at the `// TODO DELETE mapping` line:

```java
    @DeleteMapping("/{id}")
    public void delete(@PathVariable("id") Long id) {
        repository.deleteById(id);
    }
```

Save the file.

We are again utilizing a route segment to specify an ID in the route. Thus this handler will handle routes like `DELETE /api/fruits/1`.

Run the application once more by executing the

```
mvn spring-boot:run
```

This time we will use the included web application from the *Fruit App* Tab to DELETE Fruits from the application. Click the `Remove` button next to any of the Fruit entries. If all is well it should remove that Fruit from the List.

>**NOTE**: Do not blindly accept IDs like this in your path for deletion in production applications! Make sure there is some level of security to ensure this functionality cannot be abused.

Press **<kbd>CTRL</kbd>+<kbd>C</kbd>** to stop the application.

## Congratulations

You have now learned how to how to create RESTful Web APIs with Spring Boot!

In next step of this scenario, you will learn how to access and login to your OpenShift environment.