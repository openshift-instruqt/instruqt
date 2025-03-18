---
slug: deploying-sample-application
id: gmdtqtlq8dhx
type: challenge
title: Deploying a Sample Application
tabs:
- id: fyp3zgj9ohyl
  title: Terminal 1
  type: terminal
  hostname: crc
- id: ou2fdkygp0fb
  title: Web Console
  type: website
  url: https://console-openshift-console.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- id: hvw7jjqtjcsy
  title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 800
enhanced_loading: null
---
In this environment, we have some
example manifesets taken from our [sample GitOps repo](https://github.com/redhat-developer-demos/openshift-gitops-examples).
We'll be uisng this repo to test. These manifests include:

* A **Namespace**: [bgd-ns.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/apps/bgd/overlays/bgd/bgd-ns.yaml)
* A **Deployment**: [bgd-deployment.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/apps/bgd/overlays/bgd/bgd-deployment.yaml)
* A **Service**: [bgd-svc.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/apps/bgd/overlays/bgd/bgd-svc.yaml)
* A **Route**: [bgd-route.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/apps/bgd/overlays/bgd/bgd-route.yaml)

Collectively, this is known as an `Application` within ArgoCD. Therefore,
you must define it as such in order to apply these manifest in your
cluster.

Open up the Argo CD `Application` manifest: [bgd-app.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/components/applications/bgd-app.yaml)

Let's break this down a bit.

* ArgoCD's concept of a `Project` is different than OpenShift's. Here you're installing the application in ArgoCD's `default` project (`.spec.project`). **NOT** OpenShift's `default` project.
* The destination server is the server we installed ArgoCD on (noted as `.spec.destination.server`).
* The manifest repo where the YAML resides and the path to look for the YAML is under `.spec.source`.
* The `.spec.syncPolicy` is set to `false`. Note that you can have Argo CD automatically sync the repo.
* The last section `.spec.sync` just says what are you comparing the repo to. (Basically "Compare the running config to the desired config")

The `Application` CR (`CustomResource`) can be applied by running the following:

```
oc apply -f https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/components/applications/bgd-app.yaml
```

This should create the `bgd-app` in the ArgoCD UI.

![bgdk-app](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/bgd-app.png)

Clicking on this "card" takes you to the overview page. You may see it as still progressing or full synced.

![synced-app](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/synced-app.png)

> **NOTE**: You may have to click on `show hidden resources` on this page to see it all

At this point the application should be up and running. You can see
all the resources created with the command:

```
oc get pods,svc,route -n bgd
```

The output should look like this:

```shell
NAME                       READY   STATUS    RESTARTS   AGE
pod/bgd-788cb756f7-kz448   1/1     Running   0          10m

NAME          TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/bgd   ClusterIP   172.30.111.118   <none>        8080/TCP   10m

NAME                           HOST/PORT                                PATH   SERVICES   PORT   TERMINATION   WILDCARD
route.route.openshift.io/bgd   bgd-bgd.apps.example.com          bgd        8080                 None
```

First wait for the rollout to complete

```
oc rollout status deploy/bgd -n bgd
```

Then visit your application using the route by navigating to the URL under the "HOST/PORT" column

```
oc get route -n bgd
```

Your application should look like this.

![bgd](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/bgd.png)

Let's introduce a change! Patch the live manifest to change the color
of the box from blue to green:

```
oc -n bgd patch deploy/bgd --type='json' -p='[{"op": "replace", "path": "/spec/template/spec/containers/0/env/0/value", "value":"green"}]'
```

Wait for the rollout to happen:

```
oc rollout status deploy/bgd -n bgd
```

If you refresh your tab where your application is running you should see a green square now.

![bgd-green](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/bgd-green.png)

Looking over at your Argo CD Web UI, you can see that Argo detects your
application as "Out of Sync".

![outofsync](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/out-of-sync.png)

You can sync your app via the Argo CD by:

* First clicking `SYNC`
* Then clicking `SYNCHRONIZE`

Conversely, you can run

```
argocd app sync bgd-app
```

After the sync process is done, the Argo CD UI should mark the application as in sync.

![fullysynced](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/fullysynced.png)

If you reload the page on the tab where the application is running. It
should have returned to a blue square.

![bgd](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/bgd.png)

You can setup Argo CD to automatically correct drift by setting the
`Application` manifest to do so. Here is an example snippet:

```yaml
spec:
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

Or, as in our case, after the fact by running the following command:

```
oc patch application/bgd-app -n openshift-gitops --type=merge -p='{"spec":{"syncPolicy":{"automated":{"prune":true,"selfHeal":true}}}}'
```

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
