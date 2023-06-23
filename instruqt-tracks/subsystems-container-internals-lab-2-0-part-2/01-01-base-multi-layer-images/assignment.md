---
slug: 01-base-multi-layer-images
id: gixybf48fwqy
type: challenge
title: 'Topic 1 - Image Layers and Repositories: inspecting base images, layers and
  history'
notes:
- type: text
  contents: |
    ## Background
    This lab is focused on understanding how container images are built, tagged, organized and leveraged to deliver software in a range of use cases.

    By the end of this lab you should be able to:
    - Internalize the difference between base images and multi-layered images
    - Understand the full URL of an image/repository
    - Command a complete understanding of what's inside of a container image

    ## Outline
    - Image Layers and Repositories: inspecting base images, layers and history
    - Image URLs: Mapping business requirements to the URL, Namespace, Repository and Tag
    - Image Internals: Inspecting the libraries, interpreters, and operating system components in a container image

    ## Other Material
    This presentation will give you a background to all of the concepts in this lab.
    - [Presentation](https://goo.gl/wnB7JK)
    - [Lab GitHub Repository](https://github.com/openshift-instruqt/instruqt/tree/874d2aa4decef440b36a79de881a39df12211c7c/instruqt-tracks/subsystems-container-internals-lab-2-0-part-2)

    ## Start Scenario
    Once you have watched the background video or went throught the presentation, continue to the exercises
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/labs
difficulty: intermediate
timelimit: 900
---
The goal of this exercise is to understand the difference between base images and multi-layered images (repositories). Also, we'll try to understand the difference between an image layer and a repository.

Let's take a look at some base images. We will use the podman history command to inspect all of the layers in these repositories. Notice that these container images have no parent layers. These are base images, and they are designed to be built upon. First, let's look at the full ubi7 base image:

```
podman history registry.access.redhat.com/ubi7/ubi:latest
```

Now, let's take a look at the minimal base image, which is part of the Red Hat Universal Base Image (UBI) collection. Notice that it's quite a bit smaller:

```
podman history registry.access.redhat.com/ubi7/ubi-minimal:latest
```

Now, using a simple Dockerfile we created for you, build a multi-layered image:

```
podman build -t ubi7-change -f ~/labs/lab2-step1/Dockerfile
```

Do you see the newly created ubi7-change tag?

```
podman images
```

Can you see all of the layers that make up the new image/repository/tag? This command even shows a short summary of the commands run in each layer. This is very convenient for exploring how an image was made.

```
podman history ubi7-change
```

Notice that the first image ID (bottom) listed in the output matches the registry.access.redhat.com/ubi7/ubi image. Remember, it is important to build on a trusted base image from a trusted source (aka have provenance or maintain chain of custody). Container repositories are made up of layers, but we often refer to them simply as "container images" or containers. When architecting systems, we must be precise with our language, or we will cause confusion to our end users.
