---
slug: 01-cli
id: hugpc1zngt29
type: challenge
title: Explore Helm CLI
notes:
- type: text
  contents: |+
    ## Goal

    Learn how to use the [Helm](https://helm.sh/), a package manager that helps you managing and deploying applications on OpenShift.

    ![Logo](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/developing-on-openshift/helm/logo.png)

    [Helm](https://www.openshift.com/learn/topics/helm) is a package manager for Kubernetes which helps users create templated packages called Helm Charts to include all Kubernetes resources that are required to deploy a particular application.  Helm then assists with installing the Helm Chart on Kubernetes, and afterwards it can upgrade or rollback the installed package when new versions are available.

    ## Concepts

    * Helm core concepts
    * Exploring `helm` command line tool
    * Deploying and managing `Helm Charts`
    * Creating your own `Chart`
    * Managing applications lifecycle with Helm `Upgrade` and `Rollback` of releases.
    * Helm integrations with OpenShift UI

    ## Use case

    Be able to provide a great experience for both Developers and System Administrators to manage and deploy applications using Helm Charts on top of OpenShift.

    Helm Charts are particularly useful for installation and upgrade of stateless applications given that the Kubernetes resources and the application image can simply be updated to newer versions. The follow-up for this Day 1 experience, is to convert Helm Charts into an Operator, using [Operator Framework](https://github.com/operator-framework) for a complete Day 2 experience for your apps.

    Let's get started!

tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 900
---
At the end of this chapter you will be able to:
- Use `helm` CLI
- Install `helm repository`
- Search, install and uninstall `Helm Charts`
- Review Helm Charts from `OpenShift Console`

## Helm Command Line Interface (CLI)

In this scenario you will find the Helm CLI already installed for you, which can be  also retrieved from OpenShift Console, top right corner, click on ? -> Command Line Tools.

The CLI is the entry point for any interaction with Helm 3 subsystem. In addition to that, OpenShift Developer Catalog, which is the central hub for all developer content, has support for Helm Charts in addition to Operator-backed services, Templates, etc.

When a user instructs the Helm CLI to install a Helm Chart, the information about the Helm Chart is fetched from the repository, rendered on the client and then applied to Kubernetes while a record of this installation is created within the namespace (which is known as a Release).

![Helm on OpenShift](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/developing-on-openshift/helm/helm-diagram.png)


## Logging in to the Cluster

To login to the OpenShift cluster from the Terminal run:

```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

This will log you in using the credentials:

* **Username:** ``admin``
* **Password:** ``admin``

Let's also log in to our web console. This can be done by clicking the **Web Console** tab near the top of your screen.

You will then be able to login with admin permissions with:
* **Username:** ``admin``
* **Password:** ``admin``
![Web Console Login](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/web-console-login.png)

Let's create a new OpenShift Project to have a namespace for our helm charts to work with.

```
oc new-project helm
```

## Exercise: Explore CLI
Let's get started by using `helm` getting CLI version :

```
helm version
```

This should confirm we are using **Helm 3**.

As discussed in the previous step, Helm Charts are available through repositories, and those can be pre-installed or installable by the user.

You can search for Helm Charts available in any public repositories through [Helm Hub](https://hub.helm.sh/).

For instance, searching Helm Charts for [NGINX](https://nginx.com):

```
helm search hub nginx
```

This will give a list of available charts from multiple repositories. If we want to install it, we need to have such repositories configured.

By default the list of available repositories is empty. You can add a new one with the CLI. For NGINX, add Bitnami repository:

```
helm repo add bitnami https://charts.bitnami.com/bitnami
```

Once added, verify it is present:

```
helm repo list
```

You can search for Helm Charts also inside repos, like in the one you just installed:

```
helm search repo bitnami/nginx
```

## Deploy a Helm Chart

You can use `helm install` command to deploy your charts and start managing revisions.

To install [NGINX Chart](https://hub.helm.sh/charts/bitnami/nginx):

```
helm install my-nginx bitnami/nginx --set service.type=ClusterIP
```

This will install `nginx`, and for this example, we want to use `ClusterIP` Service type because we want to expose it afterwards through an OpenShift `Route`.

Check your Helm releases:

```
helm ls
```

Verify all the pods are in Running state and Ready:

```
oc get pods
```

Now expose `my-nginx` service to access it via OpenShift `Route`:

```
oc expose svc/my-nginx
```

Verify that route has been created:

```
oc get routes
```

You can click on the generated host to access the NGINX Pod provided by your just installed Helm Chart, or you can do it from OpenShift Console.

## Verify the deployment from OpenShift Console

To verify the creation of the resources generated by the Helm Chart, you can head out to the OpenShift web console.

Make sure the Developer perspective from the dropdown in the top left corner of the web console is selected as shown below:

<img src="https://katacoda.com/embed/openshift/courses/assets/middleware/pipelines/developer-view.png" width="800" />

Next, select the Project dropdown menu shown below and choose `helm` project you have been working with.

Next, click on the Topology tab on the left side of the web console if you don't see what's in the image below. Once in the Topology view, you can see the Deployment for `my-nginx` application and you can access it by clicking on the URL generated by the OpenShift Route:

<img src="https://katacoda.com/embed/openshift/courses/assets/developing-on-openshift/helm/nginx-helm-chart-route.png" width="800" />

You'll notice the HR label and Helm icon below, this means that this application is managed by Helm, and you can overview Helm `Releases` for this app from left side menu, Helm section:

<img src="https://katacoda.com/embed/openshift/courses/assets/developing-on-openshift/helm/nginx-helm-releases.png" width="800" />

Explore all `Resources` that are associated with a particular Helm `Release`, click on `my-nginx` Helm Release and then click on `Resouces` tab:

<img src="https://katacoda.com/embed/openshift/courses/assets/developing-on-openshift/helm/nginx-helm-resources-view.png" width="800" />

# Uninstall and clean

Come back to Terminal clicking on Terminal tab.

Uninstall `my-nginx` release:

```
helm uninstall my-nginx
```

Delete previously created `route`:

```
oc delete route my-nginx
```

