---
slug: step8
id: ain1vmrvjr6s
type: challenge
title: Clean Up
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
Delete your Etcd cluster:

```
oc delete etcdcluster example-etcd-cluster
```

Delete the Etcd Operator:

```
oc delete deployment etcd-operator
```

Delete the Etcd CRD:

```
oc delete crd etcdclusters.etcd.database.coreos.com
```

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
