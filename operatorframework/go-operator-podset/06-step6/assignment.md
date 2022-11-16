---
slug: step6
id: rmjs0f69wgdf
type: challenge
title: Deleting the PodSet Custom Resource
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Terminal 2
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-dzk9v-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 800
---
Our PodSet controller creates pods containing OwnerReferences in their `metadata` section. This ensures they will be removed upon deletion of the `podset-sample` CR.

Observe the OwnerReference set on a Podset's pod:

```
oc get pods -o yaml | grep ownerReferences -A10
```

Delete the podset-sample Custom Resource:

```
oc delete podset podset-sample
```

Thanks to OwnerReferences, all of the pods should be deleted:

```
oc get pods
```
