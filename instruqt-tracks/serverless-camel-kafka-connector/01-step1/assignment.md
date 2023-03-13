---
slug: step1
id: zlfqmxoxbvni
type: challenge
title: Step 1
notes:
- type: text
  contents: |2

    This scenario will introduce [Camel Kafka Connector ](https://camel.apache.org/camel-kafka-connector/latest/index.html).

    ## What is Camel Kafka Connector?


    ![Logo](https://upload.wikimedia.org/wikipedia/commons/1/11/Apache_Camel_Logo.svg)


    ### Kafka Connector with a Camel twist -- connect to ALMOST anything

    Camel Kafka Connector enables you to use standard Camel components as Kafka Connect connectors. This widens the scope of possible integrations beyond the external systems supported by Kafka Connect connectors alone. Camel Kafka Connector works as an adapter that makes the popular Camel component ecosystem available in Kafka-based AMQ Streams on OpenShift.

    Camel Kafka Connector provides a user-friendly way to configure Camel components directly in the Kafka Connect framework. Using Camel Kafka Connector, you can leverage Camel components for integration with different systems by connecting to or from Camel Kafka sink or source connectors. You do not need to write any code, and can include the appropriate connector JARs in your Kafka Connect image and configure connector options using custom resources.


    ### AMQ Streams - Kubernetes-native Apache Kafka

    The Red Hat AMQ streams component is a massively scalable, distributed, and high-performance data streaming platform based on the Apache Kafka project. It offers a distributed backbone that allows microservices and other applications to share data with high throughput and low latency.

    As more applications move to Kubernetes and Red Hat OpenShift , it is increasingly important to be able to run the communication infrastructure on the same platform. Red Hat OpenShift, as a highly scalable platform, is a natural fit for messaging technologies such as Kafka. The AMQ streams component makes running and managing Apache Kafka OpenShift native through the use of powerful operators that simplify the deployment, configuration, management, and use of Apache Kafka on Red Hat OpenShift.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 300
---
In order to run this tutorial, you will need access to an OpenShift environment.
And we also have access to Kafka cluster in the environment. Let's setup the fundamentals.

This tutorial is an simple *Managed File Transfer* scenario, where a laboratory uploads medical reports to an online object store, and we will need to transfer the file from the cloud object store to our local FTP server in order for the legacy system to consume.

![overview](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-camelk/camel-kafka-connector/camel-kafka-step01-overview.png)

## Logging in to the Cluster via CLI

Before creating any applications, login as admin. This will be required if you want to log in to the web console and
use it.

To login to the OpenShift cluster from the _Terminal_ run:

```
oc login -u admin -p admin
```

This will log you in using the credentials:

* **Username:** ``admin``
* **Password:** ``admin``

Use the same credentials to log into the web console.

(OPTIONAL): Click the [Console](https://console-openshift-console-[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com) tab to open the dashboard.

## Create a new namespace for this tutorial

To create a new project called ``camel-kafka`` run the command:

```
oc project camel-kafka
```

## Start up the Kafka Cluster and the Kafka Connect

AMQ Streams simplifies the process of running Apache Kafka in an Openshift cluster.
Now let's deploy a Kafka broker cluster, the AMQ Streams Operator is already subscribed in the cluster,
simply create the cluster by defining the resource definition:

```
oc create -f strimzi/kafka-cluster.yaml
```

Below indicates AMQ Streams has accept the configuration, and now starting to process.
```
kafka.kafka.strimzi.io/my-cluster created
```

If everything goes right, you will be able to see the pods initiated in the namespace:
```
oc get pod -w
```

```
amq-streams-cluster-operator-v1.5.3-7bbf5cdfdc-4kq7q   1/1     Running   0          3m15s
my-cluster-entity-operator-59cf586599-vdmk5            0/3     Running   0          7s
my-cluster-kafka-0                                     2/2     Running   0          40s
my-cluster-kafka-1                                     2/2     Running   0          40s
my-cluster-kafka-2                                     2/2     Running   0          40s
my-cluster-zookeeper-0                                 1/1     Running   0          71s
my-cluster-zookeeper-1                                 1/1     Running   0          71s
my-cluster-zookeeper-2                                 1/1     Running   0          71s
```
Ctrl+C to exit the mode.
