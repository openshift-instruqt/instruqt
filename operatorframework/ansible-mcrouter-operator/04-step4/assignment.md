---
slug: step4
id: tsne6ybtj79s
type: challenge
title: Testing Modification of the Mcrouter Custom Resource
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
One simple way to verify Mcrouter Operator functionality is by changing the `memcached_pool_size` in the Mcrouter Custom Resource. Run the folllowing command to bump the pool size to `3` and then observe what happens in the cluster:

```
oc patch mcrouter mcrouter  --type='json' -p '[{"op": "replace", "path": "/spec/memcached_pool_size", "value":3}]'
```

After a few seconds, a new Memcached Pod should be added to the pool:

```
oc get pods -l app=mcrouter-cache
```

You should now see the additional Memcached instances reflected in Mcrouter's configuration string.

```
oc describe pod -l app=mcrouter | grep Command -A2
```