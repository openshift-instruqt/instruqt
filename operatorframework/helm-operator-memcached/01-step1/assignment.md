---
slug: step1
id: hhtpowzpwyt4
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

    ## Creating a Memcached Operator from a Helm Chart

    In this tutorial, we will create a Memcached Operator from an existing [Memcached Helm Chart](https://github.com/helm/charts/blob/master/stable/memcached/Chart.yaml).

    [Memcached](https://memcached.org/) is a Free & open source, high-performance, distributed memory object caching system, generic in nature, but intended for use in speeding up dynamic web applications by alleviating database load.

    Let's begin!
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 257
---

Let's begin by connecting to OpenShift:

```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

Let's begin my creating a new project called `myproject`:

```
oc new-project myproject
```

Memcached is an in-memory key-value store for small chunks of arbitrary data (strings, objects) from results of database calls, API calls, or page rendering.


Let's now create a new directory for our project:

```
mkdir -p $HOME/projects/memcached-operator
```

Navigate to the directory:

```
cd $HOME/projects/memcached-operator
```

Create a new Helm-based Operator SDK project for the Memcached Operator:

```
operator-sdk init --plugins helm --domain example.com
```

For Helm-based projects, `operator-sdk` init also generates the RBAC rules in `config/rbac/role.yaml` based on the resources that would be deployed by the chart’s default manifest. Be sure to double check that the rules generated in `config/rbac/role.yaml` meet the operator’s permission requirements.

To learn more about the project directory structure, see the [project layout](https://sdk.operatorframework.io/docs/overview/project-layout) doc.

** Use an existing chart **

Instead of creating your project with a boilerplate Helm chart, you can also use `--helm-chart`, `--helm-chart-repo`, and `--helm-chart-version` to use an existing chart, either from your local filesystem or a remote chart repository.

Automatically fetch the Memcached Helm Chart and generate the CRD/API:

```
operator-sdk create api --helm-chart memcached --helm-chart-repo=https://charts.helm.sh/stable
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
