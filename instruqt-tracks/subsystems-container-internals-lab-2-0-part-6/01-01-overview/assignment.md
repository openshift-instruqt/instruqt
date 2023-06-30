---
slug: 01-overview
id: mrbivh60c981
type: challenge
title: Overview of The OCI Specifications
notes:
- type: text
  contents: |
    ## Background
    This lab is focused on understanding some of the container standards that govern this space. This will help you better architect your own environments, feeling more confident about where to invest.

    By the end of this lab you should be able to:
    - Explain the Image, Runtime, and Distribution specifications
    - Have a basic understanding of the major metadata files
    - Be able to start a container from scratch

    ## Outline
    - An overview of the three OCI specifications
    - The OCI image specification
    - The OCI runtime specification
    - The OCI reference implementation of the runtime specification (runc) and how to start a container

    ## Other Material
    - [Presentation](https://docs.google.com/presentation/d/1fC9cKR2-kFW5l-VEk0Z5_1vriYpROXOXM_5rhyVnBi4/edit#slide=id.g20639ff941_0_42)
    - [Lab GitHub Repository](https://github.com/openshift-instruqt/instruqt/tree/09022064268036919f5038ca18f6eab5e509f8a8/instruqt-tracks/subsystems-container-internals-lab-2-0-part-6)

    ## Start Scenario
    Once you have gone through the presentation, continue to the exercises
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: intermediate
timelimit: 375
---
The goal of this lab is to get a basic understanding of the three Open Containers Initiative (OCI) specificaitons that govern finding, running, building and sharing container - image, runtime, and distribution. At the highest level, containers are two things - files and processes - at rest and running. First, we will take a look at what makes up a [Container Repository](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/#h.20722ydfjdj8) on disk, then we will look at what directives are defined to create a running [Container](https://developers.redhat.com/blog/2018/02/22/container-terminology-practical-introduction/#h.j2uq93kgxe0e).

If you are interested in a slightly deeper understanding, take a few minutes to look at the OCI  work, it's all publicly available in GitHub repositories:

- [The Image Specification Overview](//github.com/opencontainers/image-spec/blob/master/spec.md#overview)
- [The Runtime Specification Abstract](//github.com/opencontainers/runtime-spec/blob/master/spec.md)
- [The Distributions Specification Use Cases](https://github.com/opencontainers/distribution-spec/blob/master/spec.md#use-cases)

Now, lets run some experiments to better understand these specifications.
