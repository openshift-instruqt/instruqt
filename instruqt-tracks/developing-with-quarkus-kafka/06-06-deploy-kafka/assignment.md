---
slug: 06-deploy-kafka
id: uj2j7tzgdyka
type: challenge
title: Topic 6 - Deploying Kafka to OpenShift
teaser: Learn how to host Kafka in an OpenShift project
notes:
- type: text
  contents: Topic 6 - Deploying Kafka to OpenShift
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
In this topic you will deploy a running instance of Kafka in OpenShift. You will then use the `oc` command line tool to log into OpenShift. Then you will create a project in OpenShift using the `oc` command line tool. Finally, you'll deploy Kafka as a [Kubernetes Operator](https://developers.redhat.com/topics/kubernetes/operators).

# Deploying Kafka to OpenShift

By default you are already logged into OpenShift as the `admin` user. Let's ensure that you are indeed logged in as `admin`.

----

`Step 1:` Run the following command in **Terminal 1** to verify the current OpenShift user is `admin`:


```
oc whoami
```

You will get the following output:

`system:admin`

Next, let's create an OpenShift project.

# Creating an OpenShift project

[Projects](https://docs.openshift.com/container-platform/4.9/rest_api/project_apis/project-project-openshift-io-v1.html)
are a top level concept to help you organize your deployments. An OpenShift project allows a community of users, or a single user, to organize and manage their content in isolation from other communities.

----

`Step 2:` Run the following command in **Terminal 1** to create an OpenShift project with the display name `Apache Kafka`:

```
oc new-project kafka --display-name="Apache Kafka"
```

You'll get output similar to the following:

```
Now using project "kafka" on server "https://api.crc.testing:6443".

You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app rails-postgresql-example

to build a new example application in Ruby. Or use `kubectl` to deploy a simple Kubernetes application:

    kubectl create deployment hello-node --image=k8s.gcr.io/serve_hostname
```

You have now created a project in OpenShift. Next let's add the Kafka Operator.


# Deploying a Kafka Operator

To deploy Kafka, we'll use the [**Strimzi** operator](https://strimzi.io/). Strimzi is an open source project that provides an easy way to run an Apache Kafka cluster on Kubernetes in various deployment configurations.


----

`Step 3:` Run the following command in **Terminal 1** to deploy the Operator to a new namespace named `kafka`:

```
oc create -f 'https://strimzi.io/install/latest?namespace=kafka' -n kafka
```
You'll get output similar to the following:

```
rolebinding.rbac.authorization.k8s.io/strimzi-cluster-operator-entity-operator-delegation created
customresourcedefinition.apiextensions.k8s.io/strimzipodsets.core.strimzi.io created
clusterrole.rbac.authorization.k8s.io/strimzi-kafka-client created
customresourcedefinition.apiextensions.k8s.io/kafkausers.kafka.strimzi.io created
clusterrolebinding.rbac.authorization.k8s.io/strimzi-cluster-operator-kafka-broker-delegation created
configmap/strimzi-cluster-operator created
customresourcedefinition.apiextensions.k8s.io/kafkas.kafka.strimzi.io created
clusterrole.rbac.authorization.k8s.io/strimzi-cluster-operator-namespaced created
customresourcedefinition.apiextensions.k8s.io/kafkatopics.kafka.strimzi.io created
customresourcedefinition.apiextensions.k8s.io/kafkaconnects.kafka.strimzi.io created
customresourcedefinition.apiextensions.k8s.io/kafkabridges.kafka.strimzi.io created
customresourcedefinition.apiextensions.k8s.io/kafkaconnectors.kafka.strimzi.io created
clusterrole.rbac.authorization.k8s.io/strimzi-entity-operator created
clusterrole.rbac.authorization.k8s.io/strimzi-cluster-operator-global created
clusterrolebinding.rbac.authorization.k8s.io/strimzi-cluster-operator-kafka-client-delegation created
customresourcedefinition.apiextensions.k8s.io/kafkamirrormakers.kafka.strimzi.io created
clusterrole.rbac.authorization.k8s.io/strimzi-kafka-broker created
customresourcedefinition.apiextensions.k8s.io/kafkamirrormaker2s.kafka.strimzi.io created
customresourcedefinition.apiextensions.k8s.io/kafkarebalances.kafka.strimzi.io created
serviceaccount/strimzi-cluster-operator created
deployment.apps/strimzi-cluster-operator created
clusterrolebinding.rbac.authorization.k8s.io/strimzi-cluster-operator created
rolebinding.rbac.authorization.k8s.io/strimzi-cluster-operator created
```

It might take a minute or two for OpenShift to get the Strimzi operator fully deployed.

----

`Step 4:` Run the following command in **Terminal 1** to observe that the Strimzi operator has fully deployed:

```
oc rollout status -w deployment/strimzi-cluster-operator
```

You'll eventually get output similar to the following:

```bash
Waiting for deployment "strimzi-cluster-operator" rollout to finish: 0 of 1 updated replicas are available...
deployment "strimzi-cluster-operator" successfully rolled out
```

|NOTE:|
|----|
|It might take time to install Kafka depending on system load. If `oc rollout status` seems to be taking a long time, press the CTRL-C keys to terminate the process and run it again.|


# Deploying the Kafka cluster

Before deploying the Kafka cluster, you need to make sure you are on the project folder `projects/rhoar-getting-started/quarkus/kafka/`.

----

`Step 5:` Run the following command in **Terminal 1** to ensure that you are the proper working folder:

```
cd /root/projects/rhoar-getting-started/quarkus/kafka && pwd
```

You will get the following output:

```
/root/projects/rhoar-getting-started/quarkus/kafka
```


Next, you need to create a new `Kafka` object within Kubernetes. The Strimzi operator needs  the `Kafka` object in order to work.

The YAML code as shown below is the contents of the manifest that Kubernetes uses to create the `Kafka` object:

```yaml
apiVersion: kafka.strimzi.io/v1beta1
kind: Kafka
metadata:
  name: names-cluster
spec:
  kafka:
    replicas: 3
    listeners:
      ...
    config:
      ...
    storage:
      type: ephemeral
  zookeeper:
    ...
```

The location of the file that contains the YAML code is `src/main/kubernetes/kafka-names-cluster.yaml`. The file is part of the source code you cloned from GitHub at the start of the track.

----

`Step 6:` Run the following command in **Terminal 1** to create the `Kafka` object using the manifest file `src/main/kubernetes/kafka-names-cluster.yaml`.

```
oc apply -f src/main/kubernetes/kafka-names-cluster.yaml
```

You'll get output similar to the following.

```
kafka.kafka.strimzi.io/names-cluster created
```

You have now created the required Kafka object.

# Deploying the Kafka topic

You need to create a **topic** for the demonstration application to stream both to and from. You'll create the topic using a manifest file as you did previously to create the `Kafka` object.

The contents of the manifest file named, `kafka-names-topic.yaml` is shown in the YAML file below:

```yaml
apiVersion: kafka.strimzi.io/v1beta1
kind: KafkaTopic
metadata:
  name: names-topic
  labels:
    strimzi.io/cluster: names-cluster
spec:
  partitions: 1
  replicas: 1
  config:
    retention.ms: 7200000
    segment.bytes: 1073741824
```

----

`Step 7:` Run the following command in **Terminal 1** to create the **topic** object in OpenShift:

```
oc apply -f src/main/kubernetes/kafka-names-topic.yaml
```

You'll get output similar to the following:

```
kafkatopic.kafka.strimzi.io/names-topic created
```

You have just created the `names` topic that the demonstration code and Quarkus configuration references.

# Confirming the deployment

Finally, let's look at the list of pods being spun up to determine that the Kafka pods are in the OpenShift cluster.

----

`Step 8:` Run the following command in **Terminal 1** to get a list of pods and then pipe the response to `grep` to filter out only those pods that have the string `names-cluster` in its name:

(It might take a minute or so for all the pods to appear.)

```
oc get pods | grep names-cluster
```

You'll see output similar to the following:

```bash
names-cluster-entity-operator-6cbfffc465-jthb7   3/3     Running   0          45s
names-cluster-kafka-0                            1/1     Running   0          99s
names-cluster-kafka-1                            1/1     Running   0          99s
names-cluster-kafka-2                            1/1     Running   0          99s
names-cluster-zookeeper-0                        1/1     Running   0          2m31s
names-cluster-zookeeper-1                        1/1     Running   0          2m31s
names-cluster-zookeeper-2                        1/1     Running   0          2m31s
```

Keep running the above command until you see the following:

* Three pods that start with the string `names-cluster-kafka` and reports 1/1 running.
* Three pods that start with the string `names-cluster-zookeeper` and report 1/1 running.
* A single entry that starts with the string `names-cluster-entity-operator` reports 3/3 running.


It could take around two minutes to get all if the Kafka pods up and running. Once they are, you now have a Kafka cluster running under OpenShift.

**Congratulations!**

You've created an OpenShift project and deployed a [**Strimzi** operator](https://strimzi.io/) under the project. Also you created a topic named `names-topic`. Finally you verified that the expected pods are up and running in the OpenShift cluster.

----

**NEXT:** Adding the OpenShift extensions to Quarkus

