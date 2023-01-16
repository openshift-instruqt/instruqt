---
slug: step3
id: fy1mpur5hcns
type: challenge
title: Apply the CockroachDB Custom Resource Definition
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
Apply the CockroachDB Custom Resource Definition to the cluster:

```
oc apply -f config/crd/bases/charts.example.com_cockroachdbs.yaml
```

Once the CRD is registered, there are two ways to run the Operator:

* As a Pod inside a Kubernetes cluster
* As a Go program outside the cluster using Operator-SDK. This is great for local development of your Operator.

For the sake of this tutorial, we will run the Operator as a Go program outside the cluster using Operator-SDK and our `kubeconfig` credentials

Once running, the command will block the current session. You can continue interacting with the OpenShift cluster by using another terminal tab. You can quit the session by pressing `CTRL + C`.

```
WATCH_NAMESPACE=myproject make run
```
