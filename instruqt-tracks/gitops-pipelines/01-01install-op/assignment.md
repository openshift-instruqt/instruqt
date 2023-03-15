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
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 257
---
OpenShift Pipelines are an OpenShift add-on that can be installed via an operator that is available in the OpenShift OperatorHub.

You can either install the operator using the OpenShift Pipelines Operator in the web console or by using the CLI tool `oc`. Let's log in to our cluster to make changes and install the operator.

At first, check that the pod responsible for OpenShift Web Console to be ready:

```
oc get pods -n openshift-console | grep console
```

You might have to wait a minute for the pod to be ready.

When the pod is ready, execute the following command to find the route to the OpenShift Web Console:

```
oc get routes console -n openshift-console
```

Copy the link under `HOST/PORT` column and navigate there from a web browser.

You will then be able to login with admin permissions with:

* **Username:** ``admin``
* **Password:** ``admin``

![Web Console Login](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/web-console-login.png)

## Installing the OpenShift Pipelines Operator in Web Console

You can install OpenShift Pipelines using the Operator listed in the OpenShift Container Platform OperatorHub. When you install the OpenShift Pipelines Operator, the Custom Resources (CRs) required for the Pipelines configuration are automatically installed along with the Operator.

In the _Administrator_ perspective of the web console, navigate to Operators → OperatorHub. You can see the list of available operators for OpenShift provided by Red Hat as well as a community of partners and open-source projects.

Use the _Filter by keyword_ box to search for `Red Hat OpenShift Pipelines` in the catalog. Click the _Red Hat OpenShift Pipelines_ tile.

![Web Console Hub](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/web-console-hub.png)

Read the brief description of the Operator on the _Red Hat OpenShift Pipelines_ page. Click _Install_.

Select _All namespaces on the cluster (default)_ for installation mode & _Automatic_ for the approval strategy. Click Subscribe!

![Web Console Login](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/web-console-settings.png)

Be sure to verify that the OpenShift Pipelines Operator has installed through the Operators → Installed Operators page.

## Installing the OpenShift Pipelines Operator using the CLI

You can install OpenShift Pipelines Operator from the OperatorHub using the CLI.

First, you'll want to create a Subscription object YAML file to subscribe a namespace to the OpenShift Pipelines Operator, for example, `subscription.yaml` as shown below:

```
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: openshift-pipelines-operator
  namespace: openshift-operators
spec:
  channel: stable
  name: openshift-pipelines-operator-rh
  source: redhat-operators
  sourceNamespace: openshift-marketplace
```

This YAML file defines various components, such as the `channel` specifying the channel name where we want to subscribe, `name` being the name of our Operator, and `source` being the CatalogSource that provides the operator.

Create and save this file under `opt/operator` local folder as `subscription.yaml`.

You can now create the Subscription object similar to any OpenShift object.

```
oc apply -f /opt/operator/subscription.yaml
```

## Verify installation

The OpenShift Pipelines Operator provides all its resources under a single API group: tekton.dev. This operation can take a few seconds; you can run the following script to monitor the progress of the installation.

```
until oc api-resources --api-group=tekton.dev | grep tekton.dev &> /dev/null
do
 echo "Operator installation in progress..."
 sleep 5
done

echo "Operator ready"
```

Great! The OpenShift Pipelines Operator is now installed. Now, let's start the workshop.
