---
slug: step4
id: mvlwrvbrisvj
type: challenge
title: Deployments/Finalizers
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Terminal 2
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 500
---
Create a manifest for a Deployment with a Finalizer:

```
cd /root && \
cat > finalizer-test.yaml<<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: finalizer-test
  namespace: myproject
  labels:
    app: finalizer-test
  finalizers:
    - finalizer.extensions/v1beta1
spec:
  selector:
    matchLabels:
      app: finalizer-test
  replicas: 3
  template:
    metadata:
      labels:
        app: finalizer-test
    spec:
      containers:
        - name: hieveryone
          image: openshiftkatacoda/blog-django-py
          imagePullPolicy: Always
          ports:
            - name: helloworldport
              containerPort: 8080
EOF
```

Create the Deployment.

```
oc create -f finalizer-test.yaml
```

Verify the Deployment has been created.

```
oc get deploy
```

Verify the ReplicaSet has been created:

```
oc get replicaset
```

Verify the pods are running:

```
oc get pods
```

Attempt to delete the Deployment.

```
oc delete deployment finalizer-test
```




From *Terminal 2*, observe the Deployment still exits and has been updated with the `deletionGracePeriodSeconds` and `deletionTimestamp` fields.

```
cd /root && \
  oc get deployment finalizer-test -o yaml | grep 'deletionGracePeriodSeconds\|deletionTimestamp'
```

Attempt to scale the Deployment up and down. Although status is updated, pods will not be created/deleted:

```
oc scale deploy finalizer-test --replicas=5
oc scale deploy finalizer-test --replicas=1
```


```
oc get deploy
oc get pods
```


Update the Deployment with the Finalizer value unset.

```
cat > finalizer-test-remove.yaml<<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: finalizer-test
  namespace: myproject
  labels:
    app: finalizer-test
  finalizers:
spec:
  selector:
    matchLabels:
      app: finalizer-test
  replicas: 3
  template:
    metadata:
      labels:
        app: finalizer-test
    spec:
      containers:
        - name: hieveryone
          image: openshiftkatacoda/blog-django-py
          imagePullPolicy: Always
          ports:
            - name: helloworldport
              containerPort: 8080
EOF
```

Replace the Deployment.

```
oc replace -f finalizer-test-remove.yaml
```

The Deployment will now be deleted.

```
oc get deploy
oc get pods
```

See the following:

[Deployment Controller (DeletionTimestamp != nil)](https://github.com/kubernetes/kubernetes/blob/release-1.18/pkg/controller/deployment/deployment_controller.go#L613-L615)

[SyncStatusOnly Method](https://github.com/kubernetes/kubernetes/blob/release-1.18/pkg/controller/deployment/sync.go#L36-L45)
