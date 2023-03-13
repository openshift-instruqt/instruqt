---
slug: step7
id: kvs8dfokc5zh
type: challenge
title: Disaster Recovery in Action
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 300
---
Delete a pod from the cluster and watch recovery in real-time.

```
export EXAMPLE_ETCD_CLUSTER_POD=$(oc get pods -l app=etcd -o jsonpath='{.items[0].metadata.name}')
oc delete pod $EXAMPLE_ETCD_CLUSTER_POD
```
