---
slug: step6
id: ujwnpiy5yoxe
type: challenge
title: Scaling and Modifying the Etcd Version
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 600
---
Let's change the size of the Etcd `example-etcd-cluster` CR. The Etcd Operator pod will detect the CR `spec.size` change and modify the number of pods in the cluster:

```
oc patch etcdcluster example-etcd-cluster --type='json' -p '[{"op": "replace", "path": "/spec/size", "value":5}]'
```


Let's change the version of our `example-etcd-cluster` CR. The etcd-operator pod will detect the CR `spec.version` change and create a new cluster with the newly specified image:

```
oc patch etcdcluster example-etcd-cluster --type='json' -p '[{"op": "replace", "path": "/spec/version", "value":3.2.13}]'
```
