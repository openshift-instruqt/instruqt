---
slug: 01-engines-kernel
id: hoybx1fqlxyi
type: challenge
title: Container Engines & The Linux Kernel
notes:
- type: text
  contents: |
    ## Background
    This lab focuses on understanding how a particular host actually runs the container images - from the deep internals of how containerized processes interact with the Linux kernel, to the podman daemon and how it receives REST API calls and translates them into system calls to tell the Linux kernel to create new containerized processes.

    By the end of this lab you should be able to:
    - Understand the basic interactions of the major daemons and APIs in a typical container environment
    - Internalize the function of system calls and kernel namespaces
    - Understand how SELinux and sVirt secures containers
    - Command a conceptual understanding of how cgroups limit containers
    - Use SECCOMP to limit the system calls a container can make
    - Have a basic understanding of container storage and how it compares to normal Linux storage concepts
    - Gain a basic understanding of container networking and namespaces
    - Troubleshoot a basic Open vSwitch setup with Kubernetes/OpenShift

    ## Outline
    - Daemons & APIs: Docker, Kubernetes Master, Node, and their interaction with the Linux kernel
    - System Calls & Kernel Namespaces: How they work inside of a container
    - SELinux & sVirt: Dynamically generated contexts to protect your containers
    - Cgroups: Dynamically created with container instantiation
    - SECCOMP: Limiting how a containerized process can interact with the kernel
    - Storage: How containers get local, copy on write storage
    - Pod Networking: How individual containers and pods connect to the network
    - Cluster Networking: How clusters of hosts manage the connections of containerized processes

    ## Other Material
    These materials will give you a background to all of the concepts in this lab
    - [Presentation](https://goo.gl/UNnLkH)
    - [Lab GitHub Repository](https://github.com/openshift-instruqt/instruqt/tree/b18c330172f3b38042eb22ffca8b24ab32ab3490/instruqt-tracks/subsystems-container-internals-lab-2-0-part-4)

    ## Start Scenario
    Once you have gone through the presentation, continue to the exercises
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
If you just do a quick Google search, you will find tons of architectural drawings which depict things the wrong way or only tell part of the story. This leads the innocent viewer to come to the wrong conclusion about containers. One might suspect that even the makers of these drawings have the wrong conclusion about how containers work and hence propogate bad information. So, forget everything you think you know.

![Containers Are Linux](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/subsystems/container-internals-lab-2-0-part-4/01-google-wrong.png)

How do people get it wrong? In two main ways:

First, most of the architectural drawings above show the podman daemon as a wide blue box stretched out over the [Container Host](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/#h.8tyd9p17othl). The [Containers](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/#h.j2uq93kgxe0e) are shown as if they are running on top of the podman daemon. This is incorrect - [containers don't run on podman](https://crunchtools.com/so-what-does-a-container-engine-really-do-anyway/). The podman engine is an example of a general purpose [Container Engine](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/#h.6yt1ex5wfo3l). Humans talk to container engines and container engines talk to the kernel - the containers are actually created and run by the Linux kernel. Even when drawings do actually show the right architecture between the container engine and the kernel, they never show containers running side by side:


Second, when drawings show containers are Linux processes, they never show the container engine side by side. This leads people to never think about these two things together, hence users are left confused with only part of the story:

![Containers Are Linux](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/subsystems/container-internals-lab-2-0-part-4/01-not-the-whole-story.png)

For this lab, let’s start from scratch. In the terminal, let's start with a simple experiment - start three containers which will all run the top command:


```
podman run -td registry.access.redhat.com/ubi7/ubi top
```

```
podman run -td registry.access.redhat.com/ubi7/ubi top
```

```
podman run -td registry.access.redhat.com/ubi7/ubi top
```

Now, let's inspect the process table of the underlying host:

```
ps -efZ | grep -v grep | grep " top"
```

Notice that we started each of the ``top`` commands in containers. We started three with podman, but they are still just a regular process which can be viewed with the trusty old ``ps`` command. That's because containerized processes are just [fancy Linux processes](http://sdtimes.com/guest-view-containers-really-just-fancy-files-fancy-processes/) with extra isolation from normal Linux processes. A simplified drawing should really look something like this:

![Containers Are Linux](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/subsystems/container-internals-lab-2-0-part-4/01-single-node-toolchain.png)

In the kernel, there is no single data structure which represents what a container is. This has been debated back and forth for years - some people think there should be, others think there shouldn't. The current Linux kernel community philosophy is that the Linux kernel should provide a bunch of different technologies, ranging from experimental to very mature, enabling users to mix these technologies together in creative, new ways. And, that's exactly what a container engine (Docker, Podman, CRI-O, etc) does - it leverages kernel technologies to create, what we humans call, containers. The concept of a container is a user construct, not a kernel construct. This is a common pattern in Linux and Unix - this split between lower level (kernel) and higher level (userspace) technologies allows kernel developers to focus on enabling technologies, while users experiment with them and find out what works well.

![Containers Are Linux](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/subsystems/container-internals-lab-2-0-part-4/01-kernel-engine.png)

The Linux kernel only has a single major data structure that tracks processes - the process id table. The ``ps`` command dumps the contents of this data structure. But, this is not the total definition of a container - the container engine tracks which kernel isolation technologies are used, and even what data volumes are mounted. This information can be thought of as metadata which provides a definition for what we humans call a container. We will dig deeper into the technical underpinnings, but for now, understand that containerized processes are regular Linux processes which are isolated using kernel technologies like namespaces, selinux and cgroups. This is sometimes described as "sand boxing" or "isolation" or an "illusion" of virtualization.

In the end though, containerized processes are just regular Linux processes. All processes live side by side, whether they are regular Linux processes, long lived daemons, batch jobs, interactive commands which you run manually, or containerized processes. All of these processes make requests to the Linux kernel for protected resources like memory, RAM, TCP sockets, etc. We will explore this deeper in later labs, but for now, commit this to memory...
