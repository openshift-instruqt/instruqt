---
slug: step5
id: qv58lovycvja
type: challenge
title: Update the Memcached Custom Resource
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
Let's now update the Memcached `example` Custom Resource and increase the desired number of replicas to `5`:

```
oc patch memcached memcached-sample -p '{"spec":{"replicaCount": 5}}' --type=merge
```

Verify that the Memcached Stateful Set is creating two additional pods:

```
oc get pods
```
