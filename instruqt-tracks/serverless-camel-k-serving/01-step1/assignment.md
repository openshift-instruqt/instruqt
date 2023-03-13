---
slug: step1
id: o3zvlhfkm7w9
type: challenge
title: Step 1
notes:
- type: text
  contents: |
    # Serverless Camel K

    This scenario demonstrates how to create a simple API based [Camel K](https://camel.apache.org/camel-k/latest/index.html) integration with an OpenAPI definition.

    The simple API application enable users to Create, Read, Update, and Delete to an generic online objects datastore.

    Will also make this RESTFul application Serverless. By allowing this application to scale down to zero. And quickly comes back up and run after being called.


    ## What is Camel K?

    ![Logo](https://www.nicolaferraro.me/images/post-logo-apache-camel-d.png)

    ### Your Integration Swiss-Army-Knife native on Kubernetes with Camel K

    Apache Camel K is a lightweight integration framework built from Apache Camel that runs natively on Kubernetes and is specifically designed for serverless and microservice architectures.

    Camel K supports multiple languages for writing integrations. Based the Operator Pattern, Camel K performs operations on Kubernetes resources. Bringing integration to the next level. utilizing the benefit of the Apache Camel project, such as the wide variety of components and Enterprise Integration Patterns (EIP).

    Camel K integrate seamlessly with Knative making it the best serverless technology for integration. This scenario will get you started and hands on Camel K.

    ## Why Serverless?
    Deploying applications as Serverless services is becoming a popular architectural style.

    You will need a  platform that can run serverless workloads, while also enabling you to have complete control of the configuration, building, and deployment. Ideally, the platform also supports deploying the applications as linux containers.

    ##  OpenShift Serverless

    OpenShift Serverless helps developers to deploy and run applications that will scale up or scale to zero on-demand. Applications are packaged as OCI compliant Linux containers that can be run anywhere. This is known as Serving.
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


## Creating your own Project

To create a new project called ``camel-api`` run the command:

```
oc new-project camel-api
```

## Install Camel K Operator

The Catalog Operator is responsible for building, deploying Camel Applications and also creating surrounding resources. It is also responsible for watching any code or configuration updates and automatically updates it. To install simply run the command.


```
kamel install
```

 you will see this prompt:

```
Camel K installed in namespace camel-api
```

To check if Camel K operator has successfully installed,
```
oc get pod -w
```

once camel-k-operator starts the Running status, it means it is successfully installed.
```
NAME                                READY   STATUS    RESTARTS   AGE
camel-k-operator-554df8d75c-d2dx5   1/1     Running   0          84s
```


## Setup the generic object datastore

Lets start Minio, it provide a S3 compatible protocol for storing the objects.
To create the minio backend, just apply the provided file:

```
oc apply -f minio/minio.yaml
```

Now you have a working generic object datastore.
