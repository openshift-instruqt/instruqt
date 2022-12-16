---
slug: step1
id: f8juhskmpquw
type: challenge
title: Step 1
notes:
- type: text
  contents: |2

    This scenario will introduce [Camel K ](https://camel.apache.org/camel-k/latest/index.html).

    ## What is Camel K?


    ![Logo](https://www.nicolaferraro.me/images/post-logo-apache-camel-d.png)


    ### Your Integration Swiss-Army-Knife native on Kubernetes with Camel K

    Apache Camel K is a lightweight integration framework built from Apache Camel that runs natively on Kubernetes and is specifically designed for serverless and microservice architectures.

    Camel K supports multiple languages for writing integrations. Based the Operator Pattern, Camel K performs operations on Kubernetes resources. Bringing integration to the next level. utilizing the benefit of the Apache Camel project, such as the wide variety of components and Enterprise Integration Patterns (EIP).

    Camel K integrate seamlessly with Knative making it the best serverless technology for integration. This scenario will get you started and hands on Camel K.
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
timelimit: 225
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

To create a new project called ``camel-basic`` run the command:

```
oc new-project camel-basic
```

## Install Camel K Operator

```
oc apply -f /opt/operator-install.yaml -n camel-basic
```
