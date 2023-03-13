---
slug: step4
id: y8vkazhypisq
type: challenge
title: Creating the EtcdCluster Custom Resource (CR)
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 600
---
Ensure you are currently scoped to the `myproject` Namespace:

```
cd /root && \
  oc project myproject
```

Create an Etcd cluster by referring to the new Custom Resource, `EtcdCluster`, defined in the Custom Resource Definition on Step 1:

```
cat > etcd-operator-cr.yaml<<EOF
apiVersion: etcd.database.coreos.com/v1beta2
kind: EtcdCluster
metadata:
  name: example-etcd-cluster
spec:
  size: 3
  version: 3.1.10
EOF
```

```
oc create -f etcd-operator-cr.yaml
```

Patch the just created resource:

```
oc patch service example-etcd-cluster --type='json' -p '[{"op": "replace", "path": "/spec/publishNotReadyAddresses", "value":true}]'
```

Verify the cluster object was created:

```
oc get etcdclusters
```

Watch the pods in the Etcd cluster get created:

```
oc get pods -l etcd_cluster=example-etcd-cluster -w
```

Verify the cluster has been exposed via a ClusterIP service:

```
oc get services -l etcd_cluster=example-etcd-cluster
```
