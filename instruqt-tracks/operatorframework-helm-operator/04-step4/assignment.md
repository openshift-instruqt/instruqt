---
slug: step4
id: rx4dx5ohrzwj
type: challenge
title: Apply the CockroachDB Custom Resource
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 200
---
From navigate to the `cockroachdb-operator` top-level directory:

```
cd projects/cockroachdb-operator
```

Before applying the CockroachDB Custom Resource, observe the CockroachDB Helm Chart `values.yaml`:

[CockroachDB Helm Chart Values.yaml file](https://github.com/helm/charts/blob/master/stable/cockroachdb/values.yaml)

Update the CockroachDB Custom Resource at `config/samples/charts_v1alpha1_cockroachdb.yaml` with the following values:

* `spec.statefulset.replicas: 1`
* `spec.storage.persistentVolume.size: 1Gi`
* `spec.storage.persistentVolume.storageClass: local-storage`

```yaml
apiVersion: charts.example.com/v1alpha1
kind: Cockroachdb
metadata:
  name: cockroachdb-sample
spec:
  statefulset:
    replicas: 1
  storage:
    persistentVolume:
      size: 1Gi
      storageClass: local-storage
```

You can easily update this file by running the following command:

```
\cp /tmp/charts_v1alpha1_cockroachdb.yaml config/samples/charts_v1alpha1_cockroachdb.yaml
```

After updating the CockroachDB Custom Resource with our desired spec, apply it to the cluster. Ensure you are currently scoped to the `myproject` Namespace:

```
oc project myproject
```


```
oc apply -f config/samples/charts_v1alpha1_cockroachdb.yaml
```

Confirm that the Custom Resource was created:

```
oc get cockroachdb
```

It may take some time for the environment to pull down the CockroachDB container image. Confirm that the Stateful Set was created:

```
oc get statefulset
```

Confirm that the Stateful Set's pod is currently running:

```
oc get pods -l app.kubernetes.io/component=cockroachdb
```

Confirm that the CockroachDB "internal" and "public" ClusterIP Service were created:

```
oc get services
```
