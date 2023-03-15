---
slug: step8
id: irmilc9t9nny
type: challenge
title: Uninstalling the Operator
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
You can easily uninstall your operator by first removing the ArgoCD Custom Resource:

```
oc delete argocd example-argocd
```


Removing the ArgoCD Custom Resource, should remove all of the Operator's Operands:

```
oc get deployments
```


And then uninstalling the Operator:

```
oc delete -f argocd-subscription.yaml
ARGOCD_CSV=`oc get csv -o jsonpath={$.items[0].metadata.name}`
oc delete csv $ARGOCD_CSV
```



Once the Subscription and ClusterServiceVersion have been removed, the Operator and associated artifacts will be removed from the cluster:

```
oc get pods
oc get roles
```

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!