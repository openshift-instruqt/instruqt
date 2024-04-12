---
slug: step1
id: zn6xkmasyxst
type: challenge
title: Deploying the HTTP Bridge
notes:
- type: text
  contents: |
    Apache Kafka uses a custom protocol on top of TCP/IP for communication between applications and the Kafka cluster. Clients are supported in many different programming languages, but there are certain scenarios where it is not possible to use such clients. In this situation, you can use the standard HTTP/1.1 protocol to access Kafka instead.

    The Red Hat AMQ Streams Kafka Bridge provides an API for integrating HTTP-based clients with a Kafka cluster running on AMQ Streams. Applications can perform typical operations such as:

    * Sending messages to topics
    * Subscribing to one or more topics
    * Receiving messages from the subscribed topics
    * Committing offsets related to the received messages
    * Seeking to a specific position

    As with AMQ Streams, the Kafka Bridge is deployed into an OpenShift cluster using the AMQ Streams Cluster Operator, or installed on Red Hat Enterprise Linux using downloaded files.

    ![HTTP integration](https://access.redhat.com/webassets/avalon/d/Red_Hat_AMQ-7.7-Using_AMQ_Streams_on_OpenShift-en-US/images/750556a6bc4af4daeca4b1df0fd24835/kafka-bridge.png)

    In the following tutorial, you will deploy the Kafka Bridge and use it to connect to your Apache Kafka cluster using HTTP.
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
  path: /root/projects/http-bridge
difficulty: intermediate
timelimit: 360
---

Deploying the bridge on OpenShift is really easy using the new `KafkaBridge` custom resource provided by the Red Hat AMQ Streams Cluster Operator.

### Logging in to the Cluster

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

To log in to the OpenShift cluster from the _Terminal_ run:

```
oc login -u developer -p developer
```

This will log you in using the credentials:

* **Username:** ``developer``
* **Password:** ``developer``

Use the same credentials to log in to the web console.


### Switch your own namespace

Switch to the (project) namespace called ``kafka`` where the Cluster Operator manages the Kafka resources:

```
oc project kafka
```

### Deploying Kafka Bridge to your OpenShift cluster

The deployment uses a YAML file to provide the specification to create a `KafkaBridge` resource.

Click the link below to open the custom resource (CR) definition for the bridge:

* `kafka-bridge.yaml`

The bridge has to connect to the Apache Kafka cluster. This is specified in the `bootstrapServers` property. The bridge then uses a native Apache Kafka consumer and producer for interacting with the cluster.

>For information about configuring the KafkaBridge resource, see [Kafka Bridge configuration](https://access.redhat.com/documentation/en-us/red_hat_amq/2020.q4/html-single/using_amq_streams_on_openshift/index#assembly-config-kafka-bridge-str).

Deploy the Kafka Bridge with the custom image:

```
oc -n kafka apply -f /root/projects/http-bridge/kafka-bridge.yaml
```

The Kafka Bridge node should be deployed after a few moments. To watch the pods status run the following command:

```
oc get pods -w -l app.kubernetes.io/name=kafka-bridge
```

You will see the pods changing the status to `running`. It should look similar to the following:

```bash
NAME                                READY   STATUS              RESTARTS   AGE
my-bridge-bridge-6b6d9f785c-dp6nk   0/1     ContainerCreating   0          5s
my-bridge-bridge-6b6d9f785c-dp6nk   0/1     ContainerCreating   0          12s
my-bridge-bridge-6b6d9f785c-dp6nk   0/1     Running             0          27s
my-bridge-bridge-6b6d9f785c-dp6nk   1/1     Running             0          45s
```

> This step might take a couple minutes.

Press <kbd>Ctrl</kbd>+<kbd>C</kbd> to stop the process.

`^C`

### Creating an OpenShift route

After deployment, the Kafka Bridge can only be accessed by applications running in the same OpenShift cluster. If you want to make the Kafka Bridge accessible to applications running outside of the OpenShift cluster, you can expose it manually by using one of the following features:

* Services of types LoadBalancer or NodePort
* Kubernetes Ingress
* OpenShift Routes

An OpenShift `route` is an OpenShift resource for allowing external access through HTTP/HTTPS to internal services such as the Kafka bridge. We will use this approach for our example.

Run the following command to expose the bridge service as an OpenShift route:

```
oc expose svc my-bridge-bridge-service
```

When the route is created, the Kafka Bridge is reachable from outside the cluster. You can now use any HTTP client to interact with the REST API exposed by the bridge to send and receive messages without needing to use the native Kafka protocol.
