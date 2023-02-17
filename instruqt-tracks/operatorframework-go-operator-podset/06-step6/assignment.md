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
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
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

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
