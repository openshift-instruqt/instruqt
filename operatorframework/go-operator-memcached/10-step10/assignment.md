---
slug: step10
id: admwwuly6cil
type: challenge
title: Running the Operator Locally (Outside the Cluster)
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Terminal 2
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root/projects/memcached-operator
difficulty: basic
timelimit: 300
---
Once the CRD is registered, there are two ways to run the Operator:

* As a Pod inside a Kubernetes cluster
* As a Go program outside the cluster using Operator-SDK. This is great for local development of your Operator.

For the sake of this tutorial, we will run the Operator as a Go program outside the cluster using Operator-SDK and our `kubeconfig` credentials

```
cd /root/projects/memcached-operator && \
  WATCH_NAMESPACE=myproject make run
```

From **Terminal 2**, inspect the Custom Resource manifest:

```
cd $HOME/projects/memcached-operator
cat config/samples/cache_v1alpha1_memcached.yaml
```

Ensure your `kind: Memcached` Custom Resource (CR) is updated with `spec.size`

```yaml
apiVersion: cache.example.com/v1alpha1
kind: Memcached
metadata:
  name: memcached-sample
spec:
  size: 3
```

You can easily update this file by running the following command:

```
\cp /tmp/cache_v1alpha1_memcached.yaml config/samples/cache_v1alpha1_memcached.yaml
```

Ensure you are currently scoped to the `myproject` Namespace:

```
oc project myproject
```

Deploy your PodSet Custom Resource to the live OpenShift Cluster:

```
oc create -f config/samples/cache_v1alpha1_memcached.yaml
```

Verify the memcached exists:

```
oc get memcached
```

Verify the Memcached operator has created 3 pods:

```
oc get pods
```

Verify that status shows the name of the pods currently owned by the Memcached:

```
oc get memcached memcached-sample -o yaml
```

Increase the number of replicas owned by the Memcached:

```
oc patch memcached memcached-sample --type='json' -p '[{"op": "replace", "path": "/spec/size", "value":5}]'
```


Verify that we now have 5 running pods
```
oc get pods
```