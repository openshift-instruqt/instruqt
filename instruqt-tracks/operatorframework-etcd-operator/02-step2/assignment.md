---
slug: step2
id: zcxgpe6gyrqx
type: challenge
title: Creating the Service Account, Role, and RoleBinding
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
Create a dedicated Service Account responsible for running the Etcd Operator:

```
cd /root && \
cat > etcd-operator-sa.yaml<<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: etcd-operator-sa
EOF
```

```
oc create -f etcd-operator-sa.yaml
```

Verify the Service Account was successfully created:

```
oc get sa
```

Create the Role that the `etcd-operator-sa` Service Account will need for authorization to perform actions against the Kubernetes API:

```
cat > etcd-operator-role.yaml<<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: etcd-operator-role
rules:
- apiGroups:
  - etcd.database.coreos.com
  resources:
  - etcdclusters
  - etcdbackups
  - etcdrestores
  verbs:
  - '*'
- apiGroups:
  - ""
  resources:
  - pods
  - services
  - endpoints
  - persistentvolumeclaims
  - events
  verbs:
  - '*'
- apiGroups:
  - apps
  resources:
  - deployments
  verbs:
  - '*'
- apiGroups:
  - ""
  resources:
  - secrets
  verbs:
  - get
EOF
```

```
oc create -f etcd-operator-role.yaml
```

Verify the Role was successfully created:

```
oc get roles
```

Create the RoleBinding to bind the `etcd-operator-role` Role to the `etcd-operator-sa` Service Account:

```
cat > etcd-operator-rolebinding.yaml<<EOF
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: etcd-operator-rolebinding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: etcd-operator-role
subjects:
- kind: ServiceAccount
  name: etcd-operator-sa
  namespace: myproject
EOF
```

```
oc create -f etcd-operator-rolebinding.yaml
```

Verify the RoleBinding was successfully created:

```
oc get rolebindings
```