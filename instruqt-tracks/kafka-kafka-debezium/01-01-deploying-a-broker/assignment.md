---
slug: 01-deploying-a-broker
id: ecnow9zedbi3
type: challenge
title: Deploying a Kafka broker
notes:
- type: text
  contents: |
    Change data capture, or CDC, is a well-established software design pattern for capturing changes to tables in a database.
    CDC captures row-level changes that occur in database tables and emits event records for those changes to a Kafka data streaming bus.
    You can configure applications that rely on the data in particular tables to consume the change event streams for those tables.
    Consuming applications read the streams of event records in the order in which the events occurred.

    ### What you will learn

    In this scenario you will learn about [Debezium](https://debezium.io/), a component of [Red Hat Integration](https://www.redhat.com/en/products/integration) that provides change data capture for the following supported databases:

    * Db2
    * Microsoft SQL Server
    * MongoDB
    * MySQL
    * PostgreSQL

    You will deploy a complete end-to-end solution that captures events from database transaction logs and makes those events available for processing by downstream consumers through an [Apache Kafka](https://kafka.apache.org/) broker.

    ### What is Debezium?

    ![Logo](https://github.com/openshift-instruqt/instruqt/blob/master/kafka/kafka-debezium/assets/debezium-logo.png?raw=true)

    [Debezium](https://debezium.io/) is a set of distributed services that capture row-level changes in a database.
    Debezium records the change events for each table in a database to a dedicated Kafka topic.
    You can configure applications to read from the topics that contain change event records for data in specific tables.
    The consuming applications can then respond to the change events with minimal latency.
    Applications read event records from a topic in the same order in which the events occurred.

     A Debezium source connector captures change events from a database and uses the [Apache Kafka](https://kafka.apache.org/) streaming platform to distribute and publish the captured event records to a [Kafka broker](https://kafka.apache.org/documentation/#uses_messaging).
    Each Debezium source connector is built as a plugin for [Kafka Connect](https://kafka.apache.org/documentation/#connect).

    In this scenario we will deploy a Debezium MySQL connector and use it to set up a data flow between a MySQL database and a Kafka broker.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/debezium/
difficulty: intermediate
timelimit: 400
---
Debezium uses the Apache Kafka Connect framework. Debezium connectors are implemented as Kafka Connector source connectors.

Debezium connectors capture change events from database tables and emit records of those changes to a [Red Hat AMQ Streams](https://developers.redhat.com/blog/2018/10/29/how-to-run-kafka-on-openshift-the-enterprise-kubernetes-with-amq-streams/) Kafka cluster. Applications can consume event records through AMQ Streams.

In AMQ Streams, you use Kafka Connect custom Kubernetes resources to deploy and manage the Debezium connectors.

### Logging in to the cluster


Access the OpenShift Web Console to login from the Web UI and access the `dev` project:

```
oc get routes console -n openshift-console -o jsonpath='{"https://"}{.spec.host}{"\n"}'
```

Copy the URL from the output of the above command or click to it to open it in your browser.

We'll deploy our app as the `developer` user. Use the following credentials:

* Username:
```
developer
```

* Password:
```
developer
```

Log in to the OpenShift cluster from a _terminal_ with the following command:

```
oc login -u developer -p developer
```

### Creating a namespace

Create a namespace (project) with the name `debezium` for the AMQ Streams Kafka Cluster Operator:

```
oc new-project debezium
```

### Creating a Kafka cluster

Now we'll create a Kafka cluster named `my-cluster` that has one ZooKeeper node and one Kafka broker node.
To simplify the deployment, the YAML file that we'll use to create the cluster specifies the use of `ephemeral` storage.

> **Note:**
    Red Hat AMQ Streams Operators are pre-installed in the cluster. Because we don't have to install the Operators in this scenario,`admin` permissions are not required to complete the steps that follow. In an actual deployment, to make an Operator available from all projects in a cluster, you must be logged in with `admin` permission before you install the Operator.

Create the Kafka cluster by applying the following command:

```
oc -n debezium apply -f /root/projects/debezium/kafka-cluster.yaml
```

### Checking the status of the Kafka cluster

Verify that the ZooKeeper and Kafka pods are deployed and running in the cluster.

Enter the following command to check the status of the pods:

```
oc -n debezium get pods -w
```

After a few minutes, the status of the pods for ZooKeeper, Kafka, and the AMQ Streams Entity Operator change to `running`.
The output of the `get pods` command should look similar to the following example:

```bash
NAME                                         READY  STATUS
my-cluster-zookeeper-0                       0/1    ContainerCreating
my-cluster-zookeeper-0                       1/1    Running
my-cluster-kafka-0                           0/2    Pending
my-cluster-kafka-0                           0/2    ContainerCreating
my-cluster-kafka-0                           0/2    Running
my-cluster-kafka-0                           1/2    Running
my-cluster-kafka-0                           2/2    Running
my-cluster-entity-operator-57bb594d9d-z4gs6  0/2    Pending
my-cluster-entity-operator-57bb594d9d-z4gs6  0/2    ContainerCreating
my-cluster-entity-operator-57bb594d9d-z4gs6  0/2    Running
my-cluster-entity-operator-57bb594d9d-z4gs6  1/2    Running
my-cluster-entity-operator-57bb594d9d-z4gs6  2/2    Running
```

> Notice that the Cluster Operator starts the Apache ZooKeeper clusters, as well as the broker nodes and the Entity Operator.
The ZooKeeper and Kafka clusters are based in Kubernetes StatefulSets.

Enter <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the process.

`^C`

### Verifying that the broker is running

Enter the following command to send a message to the broker that you just deployed:

```
echo "Hello world" | oc exec -i -c kafka my-cluster-kafka-0 -- /opt/kafka/bin/kafka-console-producer.sh --bootstrap-server localhost:9092 --topic test
```

The command does not return any output unless it fails.
If you see warning messages in the following format, you can ignore them:

```
>[DATE] WARN [Producer clientId=console-producer] Error while fetching metadata with correlation id 1 : {test=LEADER_NOT_AVAILABLE} (org.apache.kafka.clients.NetworkClient)
```

The error is generated when the producer requests metadata for the topic, because the producer wants to write to a topic and broker partition leader that does not exit yet.

To verify that the broker is available, enter the following command to retrieve a message from the broker:

```
oc exec -c kafka my-cluster-kafka-0 -- /opt/kafka/bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic test --from-beginning --max-messages 1
```

The broker processes the message that you sent in the previous command, and it returns the ``Hello world`` string.

You have successfully deployed the Kafka broker service and made it available to clients to produce and consume messages.

In the next step of this scenario, we will deploy a single instance of Debezium.
