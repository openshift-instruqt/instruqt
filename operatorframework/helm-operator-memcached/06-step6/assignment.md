---
slug: step6
id: txcyl8f0ro8j
type: challenge
title: Test Memcached Cluster Failover
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
If any Memcached member fails it gets restarted or recreated automatically by the Kubernetes infrastructure, and will rejoin the cluster automatically when it comes back up. You can test this scenario by killing any of the pods:

```
oc delete pods -l app.kubernetes.io/name=memcached
```

Watch the pods respawn:

```
oc get pods -l app.kubernetes.io/name=memcached
```
