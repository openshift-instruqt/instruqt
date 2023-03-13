---
slug: step5
id: jakpxnovlnui
type: challenge
title: Interacting with a Live Etcd Cluster
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
Let's now create another pod and attempt to connect to the etcd cluster via `etcdctl`:

```
oc run etcdclient --image=busybox busybox --restart=Never -- /usr/bin/tail -f /dev/null
```

Access the pod:

```
oc rsh etcdclient
```


Install the Etcd Client:

```
wget https://github.com/coreos/etcd/releases/download/v3.1.4/etcd-v3.1.4-linux-amd64.tar.gz
tar -xvf etcd-v3.1.4-linux-amd64.tar.gz
cp etcd-v3.1.4-linux-amd64/etcdctl .
```

Set the etcd version and endpoint variables:

```
export ETCDCTL_API=3
export ETCDCTL_ENDPOINTS=example-etcd-cluster-client:2379
```

Attempt to write a key/value into the Etcd cluster:

```
./etcdctl put operator sdk
./etcdctl get operator
```

Exit out of the client pod:

```
exit
```
