---
slug: exploring-ubi-minimal-container-image
id: 4q8oh4hhiqmd
type: challenge
title: Exploring the UBI minimal container image
teaser: Explore the UBI minimal container image
notes:
- type: text
  contents: |-
    ****Exploring the UBI minimal container image****

    In this section, we will be exploring a Red Hat UBI minimal container image and its differences from the Red Hat UBI base image.
tabs:
- title: ubi-minimal
  type: terminal
  hostname: user
difficulty: basic
timelimit: 300
---
The ubi container image contains some tools that you might not need for your application container image, such as the vim text editor. Just switch to the ubi9/ubi-minimal container image if you think you don't need those extra commands. Having these extra tools may be helpful during development of your container images, however.

Fire up a new minimal container image using the following command:

```bash
podman run --name ubi-minimal -it registry.access.redhat.com/ubi9/ubi-minimal bash
```

The main difference between the ubi and ubi-minimal images is that the first provides the full yum toolset. Yum adds some dependencies such as Python packages. In contrast, the second provides microdnf as a replacement. The microdnf tool works from the same repositories as Yum, but only provides the ability to install, update, and delete packages:

You can run the following command to verify the repositories in case of a minimal container image:

```bash
ls /etc/yum.repos.d/
```

You can also verify microdnf is installed:

```bash
microdnf --help
```

You can check the repolist using the microdnf command in the UBI minimal image:

```bash
microdnf repolist
```