---
slug: step1
id: qamvzlx2smer
type: challenge
title: Adding a Quarkus Reactive Messaging Extension
notes:
- type: text
  contents: |
    In this scenario, you will create a Quarkus application that uses the [MicroProfile Reactive Messaging](https://download.eclipse.org/microprofile/microprofile-reactive-messaging-1.0/microprofile-reactive-messaging-spec.pdf) extension to send events to Apache Kafka.

    Kafka is generally used for two broad classes of applications:

    - Building real-time streaming data pipelines that reliably get data between systems or applications
    - Building real-time streaming applications that transform or react to the streams of data

    The Quarkus extension uses [SmallRye Reactive Messaging](https://smallrye.io/smallrye-reactive-messaging/smallrye-reactive-messaging/2/index.html) to implement the connectors to Kafka. SmallRye is a framework for building event-driven, data streaming, and event-sourcing applications using [Context and Dependency Injection](http://www.cdi-spec.org/) (CDI) for Java.

    ## Channels and Streams

    When dealing with an event-driven or data streaming application, there are a few concepts and terms we need to understand.

    In the application, `messages` flow on a _channel_. A _channel_ is a virtual destination identified by a name. SmallRye connects the component to a channel they read and to a channel they populate. The resulting structure is a stream: Messages flow between components through channels.

    ## Connectors

    An application interacts with an event broker, which transmits messages using _connectors_. A _connector_ is a piece of code that connects to a broker to:

    1. Receive messages from the event broker and propagate them to the application
    2. Send messages provided by the application to the broker

    To achieve this, connectors are configured to map incoming messages to a specific *channel* (consumed by the application), and to collect outgoing messages sent to a specific channel by the application.

    Each connector has a name. This name is referenced by the application to indicate that a specific channel is managed by this connector.

    ## Apache Kafka Connector

    A Kafka connector adds support for Kafka to SmallRye. With it you can receive Kafka Records as well as write `message` into Kafka.

    The Kafka Connector is based on the [Vert.x Kafka Client](https://vertx.io/docs/vertx-kafka-client/java/).
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /opt/projects/kafka-quarkus
difficulty: basic
timelimit: 460
---
You start this scenario with a basic Maven-based application, which is created using the Quarkus maven plugin.

### Add an extension to integrate with Kafka

The current project needs the extensions to be added to integrate Quarkus with Apache Kafka.

Change to the project folder:

```
cd /opt/projects/kafka-quarkus
```

Install the extension into the project with the following command:

```
mvn quarkus:add-extension -Dextension="quarkus-smallrye-reactive-messaging-kafka"
```

>The first time you add the extension will take longer, as Maven downloads new dependencies.

This will add the necessary entries in your `pom.xml` to bring in the Kafka extension. From *Visual Editor* Tab, you should see a fragment similar to this around line 50:

```xml
...
<dependency>
    <groupId>io.quarkus</groupId>
    <artifactId>quarkus-smallrye-reactive-messaging-kafka</artifactId>
</dependency>
...
```

### Configure a channel to integrate with the event broker

Next, we need to configure the application to define how are we going to connect to the event broker.

The MicroProfile Reactive Messaging properties are structured as follows:

```properties
mp.messaging.[outgoing|incoming].{channel-name}.property=value
```

The `channel-name` segment must match the value set in the `@Incoming` and `@Outgoing` annotations. To indicate that a channel is managed by the Kafka connector we need:

```properties
mp.messaging.[outgoing|incoming].{channel-name}.connector=smallrye-kafka
```

From *Visual Editor* Tab, open the `src/main/resources/application.properties` file to add the following configuration:

```text
# Configuration file
kafka.bootstrap.servers=my-cluster-kafka-bootstrap.kafka.svc.cluster.local:9092

mp.messaging.outgoing.uber.connector=smallrye-kafka
mp.messaging.outgoing.uber.key.serializer=org.apache.kafka.common.serialization.StringSerializer
mp.messaging.outgoing.uber.value.serializer=org.apache.kafka.common.serialization.StringSerializer
```

You can see we added the kafka bootstrap server hostname and port for the broker locations and the configuration for a channel named `uber`. The `key` and `value` serializers are part of the  [Producer configuration](https://kafka.apache.org/documentation/#producerconfigs) and [Consumer configuration](https://kafka.apache.org/documentation/#consumerconfigs) to encode the message payload.

>You don’t need to set the Kafka topic. By default, it uses the channel name (`uber`). You can, however, configure the topic attribute to override it.
