---
slug: step8
id: zn5pwami5dog
type: challenge
title: 'Return options for a Reconciler:'
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
The following are a few possible return options for a Reconciler:

* With the error:
```go
return ctrl.Result{}, err
```
* Without an error:
```go
return ctrl.Result{Requeue: true}, nil
```
* Therefore, to stop the Reconcile, use:
```go
return ctrl.Result{}, nil
```
* Reconcile again after X time:
```go
 return ctrl.Result{RequeueAfter: nextRun.Sub(r.Now())}, nil
```
For more details, check the Reconcile and its [Reconcile godoc](https://pkg.go.dev/sigs.k8s.io/controller-runtime/pkg/reconcile).

