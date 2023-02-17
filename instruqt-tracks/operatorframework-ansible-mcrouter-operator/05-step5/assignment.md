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

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
