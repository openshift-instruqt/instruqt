---
slug: step5
id: wpyybjvkb6fs
type: challenge
title: Resources watched by the Controller
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
**Note:** The next two subsections explain how the controller watches resources and how the reconcile loop is triggered. If you’d like to skip this section, head to the deploy section to see how to run the operator.

```
cd $HOME/projects/memcached-operator && \
  cat controllers/memcached_controller.go
```

The `SetupWithManager()` function in `controllers/memcached_controller.go` specifies how the controller is built to watch a CR and other resources that are owned and managed by that controller.

```go
import (
  ...
  appsv1 "k8s.io/api/apps/v1"
  ...
)

func (r *MemcachedReconciler) SetupWithManager(mgr ctrl.Manager) error {
  return ctrl.NewControllerManagedBy(mgr).
    For(&cachev1alpha1.Memcached{}).
    Owns(&appsv1.Deployment{}).
    Complete(r)
}
```

The `NewControllerManagedBy()` provides a controller builder that allows various controller configurations.

`For(&cachev1alpha1.Memcached{})` specifies the Memcached type as the primary resource to watch. For each Memcached type Add/Update/Delete event the reconcile loop will be sent a reconcile `Request` (a namespace/name key) for that Memcached object.

`Owns(&appsv1.Deployment{})` specifies the Deployments type as the secondary resource to watch. For each Deployment type Add/Update/Delete event, the event handler will map each event to a reconcile Request for the owner of the Deployment. Which in this case is the Memcached object for which the Deployment was created.
