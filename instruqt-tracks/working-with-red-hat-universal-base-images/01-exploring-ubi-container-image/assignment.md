---
slug: exploring-ubi-container-image
id: oe4vwhexwwbf
type: challenge
title: Exploring the UBI container image
teaser: Download and run a UBI-based container from Red Hat's public repositories
notes:
- type: text
  contents: |-
    # Welcome

    In this Track, we'll explore Red Hat Universal Base Images more commonly know as UBI. We will explore both the UBI as well as the UBI minimal container image. We will also create a sample application using PHP and a UBI container image. The track has been broken down into three separate modules:

    1. In the first module we will create and explore a Red Hat UBI base image.
    2. In the second module we will create and explore a Red Hat UBI minimal image and look at its differences from the base image.
    3. In the third module we will create a sample PHP application using a Red Hat UBI base image and run it on our host.
tabs:
- title: ubi
  type: terminal
  hostname: user
difficulty: basic
timelimit: 300
---
In this section we are going to explore a Red Hat UBI-9 image:

**Running a UBI-based container:**

Run the following command to start a UBI-based container:

```bash
podman run --name ubi9 -it registry.access.redhat.com/ubi9/ubi bash
```


**Exploring the container image:**
Previosuly you would have required a Red Hat subscription to download RHEL packages. But after the introduction of UBI, the images comes with its own set of package repositories with freely distributable content. These repositories form a subset of RHEL packges.

Run the following command to see these repositories:
```bash
yum repolist
```

If you are a Java developer, UBI provides both the new and old releases of OpenJDK. Run the following command to search for the releases:
```bash
yum search openjdk
```

If you have a valid Red Hat subscription then the UBI images provides access to all of RHEL package repositories, otherwise it provides access to only the UBI repositories:

Run the following command to check the repositories you have access to:
```bash
ls /etc/yum.repos.d/
```

If you are curious about the UBI repositories, check the ubi.repo configuration file by running the following command:
```bash
cat /etc/yum.repos.d/ubi.repo
```