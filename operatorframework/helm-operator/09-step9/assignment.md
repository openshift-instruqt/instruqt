---
slug: step9
id: gggy0ujzyp3d
type: challenge
title: Clean Up
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
  url: https://console-openshift-console.crc-dzk9v-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 200
---
Delete the CockroachDB cluster and all associated resources by deleting the `example` Custom Resource:

```
oc delete cockroachdb cockroachdb-sample
```

Verify that the Stateful Set, pods, and services are removed:

```
oc get statefulset
oc get pods
oc get services
```