---
slug: connecting-to-argocd
id: flg5wffrvkeo
type: challenge
title: Connecting to ArgoCD
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 800
---
Now that you've verified that Argo CD is up and running, let's explore
how to access and manage Argo CD.

## Connecting to the Argo CD Server

Part of the setup of this lab connects you to the Argo CD instance via
CLI and UI. Let's find the URL for the ArgoCD API Server:

```
oc get routes -n openshift-gitops | grep openshift-gitops-server | awk '{print $2}'
```

Now, let's store this as an enviroment variable so we can use it later to login to ArgoCD through our terminal.

```
export ARGOCD_SERVER_URL=$(oc get routes -n openshift-gitops | grep openshift-gitops-server | awk '{print $2}')
```

Next, find the default password for the `admin` account as follows:

```
oc extract secret/openshift-gitops-cluster -n openshift-gitops --to=-
```

To login from the terminal, execute the following, using the $ARGOCD_SERVER_URL we just saved:

```
argocd login $ARGOCD_SERVER_URL
```

You'll have to accept the self-signed certificate.


You can login with the following:
* **Username:** ``admin``
* **Password:** ``default password from previous command``

## The Argo CD Web Console

You can also find this URL by clicking the shortcut from the Application Launcher tab from the OpenShift Web Console:

![ArgoCD UI Shortcut](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/argocd-shortcut.png)

Once you have accepted the self signed certificate, you should be
presented with the Argo CD login screen.

![ArgoCD Login](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/argocd-login.png)

You can use the same credentials to login from the UI.

> **NOTE** The Password is stored in a secret on the platform.

Once you've logged in, you should see the following page.

![ArgoCD](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/argocd.png)

This is the Argo CD Web UI. Keep this tab open for the next exercise.

## ArgoCD Configuration

Let's come back to the terminal. Verify that you're connected to the Argo CD API server
by running the following:

```
argocd cluster list
```

You should see output similar to this:

```shell
SERVER                          NAME        VERSION  STATUS   MESSAGE
https://kubernetes.default.svc  in-cluster           Unknown  Cluster has no application and not being monitored.
```

This output lists the clusters that Argo CD manages. In this case
`in-cluster` in the `NAME` field signifies that Argo CD is managing the
cluster it's installed on.

> **NOTE** You can connect multiple clusters for Argo CD to manage!

To enable bash completion, run the following command:

```
source <(argocd completion bash)
```

The Argo CD CLI stores it's configuration under `~/.argocd/config`

> **NOTE** The `argocd cluster add` command used the `~/.kube/config` file to establish connection to the cluster.

```
ls ~/.argocd/config
```

The `argocd` CLI tool is useful for debugging and viewing status of your apps deployed.
