---
slug: 01install-op
id: emxtfxxh93ig
type: challenge
title: Step 1 - Install the Pipelines Operator
notes:
- type: text
  contents: |-
    In this self-paced tutorial, you will learn how to use OpenShift Pipelines to automate the deployment of your applications.

    In this tutorial, you will:
    * Install the OpenShift Pipelines Operator
    * Create a Hello World `Task`
    * Install task resource definitions
    * Create a Tekton `Pipeline`
    * Trigger the created pipeline to finish your application deployment.

    ## Getting started

    OpenShift Pipelines is a cloud-native, continuous integration and delivery (CI/CD)
    solution for building pipelines using [Tekton](https://tekton.dev). Tekton is
    a flexible, Kubernetes-native, open-source CI/CD framework that enables automating
    deployments across multiple platforms (e.g. Kubernetes, serverless, VMs, and so forth) by
    abstracting away the underlying details.

    OpenShift Pipelines features:

    * Standard CI/CD pipeline definition based on Tekton
    * Build container images with tools such as [Source-to-Image (S2I)](https://docs.openshift.com/container-platform/latest/builds/understanding-image-builds.html#build-strategy-s2i_understanding-image-builds) and [Buildah](https://buildah.io/)
    * Deploy applications to multiple platforms such as Kubernetes, serverless, and VMs
    * Easy to extend and integrate with existing tools
    * Scale pipelines on-demand
    * Portable across any Kubernetes platform
    * Designed for microservices and decentralized teams
    * Integrated with the OpenShift Developer Console

    ## Tekton CRDs

    Tekton defines some [Kubernetes custom resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/)
    as building blocks to standardize pipeline concepts and provide terminology that is consistent across CI/CD solutions. These custom resources are an extension of the Kubernetes API that lets users create and interact with these objects using the OpenShift CLI (`oc`), `kubectl`, and other Kubernetes tools.

    The custom resources needed to define a pipeline are listed below:

    * `Task`: a reusable, loosely coupled number of steps that perform a specific task (e.g. building a container image)
    * `Pipeline`: the definition of the pipeline and the `Tasks` that it should perform
    * `TaskRun`: the execution and result of running an instance of a task
    * `PipelineRun`: the execution and result of running an instance of a pipeline, which includes a number of `TaskRuns`

    For further details on pipeline concepts, refer to the [Tekton documentation](https://github.com/tektoncd/pipeline/tree/master/docs#learn-more) that provides an excellent guide for understanding various parameters and attributes available for defining pipelines.

    In the following sections, you will go through each of the above steps to define and invoke a pipeline. Let's get started!
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-rwwzd-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 500
---
[OpenShift Pipelines](https://docs.openshift.com/container-platform/latest/cicd/pipelines/understanding-openshift-pipelines.html) are an OpenShift add-on that can be installed via an operator that is available in the OpenShift OperatorHub. It allows for cloud-native, continuous integration and delivery (CI/CD) solution for building pipelines using [Tekton](https://tekton.dev/).

🔒 Logging in with the CLI
=======================

Log into OpenShift from the command line on the left using the `oc login` command:

```
oc login -u admin -p admin
```

✅ Login Confirmation
==================

Verify you succesfully logged in as the `admin` user with the `oc whoami` command:

```
oc whoami
```

🔒 Logging in with the web console and install the OpenShift Pipelines Operator
===============================


Now, let's install the operator using the OpenShift Pipelines Operator in the OpenShift Web Console!

Click the **Web Console** tab over the terminal area to open the OpenShift web console in a new tab.

![Web Console Login](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/web-console-login.png)

|NOTE:|
|----|
|You might see the following warning notification due to using an untrusted security certificate.
![Security warning](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/instruqt-tracks/developing-on-openshift-getting-started/assets/security_warning.png)
If you do get the warning, click the **Advanced** button to complete the process necessary to grant permission to the browser to access the OpenShift Web Console.|



Use the following credentials to log in:

* **Username:** `admin`
* **Password:** `admin`

## Installing the OpenShift Pipelines Operator in Web Console

You can install OpenShift Pipelines using the Operator listed in the OpenShift Container Platform OperatorHub. When you install the OpenShift Pipelines Operator, the Custom Resources (CRs) required for the Pipelines configuration are automatically installed along with the Operator.

In the _Administrator_ perspective of the web console, navigate to Operators → OperatorHub. You can see the list of available operators for OpenShift provided by Red Hat as well as a community of partners and open-source projects.

Use the _Filter by keyword_ box to search for `Red Hat OpenShift Pipelines` in the catalog. Click the _Red Hat OpenShift Pipelines_ tile.

![Web Console Hub](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/web-console-hub-new.png)

Read the brief description of the Operator on the _Red Hat OpenShift Pipelines_ page. Click _Install_.

Select _pipelines-1.11_ for the Update channel, _All namespaces on the cluster (default)_ for installation mode, & _Automatic_ for the approval strategy. Click Install!

![Web Console Login](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/web-console-settings.png)

The installation may take a minute, but once complete, you'll now have installed the *OpenShift Pipelines Operator* to your OpenShift Cluster!

![Operator Installed](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/operator-installed.png)

Now, let's start the workshop. In the next section, we'll create the project that we'll be using for the workshop.
