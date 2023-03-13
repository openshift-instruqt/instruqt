---
slug: step1
id: d9s2gxxn9mc3
type: challenge
title: Creating the Custom Resource Definition (CRD)
notes:
- type: text
  contents: |
    The etcd operator manages etcd clusters deployed to Kubernetes and automates tasks related to operating an etcd cluster.

    - [Create and Destroy](https://github.com/coreos/etcd-operator#create-and-destroy-an-etcd-cluster)
    - [Resize](https://github.com/coreos/etcd-operator#resize-an-etcd-cluster)
    - [Failover](https://github.com/coreos/etcd-operator#failover)
    - [Rolling upgrade](https://github.com/coreos/etcd-operator#upgrade-an-etcd-cluster)
    - [Backup and Restore](https://github.com/coreos/etcd-operator#backup-and-restore-an-etcd-cluster)

    There are [more spec examples](https://github.com/coreos/etcd-operator/blob/master/doc/user/spec_examples.md) on setting up clusters with different configurations

    Read [Best Practices](https://github.com/coreos/etcd-operator/blob/master/doc/best_practices.md) for more information on how to better use etcd operator.

    Read [RBAC docs](https://github.com/coreos/etcd-operator/blob/master/doc/user/rbac.md) for how to setup RBAC rules for etcd operator if RBAC is in place.

    Read [Developer Guide](https://github.com/coreos/etcd-operator/blob/master/doc/dev/developer_guide.md) for setting up a development environment if you want to contribute.

    See the [Resources and Labels](https://github.com/coreos/etcd-operator/blob/master/doc/user/resource_labels.md) doc for an overview of the resources created by the etcd-operator.
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
Let's begin by creating a new project called `myproject`:

```
cd /root && \
oc new-project myproject
```

Create the Custom Resource Definition (CRD) for the Etcd Operator:

```
cat > etcd-operator-crd.yaml<<EOF
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: etcdclusters.etcd.database.coreos.com
spec:
  group: etcd.database.coreos.com
  names:
    kind: EtcdCluster
    listKind: EtcdClusterList
    plural: etcdclusters
    shortNames:
    - etcdclus
    - etcd
    singular: etcdcluster
  scope: Namespaced
  version: v1beta2
  versions:
  - name: v1beta2
    schema:
      openAPIV3Schema:
        type: object
        x-kubernetes-preserve-unknown-fields: true
    served: true
    storage: true
EOF
```

```
oc create -f etcd-operator-crd.yaml
```

Verify the CRD was successfully created.

```
oc get crd etcdclusters.etcd.database.coreos.com
```
