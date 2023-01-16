---
slug: step7
id: 2evc0ea3kkir
type: challenge
title: Create the Custom Resource Definition
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root/tutorial/memcached-operator
difficulty: basic
timelimit: 225
---
Before running the Operator, Kubernetes needs to know about the new custom
resource definition the Operator will be watching.

### Deploy the Memcached Custom Resource Definition (CRD):

```
cd /root/tutorial/memcached-operator && \
  oc create -f config/crd/bases/cache.example.com_memcacheds.yaml
```

By running this command, we are creating a new resource type, `memcached`, on the cluster. __We will give our Operator work to do by creating and modifying resources of this type.__

## Ways to Run an Operator

Once the CRD is registered, there are two ways to run the Operator:

* As a Pod inside a Kubernetes cluster
* As a Go program outside the cluster using Operator-SDK. This is great for local development of your Operator.

For the sake of this tutorial, we will run the Operator as a Go program outside the cluster using Operator-SDK.