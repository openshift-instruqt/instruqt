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

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
