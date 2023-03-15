---
slug: 01-helm-integration
id: 57dyymuekbzf
type: challenge
title: Helm Integration
notes:
- type: text
  contents: |
    ## Goal

    This scenario will get you get familiar with how to use Argo CD to deploy
    Helm charts.


    ## Concepts

    [Helm](https://helm.sh/) is a package manager for Kubernetes
    applications. You can define, install, and update your pre-packaged
    applications. This is a way to bundle up, and deliver prebuilt Kubernetes
    applications.


    ![Helm Logo](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/helm-logo.png)

    [Argo CD](https://argoproj.github.io/argo-cd/) is a declarative, GitOps continuous delivery tool for Kubernetes.

    Using Argo CD, you can still use your Helm charts to deploy and manage your Applications.

    ## Use case

    This is a simple guide that takes you through the following steps:

    * Use the native Helm integration in Argo CD
    * Explore a more GitOps friendly approach to Helm chart deployments
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 900
---
Welcome! In this section we will be exploring the native Helm integration
within Argo CD.

## Background

Helm has become the defacto way of packaging up and deploying application
stacks on Kubernetes. You can think of Helm as sort of a package manager
for Kubernetes. The main components of Helm are:

* `Chart` a package consisting of related Kubernetes YAML files used to deploy something (Application/Application Stack/etc).
* `Repository` a place where Charts can be stored, shared and distributed.
* `Release` a specific instance of a Chart deployed on a Kubernetes cluster.

Helm works by the user providing parameters (most of the time via a YAML
file) against a Helm chart via the CLI. These parameters get injected
into the Helm template YAML to produce a consumable YAML that us deployed
to the Kubernetes cluster.

![helm-overview](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/helm-overview.png)

Argo CD has native support for Helm built in. You can directly
call a Helm chart repo and provide the values directly in the
[Application](https://argoproj.github.io/argo-cd/operator-manual/declarative-setup/#applications)
manifest. Furthermore, you can interact and manage the Helm release on
your cluster directly with Argo CD via the UI or the CLI.

In this scenario, we will explore how to deploy a Helm chart using the
native integration in Argo CD.

## Exploring Manifests

You can specify your Helm repo, chart, and values directly in the
`Application` manfiest for Argo CD. Let's take a look at the example
we're going to deploy. [quarkus-app.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/components/applications/quarkus-app.yaml)

This `Application` deploys a sample Quarkus application. If you take
a look at the file, you can see the specific configuration under
`.spec.source.helm`. Let's take a look at this section/snippet of
the YAML:

```yaml
spec:
  source:
    helm:
      parameters:
        - name: build.enabled
          value: "false"
        - name: deploy.route.tls.enabled
          value: "true"
        - name: image.name
          value: quay.io/ablock/gitops-helm-quarkus
    chart: quarkus
    repoURL: https://redhat-developer.github.io/redhat-helm-charts
    targetRevision: 0.0.3
```

Let's break this `.spec.source.helm` section down a bit:

* `parameters` - This section is where you'll enter the parameters you want to pass to the Helm chart. These are the same values that you'd have in your `Values.yaml` file.
* `chart` - This is the name of the chart you want to deploy from the Helm Repository.
* `repoURL` - This is the URL of the Helm Repository.
* `targetRevision` - This is the version of the chart you want to deploy.

This can be used to deploy the Helm chart on to your cluster, which is like using `helm install ...`.

> **NOTE** What actually happens is that Argo CD
> runs a `helm template ... | kubectl apply -f -`. We'll go over that
> a little later

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

Apply the Argo CD `Application` manifest to get this Helm chart deployed.

```
oc apply -f https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/components/applications/quarkus-app.yaml
```

This should create the `quarkus-app` application. Note the Helm icon
⎈ denoting it's a Helm application.

![quarkus-app](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/quarkus-app.png)

Clicking on this "card" will take you to the application overview
page. Clicking on "show hidden resources" should expand the "tree"
view.

![quarkus-app-tree](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/quarkus-app-tree.png)

Grab the URL by running the following command:

```
oc get route/quarkus-app -n demo  -o jsonpath='{.spec.host}{"\n"}'
```

If you visit that URL, you should see the following page.


![gitops-loves-helm](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/gitops-loves-helm.png)

You can now interact with this `Application` using the `argocd` CLI. For instance; if I want to change the scale of my application to 2 replicas, I just modify that value using the `argocd` CLI.

First, check to see how many pods you have running:

```
oc get pods -n demo
```

The output should look like this.

```shell
NAME                           READY   STATUS              RESTARTS   AGE
quarkus-app-58f475cb86-rddz2   1/1     Running             0          14m
```

Now, modfy the Helm values:

```
argocd app set quarkus-app -p deploy.replicas=2
```

You should now have 2 pods for this Application:

```
oc get pods -n demo
```

There will now be two pods.

```shell
NAME                           READY   STATUS              RESTARTS   AGE
quarkus-app-58f475cb86-rddz2   1/1     Running             0          15m
quarkus-app-58f475cb86-s9llq   0/1     ContainerCreating   0          1s
```

The Argo CD UI should show the application with 2 pods and fully healthy/in sync.

![quarkus-2-pods](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/quarkus-2-pods.png)

This is a valid, and completely supported way of deploying your Helm
charts using Argo CD. But this isn't GitOps friendly. Lets see how we
can use Helm in a GitOps workflow.

Keep the Argo CD WebUI tab open for the next exercise, where we'll
explore a more GitOps friendly way of deploying Helm charts.