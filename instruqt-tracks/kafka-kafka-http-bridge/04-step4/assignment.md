---
slug: step4
id: rdkuij0su51v
type: challenge
title: Consuming messages
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/http-bridge
difficulty: intermediate
timelimit: 360
---
Finally, retrieve the latest messages from the Kafka Bridge consumer by requesting data from the `/consumers/{groupid}/instances/{name}/records` endpoint.

### Retrieving the latest messages from a Kafka Bridge consumer

Using a HTTP GET method against the records endpoint performs a _poll_ for retrieving messages from the already subscribed topics. The first poll operation after the subscription doesn’t always return records. because it just starts the join operation of the consumer to the group, and the rebalancing in order to get partitions assigned. Doing the next poll returns the messages if there are any in the topic.

Submit a `GET` request to the `records` endpoint:

```
export KAFKA_BRIDGE_SERVICE=`oc get route my-bridge-bridge-service -n kafka -o jsonpath='{.spec.host}'`
curl -s -X GET http://KAFKA_BRIDGE_SERVICE/my-group/instances/my-consumer/records -H 'accept: application/vnd.kafka.json.v2+json' | jq
```

Repeat step a couple more times until you retrieve all messages from the Kafka Bridge consumer.

```
curl -s -X GET http://$KAFKA_BRIDGE_SERVICE/consumers/my-group/instances/my-consumer/records -H 'accept: application/vnd.kafka.json.v2+json' | jq
```

The Kafka Bridge returns an array of messages — describing the topic name, key, value, partition, and offset — in the response body, along with a `200` code. Messages are retrieved from the latest offset by default.

You should get an output similar to the following:

```js
[  {
    "topic": "my-topic",
    "key": "key-1",
    "value": "sales-lead-0001",
    "partition": 0,
    "offset": 0
  },
  {
    "topic": "my-topic",
    "key": "key-2",
    "value": "sales-lead-0002",
    "partition": 0,
    "offset": 1
  }
]
```

### Committing offsets to the log

Next, use the `/consumers/{groupid}/instances/{name}/offsets` endpoint to manually commit offsets to the log for all messages received by the Kafka Bridge consumer. This is required because the Kafka Bridge consumer that you created earlier was configured with the `enable.auto.commit` setting as false.

Commit offsets to the log for `my-consumer`:

```
curl -i -X POST http://$KAFKA_BRIDGE_SERVICE/consumers/my-group/instances/my-consumer/offsets
```

>Because no request body is submitted, offsets are committed for all the records that have been received by the consumer. Alternatively, the request body can contain an array (OffsetCommitSeekList) that specifies the topics and partitions that you want to commit offsets for.

If the request is successful, the Kafka Bridge returns a `204` code only.

Congratulations! You were able to deploy the AMQ Streams Kafka Bridge and connect to a Kafka cluster using HTTP. You sent some message to an example topic and then created a consumer to retrieve messages. Finally you committed the offsets the messages.
