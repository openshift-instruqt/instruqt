---
slug: step2
id: djq7ycrosq8o
type: challenge
title: Creating an event generator
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
This project has already a `VehicleGenerator` class that will be used to send events to Kafka. However, it is missing the Reactive Messaging code.

### Writing Kafka Records

The Kafka connector can write Reactive Messaging messages as Kafka records.

From *Visual Editor* Tab, open the `src/main/java/com/redhat/katacoda/kafka/VehicleGenerator.java` file to check the code.

We will be sending the events to the `uber` channel by adding the following method after the `// TODO-publisher` line:

```java
    @Outgoing("uber")
    public Flowable&lt;KafkaRecord&lt;String, String&gt;&gt; generateUber()
    {
        return Flowable.interval(5000, TimeUnit.MILLISECONDS)
                .map(tick -> {
                    VehicleInfo vehicle = randomVehicle("uber");
                    LOG.info("dispatching vehicle: {}", vehicle);
                    return KafkaRecord.of(String.valueOf(vehicle.getVehicleId()), Json.encodePrettily(vehicle));
                });
    }
```

This simple method:

- Instructs Reactive Messaging to dispatch the items from returned stream to the `uber`channel.
- Returns an [RX Java 2 stream](https://github.com/ReactiveX/RxJava) (`Flowable`) emitting random vehicle information every 5 seconds
