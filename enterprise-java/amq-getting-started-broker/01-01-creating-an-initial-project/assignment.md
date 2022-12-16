---
slug: 01-creating-an-initial-project
id: jtixhdl1hzqc
type: challenge
title: Creating an Initial Project
notes:
- type: text
  contents: |
    ## Overview

    AMQ provides fast, lightweight, and secure messaging for Internet-scale applications. AMQ components use industry-standard message protocols and support a wide range of programming languages and operating environments. AMQ gives you the strong foundation you need to build modern distributed applications.

    ## What is AMQ Broker?

    AMQ Broker is a pure-Java multiprotocol message broker. It’s built on an efficient, asynchronous core, with a fast native journal for message persistence and the option of shared-nothing state replication for high availability.

    * **Persistence** - A fast, native-IO journal or a JDBC-based store
    * **High availability** - Shared store or shared-nothing state replication
    * **Advanced queueing** - Last value queues, message groups, topic hierarchies, and large message support
    * **Multiprotocol** - AMQP 1.0, MQTT, STOMP, OpenWire, and HornetQ Core

    AMQ Broker is based on the [Apache ActiveMQ Artemis](https://activemq.apache.org/artemis/) project.

    ## What will you learn

    In this tutorial you will learn how to setup a Red Hat AMQ message broker instance running on OpenShift.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: service
  hostname: crc
  path: /
  port: 30001
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 300
---
To get started, first we need to login to OpenShift.

### Logging in to the Cluster via OpenShift CLI

To login to the OpenShift cluster use the following commmand in your **_Terminal_**:

```
oc login -u admin -p admin
```

> You can click on the above command (and all others in this scenario) to automatically copy it into the terminal and execute it.

This will log you in using the credentials:

* **Username:** ``admin``
* **Password:** ``admin``

You should see the output:

```bash
Login successful.

You don't have any projects. You can try to create a new project, by running

    oc new-project <projectname>
```

For this scenario lets create a project called ``messaging`` by running the command:

```
oc new-project messaging
```

You should see output similar to:

```bash
Now using project "messaging" on server "https://172.17.0.41:8443".

You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app centos/ruby-22-centos7~https://github.com/openshift/ruby-ex.git

to build a new example application in Ruby. Or use kubectl to deploy a simple Kubernetes application:

    kubectl create deployment hello-node --image=gcr.io/hello-minikube-zero-install/hello-node
```

### Install AMQ broker operator

AMQ Broker provides container images and Operators for running ActiveMQ Artemis on OpenShift.

Deploy the Operator Lifecycle Manager Operator Group and Susbcription to easily install the operator in the previously created namespace:

```
oc -n messaging apply -f /opt/operator-install.yaml
```

You should see the following result:

```bash
operatorgroup.operators.coreos.com/broker-operatorgroup created
subscription.operators.coreos.com/amq-broker created
```

> You can also deploy the AMQ broker operator from the OpenShift OperatorHub from within the administration console.

### Check operator deployment

Follow up the operator deployment to validate it is running.

To watch the pods status run the following command:

```
oc -n messaging get pods -w
```

You will see the status of the operator changing until it gets to `running`. It should look similar to the following:

```bash
NAME                                  READY   STATUS              RESTARTS   AGE
amq-broker-operator-6c76986f9-bsrcv   0/1     ContainerCreating   0          1s
amq-broker-operator-6c76986f9-bsrcv   0/1     ContainerCreating   0          2s
amq-broker-operator-6c76986f9-bsrcv   0/1     ContainerCreating   0          7s
amq-broker-operator-6c76986f9-bsrcv   1/1     Running             0          23s
```

Hit <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the process.

`^C`

In the next step, you will deploy a new instance of the AMQ broker.
