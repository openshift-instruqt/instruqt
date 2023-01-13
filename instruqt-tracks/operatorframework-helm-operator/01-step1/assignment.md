---
slug: step1
id: 5hpifojphhpf
type: challenge
title: Initialize the Project
notes:
- type: text
  contents: |-
    In the previous learning modules, we covered how to easily create the following types of Operators with the Operator SDK:

    * **Go**:
    Ideal for traditional software development teams that want to get to a fully auto-pilot Operator. It gives you the ability to leverage the same Kubernetes libraries the upstream projects uses under the hood. Check out the [Go Getting Started guide](https://sdk.operatorframework.io/docs/building-operators/golang/).

    * **Ansible**:
    Useful for infrastructure-focused teams that have investment in Ansible modules but want to use them in a Kubernetes-native way. Also great for using Ansible to configure off-cluster objects like hardware load balancers. Check out the [Ansible Getting Started guide](https://sdk.operatorframework.io/docs/building-operators/ansible/).

    We will now focus on the easiest way to get started developing an Operator:

    * **Helm**:
    It doesn’t rely on manual invocation of Helm to reconfigure your apps. Check out the [Helm Operator Getting Started guide](https://sdk.operatorframework.io/docs/building-operators/helm/) for more information.

    ## Creating a CockroachDB Operator from a Helm Chart

    In this tutorial, we will create a CockroachDB Operator from an existing [CockroachDB Helm Chart](https://github.com/helm/charts/tree/master/stable/cockroachdb).

    [CockroachDB](https://www.cockroachlabs.com) is a distributed SQL database built on a transactional and strongly-consistent key-value store. It can:

    * Scale horizontally.
    * Survive disk, machine, rack, and even datacenter failures with minimal latency disruption and no manual intervention.
    * Supports strongly-consistent ACID transactions and provides a familiar SQL API for structuring, manipulating, and querying data.

    Let's begin!
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 200
---
Let's begin by connecting to OpenShift:

```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

Create a new project called `myproject`:

```
oc new-project myproject
```

Let's now create a new directory for our project:

```
mkdir -p $HOME/projects/cockroachdb-operator
```

Navigate to the directory:

```
cd $HOME/projects/cockroachdb-operator
```

Create a new Helm-based Operator SDK project for the CockroachDB Operator:

```
operator-sdk init --plugins=helm --domain example.com
```

Automatically fetch the Cockroachdb Helm Chart and generate the CRD/API:

```
operator-sdk create api --helm-chart=cockroachdb --helm-chart-repo=https://charts.helm.sh/stable --helm-chart-version=3.0.7
```

### Project Scaffolding Layout

After creating a new operator project the directory has numerous generated folders and files. The following
table describes a basic rundown of each generated file/directory.

| File/Folders   | Purpose                           |
| :---           | :--- |
| config | Kustomize YAML definitions required to launch our controller on a cluster. It is the target directory to hold our CustomResourceDefinitions, RBAC configuration, and WebhookConfigurations.
| Dockerfile | The container build file used to build your Ansible Operator container image. |
| helm-charts | The location for the specified helm-charts. |
| Makefile | Make targets for building and deploying your controller. |
| PROJECT | Kubebuilder metadata for scaffolding new components. |
| watches.yaml | Contains Group, Version, Kind, and desired chart. |
