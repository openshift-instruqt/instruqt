---
slug: containerize-your-first-application
id: jwg1w4lgwrha
type: challenge
title: Containerize Your First Application
teaser: 'Get started with Buildah and Podman: Your guide to containerizing your applications'
notes:
- type: text
  contents: |-
    # Welcome
    In this track, we'll explore the basics of Buildah and Podman and learn how to use them to build, run, and share container images with examples of deploying two games.

    Before, We move on let us understand Buildah, Podman and UBI.
    - Buildah: A tool for building OCI container images
    - Podman: A tool for running and managing containers
    - UBI: A Universal Base Image that provides a stable foundation for building containerized applications.

    Moon-buggy and Clumsy Bird are two games used as examples for deploying and containerizing applications using Buildah and Podman. Moon-Buggy is a text-based game played in the command line interface (CLI), while Clumsy-Bird is a web-based game.
tabs:
- title: Buildah
  type: terminal
  hostname: user
difficulty: basic
timelimit: 600
---
## Starting with Moon-Buggy Game



1. To start containerizing our Application (Moon-buggy), we'll first create a new container using the UBI9 image as the base.

```bash
buildah from registry.access.redhat.com/ubi9/ubi
```

This command will pull the UBI9 image from the Red Hat registry and create a new container using it as the base.

Buildah appends '-working-container' to indicate working containers (default).


2. Install EPEL repository to container for access to extra packages on Red Hat-based distributions.

```bash
buildah run ubi-working-container -- dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
```

This command runs the command

``
dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm
``

inside the container, **ubi-working-container**. This installs the EPEL repository to the container.

3. To install the Moon-buggy package, we'll run the following command after installing the EPEL repository:

```bash
buildah run ubi-working-container -- dnf -y install moon-buggy
```

4. To save changes made to the container and create a new deployable image, run the following command:

```bash
buildah commit ubi-working-container moon-buggy
```

This command takes the current state of the container **ubi-working-container** and creates a new image with the name moon-buggy.

This new image contains everything that was installed and configured in the running container

5. Now that we have the final image of our moon-buggy game, we can check for the image using the following command:

```bash
podman image list
```

6. Once we confirm that the image "moon-buggy" is present, we can use the following command to start a new container from the image and play the game:

```bash
podman run --name moon-buggy -it moon-buggy /usr/bin/moon-buggy
```

