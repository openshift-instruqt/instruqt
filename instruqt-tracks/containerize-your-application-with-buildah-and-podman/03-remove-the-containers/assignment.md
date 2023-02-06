---
slug: remove-the-containers
id: zgvhfuvgud68
type: challenge
title: Removing the Containers
teaser: Deleting the Containers
notes:
- type: text
  contents: |+
    **Cleaning the Containers**

    When you're done using a container, you can now remove it from the host. This section will help you with the commands for stopping and removing the containers from the host.



tabs:
- title: Buildah
  type: terminal
  hostname: user
difficulty: basic
timelimit: 600
---
**Cleaning the Containers**

When you're done using a container, you can stop it using the command `podman stop` remove it using the command `podman rm`

The **podman stop** command stops the container runtime images. You can pass multiple image names as arguments if you want to stop multiple containers at once. For Example:
```bash
podman stop clumsy-bird moon-buggy
```

The **podman rm**
 command permanently deletes the container runtime images, and as similar to `podman stop` can have multiple image names as arguments. For Example:

```bash
podman rm clumsy-bird moon-buggy
```