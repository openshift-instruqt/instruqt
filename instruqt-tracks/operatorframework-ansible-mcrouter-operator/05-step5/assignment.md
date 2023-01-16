---
slug: step5
id: sf1a6pwrxmcc
type: challenge
title: Testing Mcrouter failover
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 360
---
Thanks to the embedded StatefulSet controller our Memcached pool will handle creation of a new Pod in the event of failure.

Fetch one of Mcrouter's Memcached Pods from the pool:

```
MCROUTER_CACHE_0=`oc get pods -l app=mcrouter-cache -o jsonpath={$.items[0].metadata.name}`
echo $MCROUTER_CACHE_0
```


Delete the Pod:

```
oc delete pod $MCROUTER_CACHE_0
```

The Pod should respawn:

```
oc get pods -l app=mcrouter-cache
```
