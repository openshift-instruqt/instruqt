---
slug: exploring-openshift-operator
id: l7813dczdeik
type: challenge
title: Exploring the OpenShift GitOps Operator
notes:
- type: text
  contents: |
    ## Goal

    This guide helps you get started with ArgoCD and GitOps with OpenShift.


    ## Concepts

    [GitOps](https://www.openshift.com/learn/topics/gitops/) is a set of practices that leverages Git workflows to manage infrastructure and application configurations.
    By using Git repositories as the source of truth, it allows the DevOps team to store the entire state of the cluster configuration in Git so that the trail of changes are visible and auditable.

    **GitOps** simplifies the propagation of infrastructure and application
    configuration changes across multiple clusters by defining your infrastructure and applications definitions as “code”.

    * Ensure that the clusters have similar states for configuration, monitoring, or storage.
    * Recover or recreate clusters from a known state.
    * Create clusters with a known state.
    * Apply or revert configuration changes to multiple clusters.
    * Associate templated configuration with different environments.


    ![ArgoCD Logo](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/argocd-logo.png)

    [Argo CD](https://argoproj.github.io/argo-cd/) is a declarative, GitOps continuous delivery tool for Kubernetes.

    It follows the GitOps pattern of using Git repositories as the source of truth for defining the desired application state.

    It automates the deployment of the desired application states in the specified target environments. Application deployments can track updates to branches, tags, or pinned to a specific version of manifests at a Git commit.


    ## Use case

    This is a simple guide that takes you through the following steps:

    * Exploring the OpenShift GitOps Operator
    * Accessing Argo CD via CLI and Web UI
    * Deploying A Sample Application
tabs:
- id: rd4wtiznh2yi
  title: Terminal 1
  type: terminal
  hostname: crc
- id: 72yfrkdw01oj
  title: Web Console
  type: website
  url: https://console-openshift-console.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- id: dkxyw7toxby9
  title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 800
---
Welcome! In this section we will be exploring the OpenShift GitOps
Operator, what it installs, and how all the components fit together.

## Logging in to OpenShift

At first, Click the **Web Console** from the row of horizontal tabs at the top of the interactive terminal window. (The **Web Console** tab is the second tab to the right.)

You will then be able to login with admin permissions with:

* **Username:** ``admin``
* **Password:** ``admin``

## Exploring the GitOps Operator Installation

From the Administrator perspective, go to the *OperatorHub* and search for "Red Hat OpenShift GitOps" operator.

![OpenShift GitOps Operator Installation](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/openshift-gitops-operator-installation.png)

Install the OpenShift GitOps Operator with the default settings provided.

Once installed:

* Click on `Operators` drop down on the leftside navigation.
* Click on `Installed Operators`
* In the `Project` dropdown, make sure `openshift-gitops` is selected.

You should see that the OpenShift GitOps Operator is installed.

![OpenShift GitOps Installed](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/os-gitops-installed.png)

Another way to view what was installed is to run the following:

```
oc get operators
```

This should have the following output.

```shell
NAME                                                  AGE
openshift-gitops-operator.openshift-operators         25m
```

Finally, you can verify the installation by running

```
oc get pods -n openshift-gitops
```

You should something similar to the following output.

```shell
NAME                                                          READY   STATUS    RESTARTS   AGE
cluster-b5798d6f9-p9mt5                                       1/1     Running   0          12m
kam-69866d7c48-hr92f                                          1/1     Running   0          12m
openshift-gitops-application-controller-0                     1/1     Running   0          12m
openshift-gitops-applicationset-controller-6447b8dfdd-2xqw2   1/1     Running   0          12m
openshift-gitops-redis-74bd8d7d96-72fmd                       1/1     Running   0          12m
openshift-gitops-repo-server-c999f75d5-7jfc8                  1/1     Running   0          12m
openshift-gitops-server-6ff4fbc8f6-fpfdp                      1/1     Running   0          7m47s
```

Once you see the all the pods running, you can proceed!
