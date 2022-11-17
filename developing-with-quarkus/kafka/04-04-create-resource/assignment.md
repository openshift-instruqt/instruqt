---
slug: 04-create-resource
id: htbziudhginn
type: challenge
title: Topic 4 - Binding a stream to a JAX-RS resource
teaser: Create Java code that exposes data in an internal stream to a RESTful endpoint
notes:
- type: text
  contents: Topic 4 - Binding a stream to a JAX-RS resource
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/quarkus/kafka
difficulty: basic
timelimit: 428
---
In this topic you are going to bind the stream you created previously to a [JAX-RS resource](https://access.redhat.com/documentation/en-us/red_hat_jboss_enterprise_application_platform/7.1/html/developing_web_services_applications/developing_jax_rs_web_services).

# Creating the HTTP resource

`Step 1:` Click the **Visual Editor** tab on the horizontal menu bar over the terminal window to the left.

----

`Step 2:` Use the Visual Editor's directory tree to navigate to the directory `/root/projects/rhoar-getting-started/quarkus/kafka/src/main/java/org/acme/people/stream/`, as shown in the figure below:

![Go To Directory](../assets/go-to-stream.png)

----


`Step 3:` Click `New File` to create a new file named `NameResource.java` in the directory `/root/projects/rhoar-getting-started/quarkus/kafka/src/main/java/org/acme/people/stream/`.


----

`Step 4:` Click the `NameResource.java` file in the directory tree to open the new file for editing.

----

`Step 5:` Copy and paste the following code into the file `NameResource.java`:

```java
package org.acme.people.stream;

import org.eclipse.microprofile.reactive.messaging.Channel;

import org.reactivestreams.Publisher;
import javax.inject.Inject;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

/**
 * A simple resource retrieving the in-memory "my-data-stream"
 * and sending the items as server-sent events.
 */
@Path("/names")
public class NameResource {

    @Inject
    @Channel("my-data-stream") Publisher<String> names;

    @GET
    @Path("/stream")
    @Produces(MediaType.SERVER_SENT_EVENTS)
    public Publisher<String> stream() {
        return names;
    }
}
```

`Step 6:` Click on the `Disk` icon or press `CTRL+S` to save the file.

# Analyzing `NameResource.java`

The code in `NameResource.java` does the following:

  - Declares the RESTful endpoint `/stream`.
  - Uses the `javax` `@Inject` annotation to inject the data stream named `my-data-stream` into the code using to the `@Channel` qualifier annotation.
  - Uses the `@Produces(MediaType.SERVER_SENT_EVENTS)` annotation to indicates that the result of the `stream()` function is sent the the client-side code using [*Server Sent Events*](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events) (SSE).
  - Returns a reactive stream according to the interface [`org.reactivestreams.Publisher`](https://www.reactive-streams.org/reactive-streams-1.0.3-javadoc/org/reactivestreams/Publisher.html).

The `process()` method is called for every Kafka record from the `names` topic (configured in the application, which we'll do later). Every result is sent to the my-data-stream in-memory stream.

In the `src/main/resources/META-INF/resources/index.html` page you'll find code that makes a request to the `/names/stream` endpoint using standard JavaScript running in the browser, and then draws the resulting names using the [D3.js library](https://d3js.org/). The following code snippet is the client-side JavaScript that makes this call:

 ```javascript
 var source = new EventSource("/names/stream");

 source.onmessage = function (event) {
  console.log("received new name: " + event.data);
  // process new name in event.data
  // ...

  // update the display with the new name
  update();
 };
 ```
  The client side code above:

  * Uses your browser’s support for the standard W3C SSE [EventSource API](https://developer.mozilla.org/en-US/docs/Web/API/EventSource) to call the endpoint `/names/stream`
  * *Reacts* to a ` source.onmessage` event by executing the assigned handler function each time a message is received via SSE
  * Refreshes the display using the D3.js library


**Congratulations!**

You've inserted the Java code that creates the JAX-RS resource and its endpoint. You analyzed how the code you inserted works. Also, you reviewed the logic behind the client-side JavaScript that binds to JAX-RS resource.

----

**NEXT:** Configuring the Quarkus application to bind to Kafka
