---
slug: step7
id: bve6ooyc7v9x
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
difficulty: basic
timelimit: 257
---
Delete the Memcached cluster and all associated resources by deleting the `example` Custom Resource:

```
oc delete memcached memcached-sample
```

Verify that the Stateful Set, pods, and services are removed:

```
oc get statefulset
oc get pods
oc get services
```