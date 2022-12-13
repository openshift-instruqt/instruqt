---
slug: step7
id: z38atfrzao2w
type: challenge
title: Reconcile loop
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
The reconcile function is responsible for enforcing the desired CR state on the actual state of the system. It runs each time an event occurs on a watched CR or resource, and will return some value depending on whether those states match or not.

In this way, every Controller has a Reconciler object with a Reconcile() method that implements the reconcile loop. The reconcile loop is passed the [Request](https://pkg.go.dev/sigs.k8s.io/controller-runtime/pkg/reconcile#Request) argument which is a Namespace/Name key used to lookup the primary resource object, Memcached, from the cache:

```go
import (
  ctrl "sigs.k8s.io/controller-runtime"

  cachev1alpha1 "github.com/example/memcached-operator/api/v1alpha1"
  ...
)

func (r *MemcachedReconciler) Reconcile(ctx context.Context, req ctrl.Request) (ctrl.Result, error) {
  _ = context.Background()
  ...

  // Lookup the Memcached instance for this reconcile request
  memcached := &cachev1alpha1.Memcached{}
  err := r.Get(ctx, req.NamespacedName, memcached)
  ...
}
```

For a guide on Reconcilers, Clients, and interacting with resource Events, see the [Client API doc](https://sdk.operatorframework.io/docs/building-operators/golang/references/client/).
