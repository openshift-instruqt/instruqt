---
slug: step1
id: c0a0qjockpki
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Serverless Eventing Camel K

    This example demonstrates the idiomatic way of using [Camel K](https://camel.apache.org/camel-k/latest/index.html) in Knative for building event-driven applications. It leverages the Knative eventing broker as the central point that lets various services communicate via event pub/sub. It also shows how Camel K can be used for connecting the Knative event mesh with external systems, with integrations that can play the roles of "event source" or "event sink".

    ## What is Camel K?

    ![Logo](https://www.nicolaferraro.me/images/post-logo-apache-camel-d.png)

    ### Your Integration Swiss-Army-Knife native on Kubernetes with Camel K

    Apache Camel K is a lightweight integration framework built from Apache Camel that runs natively on Kubernetes and is specifically designed for serverless and microservice architectures.

    Camel K supports multiple languages for writing integrations. Based the Operator Pattern, Camel K performs operations on Kubernetes resources. Bringing integration to the next level. utilizing the benefit of the Apache Camel project, such as the wide variety of components and Enterprise Integration Patterns (EIP).

    Camel K integrate seamlessly with Knative making it the best serverless technology for integration.

    ## Why Serverless?
    Deploying applications as Serverless services is becoming a popular architectural style.

    You will need a  platform that can run serverless workloads, while also enabling you to have complete control of the configuration, building, and deployment. Ideally, the platform also supports deploying the applications as linux containers.

    ##  OpenShift Serverless Eventing
    Knative Eventing on OpenShift Container Platform enables developers to use an event-driven architecture with serverless applications. An event-driven architecture is based on the concept of decoupled relationships between event producers that create events, and event sinks, or consumers, that receive them.

    Knative Eventing uses standard HTTP POST requests to send and receive events between event producers and consumers. These events conform to the CloudEvents specifications, which enables creating, parsing, sending, and receiving events in any programming language.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 450
---
In order to run Camel K, you will need access to an Kubernetes/OpenShift environment. Let's setup the fundamentals.

## Logging in to the Cluster via Dashboard

Click the [Console](https://console-openshift-console-[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com) tab to open the dashboard.

You will then able able to login with admin permissions with:

* **Username:** ``admin``
* **Password:** ``admin``

## Installing Camel K from the OpenShift OperatorHub
Camel K Operator can be deployed on the OpenShift cluster from the OperatorHub. The OperatorHub is available from the OpenShift Container Platform web console and provides an interface for cluster administrators to discover and install Operators.

It is responsible for building, deploying Camel Applications and also creating surrounding resources. It is also responsible for watching any code or configuration updates and automatically updates it. To install simply run the command.

In the left navigation menu, click *Catalog* > *OperatorHub*
In the Filter by keyword text box, enter Camel K to find the *Camel K Operator*.
Read the information about the Operator, and click *Install*. This displays the Create Operator Subscription page.

![operatorhub](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-camelk/camel-k-eventing/Eventing-Step1-01-operatorhub.png)

Select the following subscription settings:
- Update Channel > *Stable*
- Installation Mode > *All namespaces on the cluster (default)*
- Approval Strategy > Automatic

![installoperator](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-camelk/camel-k-eventing/Eventing-Step1-02-installoperator.png)

Click Subscribe. This displays the Operators > Installed Operators page.

Wait a few moments until the Status for the Camel K Operator displays Succeeded and the subscription is Up to Date.

![installed](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-camelk/camel-k-eventing/Eventing-Step1-03-installed.png)

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

## Setup Knative Eventing


OpenShift Serverless Eventing is designed to address a common need for cloud native development and provides composable primitives to enable late-binding event sources and event consumers. OpenShift Serverless Operator is subscribed in the cluster already.Let's go ahead and setup Knative Eventing to set the ground for the event mesh.

Creating the knative-eventing namespace:

```
oc new-project knative-eventing
```


Let's go ahead setup KnativeEventing in the namespace

```
oc apply -f serverless/eventing.yaml -n knative-eventing
```

Once Knative Eventing complete it's setup. You will see all the pod in *Running status*, it means it is successfully installed.

```
oc get pod -w
```

```
NAME                                    READY   STATUS      RESTARTS   AGE
broker-controller-6b4659f8cc-nz7hl      1/1     Running     0          89s
broker-filter-659f5549b8-4gcwm          1/1     Running     0          88s
broker-ingress-86c4b766dc-bwn4r         1/1     Running     0          87s
eventing-controller-7d654894f4-mgdvp    1/1     Running     0          97s
eventing-webhook-658fb449b6-hsv66       1/1     Running     0          97s
imc-controller-6bf889454d-k79lf         1/1     Running     0          81s
imc-dispatcher-7dbddfbd5f-9ltlh         1/1     Running     0          81s
mt-broker-controller-5b9986bd46-6svnk   1/1     Running     0          86s
```

Ctrl+C to exit the command.
