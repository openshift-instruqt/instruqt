---
slug: 02-inject-bean
id: zpbqa1divk21
type: challenge
title: Topic 2 - Adding a custom CDI bean to the demonstration application
teaser: Topic 2 - Adding a custom CDI bean to the demonstration application
notes:
- type: text
  contents: Topic 2 - Adding a custom CDI bean to the demonstration application
tabs:
- id: vdp45wyvrgjz
  title: Terminal 1
  type: terminal
  hostname: crc
- id: 7yykroor4l7c
  title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/quarkus/getting-started
- id: nizebpzlngqi
  title: Terminal 2
  type: terminal
  hostname: crc
- id: b8v8ljkwbip0
  title: Dev UI
  type: service
  hostname: crc
  path: /q/dev
  port: 8080
difficulty: basic
timelimit: 800
---
In the previous step you created a basic RESTful Java application with Quarkus. In this topic you'll add a custom [CDI bean](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.2/html/development_guide/contexts_and_dependency_injection) that uses the Quarkus **ArC** extension.  ArC is a [CDI](https://www.cdi-spec.org/)-based dependency injection [solution](https://quarkus.io/guides/cdi-reference.html) tailored for the Quarkus architecture.

# Adding the custom CDI bean to the RESTful application

The custom CDI bean you're going to add will create an additional endpoint to the demonstration API application.

The new endpoint will be `/hello/greeting/{name}`. You will substitute a value on the `{name}` parameter at runtime, for example `/hello/greeting/Barry`.

----

`Step 1` Click the **Visual Editor** tab in the horizontal menu bar above the interactive terminal window on the left.

----

`Step 2:` Once the editor is open, go to the directory tree on the left side of the editor and navigate the directory `./getting-started/src/main/java/org/acme/`

----

`Step 3:` Create the file `GreetingService.java` by clicking the **New File** icon as shown in the figure below.

![Create Icon](../assets/create-icon.png)

----

`Step 4:` And the following code to the newly created file `GreetingService.java`.

```java
package org.acme;

import jakarta.enterprise.context.ApplicationScoped;

@ApplicationScoped
public class GreetingService {

    public String greeting(String name) {
        return "hello " + name;
    }

}
```

----

`Step 5:`  Reopen the file `GreetingResource.java` and replace all the code in that file with the code shown below.

```java
package org.acme;

import jakarta.inject.Inject;
import jakarta.ws.rs.GET;
import jakarta.ws.rs.Path;
import jakarta.ws.rs.PathParam;

@Path("/hello")
public class GreetingResource {

    @Inject
    GreetingService service;

    @GET
    @Path("/greeting/{name}")
    public String greeting(String name) {
        return service.greeting(name);
    }

    @GET
    public String hello() {
        return "Hello from Quarkus REST";
    }
}
```

----

The code you added above will create a new endpoint in the demonstration API application. That new endpoint is `hello/greeting/{name}`.

Notice that the endpoint has the parameter `{name}` defined in the URL. The value passed to the parameter will be appended to the API response.

Thus, a call to `/hello/greeting/Barry` will result in the response `hello Barry`.


# Inspecting the results

Let's verify that the new code works according to expectation.

`Step 6:` Click the **Terminal 2** tab on the horizontal menu bar over the pane to the left.

----

`Step 7:` Run the following command in the **Terminal 2** window that appears:

```console
curl -w "\n" localhost:8080/hello/greeting/quarkus
```

You'll get the following output:

```
hello quarkus
```

You are seeing `hello quarkus` because `quarkus` is the value of the `{name}` parameter prescribed in the endpoint URL `hello/greeting/{name}`.


# Adding a unit test

Let's add another test for Quarkus to run continuously. The new test will exercise the new endpoint  `hello/greeting/{name}`

----

`Step 8:` Bring up the visual editor in the **Visual Editor** tab over the terminal window to the left.

----

`Step 9:` Navigate to the testing directory `getting-started/src/test/java/org/acme/`

----

`Step 10:` Open `GreetingResourceTest.java`.

----

`Step 11a:` Replace the existing code with the following code:

```java
package org.acme;

import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.Test;

import static io.restassured.RestAssured.given;
import static org.hamcrest.CoreMatchers.is;
import static org.hamcrest.CoreMatchers.startsWith;

import java.util.UUID;

@QuarkusTest
class GreetingResourceTest {
    @Test
    void testHelloEndpoint() {
        given()
                .when().get("/hello")
                .then()
                .statusCode(200)
                .body(is("Hello from Quarkus REST"));
    }

    @Test
    public void testGreetingEndpoint() {
        String uuid = UUID.randomUUID().toString();
        given()
                .pathParam("name", uuid)
                .when().get("/hello/greeting/{name}")
                .then()
                .statusCode(200)
                .body(startsWith("hello " + uuid));
    }


}
```

You have created a new unit test named `testGreetingEndpoint`

# Understanding the new unit test

The unit test `testGreetingEndpoint` generates a random string in the form of an UUID. The UUID is applied as the `{name}` parameter to the new endpoint `/hello/greeting/{name}`.

The unit test calls the actual endpoint using the applied UUID. The unit test inspects the response from the API application to verify that the response body is the `hello + {name}` string submitted.


# Viewing the test results

`Step 12a:` Click the **Dev UI** tab over the terminal window to the left to display the Developer UI pane.

----

`Step 12b:` Click the `Continuous Testion` on the left menu. Hit the `Start` button.

![Developer Runtime Console](../assets/run-dev-ui-test.png)

----

`Step 12c:` You'll see an `All tests passed` message in a green font at the right side of the Developer Runtime Console as shown in the figure above at Callout 3.

![Developer Runtime Console](../assets/run-dev-ui-test-passed.png)

# Congratulations!

In this track you learned how to create a CDI bean that represents an additional endpoint in the **Getting Started** demonstration API application.

Also, you learned how to write and run a unit test to verify that the new endpoint works according to expectation.

In the next step, we'll package and run it as a standalone executable JAR.

----

**NEXT:** Packaging a custom CDI bean in to a .jar file


