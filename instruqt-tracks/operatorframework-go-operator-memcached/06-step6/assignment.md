---
slug: step6
id: 24uvbc8htl19
type: challenge
title: Controller Configurations
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
There are a number of other useful configurations that can be made when initialzing a controller. For more details on these configurations consult the upstream [builder](https://pkg.go.dev/sigs.k8s.io/controller-runtime/pkg/builder#example-Builder) and [controller](https://pkg.go.dev/sigs.k8s.io/controller-runtime/pkg/controller) godocs.

* Set the max number of concurrent Reconciles for the controller via the [MaxConcurrentReconciles](https://pkg.go.dev/sigs.k8s.io/controller-runtime/pkg/controller#Options) option. Defaults to 1.

```go
func (r *MemcachedReconciler) SetupWithManager(mgr ctrl.Manager) error {
  return ctrl.NewControllerManagedBy(mgr).
    For(&cachev1alpha1.Memcached{}).
    Owns(&appsv1.Deployment{}).
    WithOptions(controller.Options{MaxConcurrentReconciles: 2}).
    Complete(r)
}
```

* Filter watch events using [predicates](https://sdk.operatorframework.io/docs/building-operators/golang/references/event-filtering/)

* Choose the type of [EventHandler](https://pkg.go.dev/sigs.k8s.io/controller-runtime/pkg/handler#hdr-EventHandlers) to change how a watch event will translate to reconcile requests for the reconcile loop. For operator relationships that are more complex than primary and secondary resources, the [EnqueueRequestsFromMapFunc](https://pkg.go.dev/sigs.k8s.io/controller-runtime/pkg/handler#EnqueueRequestsFromMapFunc) handler can be used to transform a watch event into an arbitrary set of reconcile requests.
