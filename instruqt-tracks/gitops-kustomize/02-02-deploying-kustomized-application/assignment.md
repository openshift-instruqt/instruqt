---
slug: 02-deploying-kustomized-application
id: vzyjqxuohjyl
type: challenge
title: Deploying Kustomized Applicaton
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
In previous scenarios, you learned that in a GitOps workflow; the
entire application stack (including infrastructure) is reflected
in a git repo. The challenge is how to do this without duplicating
YAML.

So now that you've explored `kustomize`, let's see how it fits into Argo
CD and how it can be used in a GitOps workflow.

Before preceeding, move into the project root directory:

```
cd /opt/openshift-gitops-examples/
```
At this point, you should be on `openshift-gitops-examples` directory.

## In this section we will be exploring the OpenShift GitOps
Operator, what it installs, and how all the components fit together.

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

## Exploring the GitOps Operator Installation

From the Administrator perspective, go to the *OperatorHub* and search for "OpenShift GitOps" operator.

![OpenShift GitOps Operator Installation](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/Install%20OpenShift%20GitOps%20Operator.png)

This is a cluster-wide operator and install the operator with the default settings provided. Once installed:

* Click on `Operators` drop down on the leftside navigation.
* Click on `Installed Operators`
* In the `Project` dropdown, make sure `openshift-gitops` is selected.

You should see that the OpenShift GitOps Operator is installed.

![OpenShift GitOps Installed](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/os-gitops-installed.png)


## The Argo CD Web Console

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

## Base Application

In a previous scenario, we deployed a sample appication that had a
picture of a blue square. To deploy the application, run the following
command:

```
oc apply -f components/applications/bgd-app.yaml
```

This should create an `Application` in the Argo CD UI.

![bgdk-app](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/bgdk-app.png)

You can wait for the rollout of the application by running

```
oc rollout status deploy/bgd -n bgd
```

Once it's done rolling out, you can open the application's URL by [CLICKING HERE](http://bgd-bgd.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com)

It should look something like this.

![bgd](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/bgd.png)

If you did the previous scenario, this should be familiar. But what
if I wanted to deploy this application with modifications?

## Kustomized Application

Argo CD has native support for Kustomize. You can use this to avoid
duplicating YAML for each deployment. This is especially good to
use if you have different environements or clusters you're deploying
to.

Take a look at the `Application` definition:  [bgdk-app.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/components/applications/bgdk-app.yaml)

This application is pointed to the [same repo](https://github.com/redhat-developer-demos/openshift-gitops-examples) but [different directory](https://github.com/redhat-developer-demos/openshift-gitops-examples/tree/main/apps/bgd/overlays/bgdk).

This is using a concept of an "overlay", where you have a "base"
set of manifests and you overlay your customizations. Take a look
at the [apps/bgd/overlays/bgdk/kustomization.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/apps/bgd/overlays/bgdk/kustomization.yaml) example
file.

This `kustomization.yaml` takes the base application and patches the
manifest so that we get a yellow square instead of a blue one. It
also deploys the application to the `bgdk` namespace (denoted by
the `namespace:` section of the file).

Deploy this application:

```
oc apply -f components/applications/bgdk-app.yaml
```

This should show you two apps on the Argo CD UI.

![two-apps](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/two-apps.png)

Open the applicaiton's route by [CLICKING HERE](http://bgd-bgdk.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com)

![yellow-square](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/yellow-square.png)

As you can see, the application deployed with your customizations! To review what we just did.

* Deployed an Application called `bgd` with a blue square.
* Deployed another Application based on `bgd` called `bgdk`
* The Application `bgdk` was deployed in it's own namespace, with deployment customizations.
* ALL without having to duplicate YAML!

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
