---
slug: 01-using-syncwaves
id: jv1yo6nlycw0
type: challenge
title: Using Syncwaves
notes:
- type: text
  contents: |
    ## Goal

    This scenario will get you get familiar with syncwaves and hook phases.


    ## Concepts

    [Syncwaves](https://argoproj.github.io/argo-cd/user-guide/sync-waves/)
    are used in Argo CD to order how manifests
    are applied to the cluster. Whereas [resource hooks](https://argoproj.github.io/argo-cd/user-guide/resource_hooks/)
    breaks up the delivery of these manifests in different phases.

    ![ArgoCD Logo](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/argocd-logo.png)

    [Argo CD](https://argoproj.github.io/argo-cd/) is a declarative, GitOps continuous delivery tool for Kubernetes.

    Using a combination of syncwaves and resource hooks, you can control how your application rolls out.

    ## Use case

    This is a simple guide that takes you through the following steps:

    * Using Syncwaves to order deployment
    * Exploring Resource Hooks
    * Using Syncwaves and Hooks together

    This OpenShift cluster will self-destruct in one hour.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 800
---
Welcome! In this section we will be exploring how to use syncwaves with
Argo CD.

## Background

A Syncwave is a way to order how Argo CD applies the manifests that are
stored in git. All manifests have a wave of zero by default, but you can
set these by using the `argocd.argoproj.io/sync-wave` annotation. Example:

```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "2"
```

The wave can also be negative as well.

```yaml
metadata:
  annotations:
    argocd.argoproj.io/sync-wave: "-5"
```

When Argo CD starts a sync action, the manifest get placed in the following order:

* The Phase that they're in (we'll cover phases in the next section)
* The wave the resource is annotated in (starting from the lowest value to the highest)
* By kind (Namspaces first, then services, then deployments, etc ...)
* By name (ascending order)

Read more about syncwaves on the [official documentation site](https://argoproj.github.io/argo-cd/user-guide/sync-waves/#how-do-i-configure-waves)

## Logging in to the Cluster via Dashboard

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

## Installing OpenShift GitOps operator

OpenShift GitOps operator includes Argo CD and provides an Argo CD instance out-of-the-box.

From the Administrator perspective, go to the *OperatorHub* and search for "OpenShift GitOps" operator.

![OpenShift GitOps Operator Installation](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/Install%20OpenShift%20GitOps%20Operator.png)

This is a cluster-wide operator and install the operator with the default settings provided. Once installed:

* Click on `Operators` drop down on the leftside navigation.
* Click on `Installed Operators`
* In the `Project` dropdown, make sure `openshift-gitops` is selected.

You should see that the OpenShift GitOps Operator is installed.

![OpenShift GitOps Installed](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/os-gitops-installed.png)

## Exploring Manifests

The manifests that will be deployed have been annotated with the following values:

* The Namspace with `0` [welcome-php-ns.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/apps/welcome-php/overlays/syncwaves/welcome-php-ns.yaml)
* The Deployment with `1` [welcome-php-deployment.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/apps/welcome-php/base/welcome-php-deployment.yaml)
* The Service with `2` [welcome-php-svc.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/apps/welcome-php/base/welcome-php-svc.yaml)
* Finally the Route with `3` [welcome-php-route.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/apps/welcome-php/base/welcome-php-route.yaml)

Argo CD will apply the Namespace first (since it's the lowest value),
and make sure it returns a "healthy" status before moving on.

Next, the Deployment will be applied. After that reports healthy, Argo
CD will apply the Service then the Route.

> **NOTE** Argo CD won't apply the next manifest until the previous reports "healthy".

## Deploying The Application

Before we deploy this application, make sure you've opened the Argo CD
Web Console.

Let's find the URL for the ArgoCD API Server:

```
oc get routes -n openshift-gitops | grep openshift-gitops-server | awk '{print $2}'
```
Find the default password for the `admin` account as follows:

```
oc extract secret/openshift-gitops-cluster -n openshift-gitops --to=-
```

To login from the terminal, execute the following (replace $ARGOCD_SERVER_URL with the above URL):

```
argocd login $ARGOCD_SERVER_URL
```

You'll have to accept the self-signed certificate.


You can login with the following:
* **Username:** ``admin``
* **Password:** <from previous command>

You can also find this URL by clicking the shortcut from the Application Launcher tab from the OpenShift Web Console:

![ArgoCD UI Shortcut](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/argocd-shortcut.png)

Once you have accepted the self signed certificate, you should be
presented with the Argo CD login screen.

![ArgoCD Login](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/argocd-login.png)

You can use the same credentials to login from the UI.

> **NOTE** The Password is stored in a secret on the platform.

Apply the Argo CD `Application` manifest to get this application deployed.

```
oc apply -f https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/components/applications/welcome-syncwaves.yaml
```

This should create the `welcome-syncwaves` application.

![welcome-syncwaves](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/welcome-syncwaves.png)

Clicking on this "card" will take you to the application overview
page. Clicking on "show hidden resources" should expand the "tree"
view.

![welcome-syncwaves-tree](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/welcome-syncwaves-tree.png)

If you follow along, you'll note that these manfiests get applied in
order of their annotated syncwave!

Keep the Argo CD WebUI tab open for the next exercise.
