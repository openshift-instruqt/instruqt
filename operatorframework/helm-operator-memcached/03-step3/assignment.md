---
slug: step3
id: josxkksaivv6
type: challenge
title: Apply the Memcached Custom Resource Definition
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
Apply the Memcached Custom Resource Definition to the cluster:

```
cd /root/projects/memcached-operator && \
  oc apply -f config/crd/bases/charts.example.com_memcacheds.yaml
```

Once the CRD is registered, there are two ways to run the Operator:

* As a Pod inside a Kubernetes cluster
* As a Go program outside the cluster using Operator-SDK. This is great for local development of your Operator.

For the sake of this tutorial, we will run the Operator as a Go program outside the cluster using Operator-SDK and our `kubeconfig` credentials


```
WATCH_NAMESPACE=myproject make run & disown
```
