---
slug: 01-op
id: pzfnehtmtl7z
type: challenge
title: Install Operator
notes:
- type: text
  contents: |
    ## Learning Objectives

    This interactive tutorial shows you how to deploy and run a single instance of [RHDG](https://www.redhat.com/en/technologies/jboss-middleware/data-grid) Red Hat Data Grid on OpenShift.

    You then learn how to expose the REST endpoint and invoke simple cache operations.

    ## Introduction to Red Hat Data Grid

    ![Logo](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/dg/logo.png)

    Red Hat Data Grid (RHDG) is an open source, in-memory data store that:

    * Stores data in memory (RAM) to provide fast, low-latency response times and very high throughput.
    * Synchronizes data across multiple nodes for continuous availability, reliability, and elastic scalability.
    * Offers flexibility. You can use it as a distributed cache, NoSQL database, or event broker.

    RHDG capabilities improve application performance and scalability while reducing the need to make expensive calls to database management systems and transactional back ends.
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
# Inspect Java runtime

An appropriate Java runtime has been installed for you. Ensure you can use it by running this command:

> If the command fails, wait a few moments and try again (it is installed in a background process and make take a few moments depending on system load).

```
$JAVA_HOME/bin/java --version
```

The command should report the version in use, for example (the versions and dates may be slightly different than the below example):

```console
openjdk 11.0.10 2021-01-19
OpenJDK Runtime Environment AdoptOpenJDK (build 11.0.10+9)
OpenJDK 64-Bit Server VM AdoptOpenJDK (build 11.0.10+9, mixed mode)
```

## Install Operator

An [Operator](https://www.openshift.com/learn/topics/operators) is a method of packaging, deploying and managing a Kubernetes-native application. A Kubernetes-native application is an application that is both deployed on Kubernetes and managed using the Kubernetes APIs and other administrative tooling.

Operators can be installed using the OpenShift web console, or via the command line and YAML. For simplicity we'll use the CLI for now, and the web console later.

**1. Create namespace**

For this scenario, let's create a project that you will use to house your application. Click:

```
oc new-project dgdemo --display-name="Data Grid Demo"
```

**2. Create OperatorGroup**

Operators need an OperatorGroup to give it the necessary context and permissions to operator, so create it by clicking this command:

```
oc apply -f - << EOF
apiVersion: operators.coreos.com/v1
kind: OperatorGroup
metadata:
 name: datagrid
spec:
 targetNamespaces:
 - dgdemo
EOF
```
`
```

**3. Create Subscription**

And now we can install the Data Grid Operator by creating a _Subscription_ to it. Click here to do that:

```
oc apply -f - << EOF
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
 name: datagrid-operator
spec:
 channel: 8.2.x
 installPlanApproval: Automatic
 name: datagrid
 source: redhat-operators
 sourceNamespace: openshift-marketplace
EOF
```
`
```

Wait for the Operator to be installed using this command:

```
oc rollout status -w deployment/infinispan-operator-new-deploy
```

> **NOTE**: If this command reports **Error from server (NotFound)**, it may take a few moments to download and deploy the operator. Just wait a few seconds and click the command again until it reports success.

Verify the Operator is installed and fully armed and operational:

```
oc get pods
```

You should see a _Running_ status as shown below:

```console
NAME                                   READY   STATUS
infinispan-operator-new-deploy-<id>    1/1     Running
```

**Congratulations!** In the next steps we'll make use of this operator to do all kinds of cool things that Red Hat Data Grid can do. On to the next step!
