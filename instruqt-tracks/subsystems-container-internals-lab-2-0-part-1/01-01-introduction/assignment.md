---
slug: 01-introduction
id: nvrx0x4gjxqf
type: challenge
title: Introduction to Containers
notes:
- type: text
  contents: |
    ## Background
    In this self-paced tutorial, you will gain a basic understanding of the moving parts that make up the typical container architecture.  This will cover container images, registries, hosts, and orchestration.

    By the end of this lab you should be able to:
    - Draw a diagram showing how the Linux kernel, services and daemons work together to create and deploy containers
    - Internalize how the architecture of the kernel and supporting services affect security and performance
    - Explain the API interactions of daemons and the host kernel to create isolated processes
    - Understand the basics of why people move on to container orchestration
    - Command the nomenclature necessary to technically discuss the basics of the single and multi-host toolchain

    ## Outline
    - Container Images: made up of underlying operating system components like libraries and programming languages
    - Container Registries: Fancy file servers that help users share container images
    - Container Hosts: Includes Podman (or Docker) runtime, Systemd, runc, and Libcontainer
    - Container Orchestration: Includes Kubernetes/OpenShift

    ## Other Material
    - [Presentation](http://bit.ly/2V18QCg)
    - [Lab GitHub Repository](https://github.com/openshift-instruqt/instruqt/tree/874d2aa4decef440b36a79de881a39df12211c7c/instruqt-tracks/subsystems-container-internals-lab-2-0-part-1)

    ## Start Scenario
    Once you have watched the background video or went through the presentation, continue to the exercises
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
If you understand Linux, you probably already have 85% of the knowledge you need to understand containers. If you understand how processes, mounts, networks , shells and daemons work - commands like ps, mount, ip addr, bash, httpd and mysqld - then you just need to understand a few extra primitives to become an expert with containers. Remember that all of the things that you already know today still apply: from security and performance to storage and networking, containers are just a different way of packaging and delivering Linux applications. There are four basic primitives to learn to get you from Linux administrator to feeling comfortable with containers:

* [Container Images](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/#h.dqlu6589ootw)
* [Container Registries](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/#h.4cxnedx7tmvq)
* [Container Hosts](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/#h.8tyd9p17othl)
* [Container Orchestration](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/#h.6yt1ex5wfo66)

Once, you understand the basic four primitives, there are some advanced concepts that will be covered in future labs including:

* Container Standards: Understanding OCI, CRI, CNI, and more
* Container Tools Ecosystem - Podman, Buildah, Skopeo, cloud registries, etc
* Production Image Builds: Sharing and collaborating between technical specialists (performance, network, security, databases, etc)
* Intermediate Architecture: Production environments
* Advanced Architecture: Building in resilience
* Container History: Context for where we are at today

Covering all of this material is beyond the scope of any live training, but we will cover the basics, and students can move on to other labs not covered in the classroom. These labs are available online at http://learn.openshift.com/subsystems.

Now, let's start with the introductory lab, which covers these four basic primitives:

![New Primitives](../assets/01-new-primitives.png)
