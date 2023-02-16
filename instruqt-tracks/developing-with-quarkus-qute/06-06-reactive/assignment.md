---
slug: 06-reactive
id: kvoiqhbcn63y
type: challenge
title: Topic 6 - Integrating reactive programming with Qute templates
notes:
- type: text
  contents: Topic 5 - Integrating reactive programming with Qute template
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/quarkus/qute
- title: Qute Reactive
  type: service
  hostname: crc
  path: /reactive
  port: 8080
difficulty: basic
timelimit: 500
---
# Reactive and Asynchronous APIs

Quarkus is a [reactive](https://developers.redhat.com/coderland/reactive/reactive-intro) framework. Under the hood, [Eclipse Vert.x](https://vertx.io) is the reactive engine powering Quarkus applications.

Every IO interactions with Quarkus pass through the non-blocking and reactive Vert.x engine. All of the HTTP requests your application receives are handled by [event loops](https://www.redhat.com/en/blog/troubleshooting-performance-vertx-applications-part-i-%E2%80%94-event-loop-model). Then, requests are routed toward the code that manages the request.

Depending on the destination, Vert.x will invoke the code managing the request on a worker thread (Servlet, Jax-RS) or use the IO Thread (reactive route).

[Mutiny](https://github.com/smallrye/smallrye-mutiny) is a reactive programming library for composing and expressing asynchronous actions.

Qute templates can be asynchronously rendered as a `CompletionStage<String>`, completed with the rendered output asynchronously, or as `Publisher<String>` containing the rendered chunks.

When the results of rendering are returned in a REST endpoint, the endpoint will be processed asynchronously, saving compute resources by not creating many threads to handle requests.

Let's compare `CompletionStage<String>` and `Publisher<String>` rendering by creating a traditional (blocking) endpoint and an async endpoint.

Quarkus [reactive routes](https://quarkus.io/guides/reactive-routes) provide an alternative approach to implementing HTTP endpoints in which you declare and chain routes. This approach became very popular in the JavaScript world, with frameworks like Express.Js or Hapi.

Quarkus also offers the possibility to use reactive routes. You can implement a REST API with routes only, or combine them with JAX-RS resources and servlets.

## Create a reactive report generator

You've already added the `quarkus-vertx-web` extension, which gives us the ability to declare reactive routes.

Let's create create a reactive route that will process a Qute template.

----

`Step 1a:` Using the **Visual Editor**, navigate to the directory `qute/src/main/java/org/acme/`.

`Step 1b:` Click on the `New File` icon to create a file named `ReactiveResource.java` in the `qute/src/main/java/org/acme/` directory, as shown in the figure below.

![Create Reactive Resource](../assets/create-reative-resource.png)

`Step 1c:` Add the following code to the file `ReactiveResource.java`:

```java
package org.acme;

import io.quarkus.qute.Template;
import io.quarkus.qute.Location;
import io.quarkus.vertx.web.Route;
import io.quarkus.vertx.web.RoutingExchange;
import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.ws.rs.core.MediaType;

@ApplicationScoped
public class ReactiveResource {

    @Inject
    SampleService service;

    @Location("reports/v1/report_01.json.template")
    Template report;

    @Route(path = "/reactive", methods = Route.HttpMethod.GET, produces = MediaType.APPLICATION_JSON)
    void reactive(RoutingExchange ex) throws Exception {
        report
          .data("samples",service.get())
          .data("now", java.time.LocalDateTime.now())
          .renderAsync()
          .thenAccept((val) -> ex.ok(val));
    }
}
```

`Step 1d:` Click on the `Disk` icon or press `CTRL+S` keys to save the `ReactiveResource.java` file.

**KEY POINTS TO UNDERSTAND:**

* The [`@Route`](https://quarkus.io/guides/reactive-routes) annotation indicates that the method is a reactive route. Again, by default, the code contained in the method must not block.
* The Qute `.renderAsync()` method will be completed asynchronously using the rendered template.
* The method `reactive(RoutingExchange ex)` takes a `RoutingExchange` as a parameter. [`RoutingExchange`](https://javadoc.io/doc/io.quarkus/quarkus-vertx-web/1.3.0.Final/io/quarkus/vertx/web/RoutingExchange.html) is a convenient wrapper of [`RoutingContext`](https://vertx.io/docs/apidocs/io/vertx/ext/web/RoutingContext.html). `RoutingContext` provides many useful methods. For example, you can use `RoutingContext` to retrieve the HTTP request using the `request()` method and write the response using the `response().end(...​)` method.

|FOLLOW-UP LEARNING:|
|----|
|More details about using the RoutingContext are available in the [Vert.x Web documentation](https://vertx.io/docs/vertx-web/java/).|

## Exercising the endpoint

`Step 2` Run the following command in **Terminal 1** to exercise the endpoint `/reactive`:

```
curl http://localhost:8080/reactive
```

You will see output similar to following:

```
{
    "time": "2022-04-21T22:41:37.403110",
    "samples": [
      {"name": "James","data": "--Invalid--"},
      {"name": "Shaaf","data": "0.3788262353537757"}
    ]
  }
```
----


`Step 3` Run the following command in **Terminal 1** to view the continuous data output that the demonstration application reports:

``` console
tail -f /tmp/report.json
```

You'll get continuous screen output similar to the following snippet:

```console
{
    "time": "2022-04-21T22:42:52.999879",
    "samples": [
      {"name": "Sally","data": "--Invalid--"},
      {"name": "Sally","data": "--Invalid--"},
      {"name": "James","data": "--Invalid--"},
      {"name": "Jeff","data": "--Invalid--"}
    ]
  }
{
    "time": "2022-04-21T22:42:53.999947",
    "samples": [
      {"name": "Jeff","data": "0.42632033789103496"},
      {"name": "Jeff","data": "--Invalid--"},
      {"name": "Daniel","data": "--Invalid--"},
      {"name": "James","data": "0.10235496503565633"},
      {"name": "Sally","data": "0.036955808154788605"}
    ]
  }
```

|FOLLOW UP LEARNING:|
|----|
|To learn more about Quarkus and reactive programming, check out the free e-book [Quarkus for Spring Developers](https://developers.redhat.com/e-books/quarkus-spring-developers).|


# Congratulations!

In this track you learned how to implement reactive programming under Quarkus and [Eclipse Vert.x](https://vertx.io).

You created a new RESTful resource, `ReactiveResource`, that creates the endpoint `/reactive`. This endpoint processes a Qute template asynchronously. Output is emitted continuously.

As you've observed, Qute provides a powerful, flexible, type-safe and reactive way to render templates using concepts and techniques familiar to many Java developers.

----

This is the last topic in this track.

To learn more about Qute, please refer to the [Qute reference guide](https://quarkus.io/guides/qute-reference).

# Continue to learn more in Red Hat CodeReady Workspaces

You can continue your learning path by working with Quarkus and Qute lessons from within the Red Hat CodeReady Workspaces cloud based IDE.

The [Red Hat CodeReady Workspaces](https://developers.redhat.com/products/codeready-workspaces/overview) IDE runs on a free [Developer Sandbox for Red Hat OpenShift](http://red.ht/dev-sandbox).

Go [here](https://workspaces.openshift.com) to log in or to register if you're a new user. This free service expires after 30 days, but you can always enable a new free 30-day subscription.

Once logged in, [go here](https://workspaces.openshift.com/f?url=https://raw.githubusercontent.com/openshift-katacoda/rhoar-getting-started/solution/quarkus/qute/devfile.yaml) to open the solution for this project in the cloud IDE. If you're asked to update or install any plugins while loading, you can say no.
