---
slug: 05-seccomp
id: 5dcuhqieawyk
type: challenge
title: 'SECCOMP: Limiting how a containerized process can interact with the kernel'
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/labs
difficulty: expert
timelimit: 360
---
The goal of this exercise is to gain a basic understanding of SECCOMP. Think of a SECCOMP as a firewall which can be configured to block certain system calls.  While optional, and not configured by default, this can be a very powerful tool to block misbehaved containers. Take a look at this sample:

```
cat ~/labs/lab3-step5/chmod.json
```


Now, run a container with this profile and test if it works.

```
podman run -it --security-opt seccomp=/root/labs/lab3-step5/chmod.json registry.access.redhat.com/ubi7/ubi chmod 777 /etc/hosts
```

Notice how the chmod system call is blocked.
