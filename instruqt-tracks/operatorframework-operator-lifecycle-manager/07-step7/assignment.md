---
slug: step7
id: ukckatyi7fbn
type: challenge
title: Accessing the ArgoCD Dashboard
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 225
---
Let's access the ArgoCD Dashboard via an OpenShift Route:

```
ARGOCD_ROUTE=`oc get routes example-argocd-server -o jsonpath={$.spec.host}`
echo $ARGOCD_ROUTE
```


Select **Login via OpenShift** to use OpenShift as our identity provider.

For more information on getting started with ArgoCD on OpenShift 4, check out [this video](https://www.youtube.com/watch?v=xYCX2EejSMc).