---
slug: step4
id: uyqcrtgdqyek
type: challenge
title: Producing and consuming records
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /opt
difficulty: basic
timelimit: 225
---
Kafka clients connect through the network to the Kafka brokers where the topic contains partitions for writing (producing) and reading (consuming) events.

### Producing events

We will use a producer shell script to write events.

To get an interactive terminal issue the following command:

```
oc exec -it my-cluster-kafka-0 -- bash
```

Run the console producer to send one message per line:

```
bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic my-topic
```

You will get a prompt to start sending the messages, try with _hello world!_

```
hello world!
```

Enter some more messages, then press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the process.

`^C`

### Consuming events

Time to read the messages you wrote.

Run the console consumer shell script:

```
bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic my-topic --from-beginning
```

You should see the messages you wrote:

```
hello world!
#...
```

Press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the process.

`^C`

### Congratulations

You successfully completed this scenario! You now know how to deploy a simple Apache Kafka cluster on top of OpenShift using AMQ Streams.
