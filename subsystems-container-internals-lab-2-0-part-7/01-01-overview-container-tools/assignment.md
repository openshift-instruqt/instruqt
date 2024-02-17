---
slug: 01-overview-container-tools
id: g5dgkjdlk4js
type: challenge
title: An Overview of Container Tools
notes:
- type: text
  contents: |
    ## Background
    This lab will help give you a basic understanding of how to use some other OCI compliant tools such as Podman, Buildah, and Skopeo.

    By the end of this lab you should be able to:
    - FIND, RUN, BUILD, and SHARE containers using OCI compliant tools
    - Solve real technical problems by using a small set of daemonless tools
    - Be comfortable using with the basics of an alternative set of tools to Docker

    ## Outline
    - Understanding the difference between RHEL Server and CoreOS, as well as the difference between the fast and stable streams provided in RHEL Server
    - Understanding how to install the fast and stable streams
    - Podman: Familiar Territory: Learning the basics of how to use podman
    - Buildah: Granularity & Control: Understanding how a container image is really built
    - Skopeo: Moving & Sharing: Simplicity in inspecting, and moving container images around
    - CRIU: Checkpoint and restore the memory contents of containers
    - Udica: Build and deploy custom SELinux policies for containers
    - OSCAP-Podman: verify patched or unpatched vulnerabilities in container images produced by Red Hat

    ## Other Material
    - [Presentation](https://goo.gl/h4VK7j)
    - [Lab GitHub Repository](https://github.com/openshift-instruqt/instruqt/tree/3ccc0f45269f895a19406e833392dc9fbc7948d8/instruqt-tracks/subsystems-container-internals-lab-2-0-part-7)

    ## Start Scenario
    Once you have gone through the presentation, continue to the exercises
tabs:
- title: Terminal 1
  type: terminal
  hostname: rhel
- title: Visual Editor
  type: code
  hostname: rhel
  path: /root
difficulty: intermediate
timelimit: 500
---
In this lab we're going to cover a plethora of container tools available in Red Hat Enterprise Linux (RHEL), including Podman, Buildah, Skopeo, CRIU and Udica. Before we get into the specific tools, it's important to understand how these are tools are provided to the end user in the Red Hat ecosystem.

The RHEL kernel, systemd, and the container tools, centered around github.com/containers and github.com/cri-o/cri-o, serve as the foundation for both RHEL Server as well as RHEL CoreOS. RHEL Server is a flexible, general purpose operating system which can be customized for many different use cases. On the other hand, RHEL CoreOS is a minimal, purpose built operating system intended to be consumed within automated environments like OpenShift. This lab will specifically cover the tools available in RHEL Server, but much of what you learn is useful with CoreOS which is built from the same bits, but packaged specifically for OpenShift and Edge use cases.

Here's a quick overview of how to think about RHEL Server versus RHEL CoreOS:

1. General Purpose: User -> Podman -> RHEL Server
2. OpenShift: User -> Kubernetes API -> Kubelet -> CRI-O -> RHEL CoreOS

In a RHEL Server environment, the end user will create containers directly on the container host with Podman. In an OpenShift environment, the end user will create containers through the Kubernetes API - users generally do not interact directly with CRI-O on individual hosts in the cluster. Stated another way, Podman is the primary container interface in RHEL, while Kubernetes is the primary interface in OpenShift.

For the rest of this lab, we will focus on the container tools provided in RHEL Server. The launch of RHEL8 introduced the concept of [Application Streams](https://www.redhat.com/en/blog/introduction-appstreams-and-modules-red-hat-enterprise-linux), which provide users with access to the latest versions of software like Python, Ruby, and Podman. These Application Streams have different, and often shorter life cycles than RHEL (10+ years). Specifically, RHEL8 Server provides users with two types of Application Streams for Container tools:

1. Fast: Rolling stream which is updated with new versions of Podman and other tools up to every 12 weeks, and only supported until the next version is released. This stream is for users looking for the latest features in Podman.
2. Stable: Traditional streams released once per year, and supported for 24 months. Once released these streams do not update versions of Podman and other tools, and only provide security fixes. This stream is for users looking to put Podman into production depending on stability.

With either stream, the underlying RHEL kernel, systemd, and other packages are treated as a rolling stream. The only choice is is whether to use the fast stream or one of the stable streams. Since RHEL provides a very stable [ABI/API Policy](https://access.redhat.com/articles/rhel8-abi-compatibility) the vast majority of container users will not notice and should not be concerned with kernel, systemd, glibc, etc updates on the container host. If the users selects one of the stable streams, the API to Podman will remains stable and updated for security.

For a deeper dive, check out [RHEL 8 enables containers with the tools of software craftsmanship](https://www.redhat.com/en/blog/rhel-8-enables-containers-tools-software-craftsmanship-0). Now, let's move on to installing and using these different streams of software.
