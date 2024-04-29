---
slug: step1
id: jnyxgknwdtqh
type: challenge
title: Step 1 - Installing the Camel K Operator
notes:
- type: text
  contents: |2

    This scenario will introduce [Camel K ](https://camel.apache.org/camel-k/latest/index.html).

    ## What is Camel K?

    ![Logo](../assets/images/logo-camel.png)

    ### Your Integration Swiss-Army-Knife native on Kubernetes with Camel K

    Apache Camel K is a lightweight integration framework built from Apache Camel that runs natively on Kubernetes and is specifically designed for serverless and microservice architectures.

    Camel K supports multiple languages for writing integrations. Based on the Operator Pattern, Camel K performs operations on Kubernetes resources, bringing integration to the next level and utilizing the benefit of the Apache Camel project, such as the wide variety of components and Enterprise Integration Patterns (EIP).

    Camel K integrate seamlessly with Knative making it the best serverless technology for integration. This scenario will get you started and hands on Camel K.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 375
---
In order to run Camel K, you will need access to an Kubernetes/OpenShift environment. Let's setup the fundamentals.

## Logging in to the Cluster via Dashboard

Click the Web Console tab to open the dashboard.

You will then able able to login with admin permissions with:

* **Username:** ```admin```
* **Password:** ```admin```

For now there are no Camel K deployments, but later in the lab, the Web Console will allow you to visualise what's happening in the Cluster.

<br>

## Logging in to the Cluster via CLI

Before creating any applications from the command line, login as admin. To login to the OpenShift cluster from the _Terminal_ run:

```
oc login -u admin -p admin
```

This will log you in using the same credentials used to log into the web console.


## Creating your own Project

To create a new project called `camel-basic` run the command:

```
oc new-project camel-basic
```

## Install the Camel K Operator

```
oc apply -f /opt/operator-install.yaml -n camel-basic
```

Click *Next* to continue with step 2.
