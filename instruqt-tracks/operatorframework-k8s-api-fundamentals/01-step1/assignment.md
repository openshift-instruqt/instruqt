---
slug: step1
id: xcryhgketlfn
type: challenge
title: Kubernetes Manifests
notes:
- type: text
  contents: Before diving into the [Operator Framework](https://github.com/operator-framework),
    this section will give an overview of Kubernetes API fundamentals.  Although the
    [Operator SDK](https://github.com/operator-framework/operator-sdk) makes creating
    an Operator fun and easy, understanding the structure and features of the Kubernetes
    API is required.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 500
---
Let's begin by creating a new project called `myproject`:

```
oc new-project myproject
```

Create a new pod manifest that specifies two containers:

```
cd /root && \
cat > pod-multi-container.yaml <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: my-two-container-pod
  namespace: myproject
  labels:
    environment: dev
spec:
  containers:
    - name: server
      image: nginx:1.13-alpine
      ports:
        - containerPort: 80
          protocol: TCP
    - name: side-car
      image: alpine:latest
      command: ["/usr/bin/tail", "-f", "/dev/null"]
  restartPolicy: Never
EOF
```

Create the pod by specifying the manifest:

```
oc create -f pod-multi-container.yaml
```

View the detail for the pod and look at the events:

```
oc describe pod my-two-container-pod
```

Let's first execute a shell session inside the server container by using the
`-c` flag:

```
oc exec -it my-two-container-pod -c server -- /bin/sh
```

Run some commands inside the server container:

```
ip address
netstat -ntlp
hostname
ps
exit
```

Let's now execute a shell session inside the side-car container:

```
oc exec -it my-two-container-pod -c side-car -- /bin/sh
```

Run the same commands in side-car container. Each container within a pod runs
it's own cgroup, but shares IPC, Network, and UTC (hostname) namespaces:

```
ip address
netstat -ntlp
hostname
exit
```