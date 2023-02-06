---
slug: containerizing-and-playing-clumsy-bird
id: ahhar0drqdxu
type: challenge
title: Containerizing and playing Clumsy-Bird
teaser: Deploy an Apache Server with Buildah and Podman
notes:
- type: text
  contents: |
    ****Containerizing and playing Clumsy-Bird****

    In this section, We'll be containerizing the Clumsy-bird game using Buildah and Podman. The process is similar to the one we used for Moon-buggy, with some changes.

    We'll create a new container using the UBI9 image as the base. After that, We'll install the game in the container. Finally, We'll commit the changes to create a new image that can be deployed.
tabs:
- title: Buildah
  type: terminal
  hostname: user
- title: Clumsy-Bird
  type: service
  hostname: user
  port: 8080
difficulty: basic
timelimit: 600
---
The Clumsy Bird Game has already been installed in the setup and We can't start with Building the Containers

1. We'll use UBI9 as the base image for our container. We'll use the following Buildah command to create the container:

```bash
buildah from registry.access.redhat.com/ubi9/ubi
```

Buildah adds **-working-container-1** for unique name to avoid duplication after creating a container

2. Now that the container is ready, install Apache and enable it as a service:

```bash
buildah run ubi-working-container-1 -- dnf -y install httpd
```

3. Enable Apache service in container for start automatically after boot:

```bash
buildah run ubi-working-container-1 -- systemctl enable httpd
```

4. Now that Apache is running in a container, copy Clumsy-bird game to Apache's document root (/var/www/html) for access.

To copy the content, we'll use the following command:

```bash
buildah copy ubi-working-container-1 clumsy-bird /var/www/html
```

5. Start container with web app running as a background service:

```bash
buildah config --port 80 --cmd "/usr/sbin/init" ubi-working-container-1
```

This command configures the container to:

I. accept connections on port 80 (for HTTP access via web browser)

II. run '/usr/sbin/init' at startup to start system services (such as Apache) in the background.

6. Commit container changes using the command:

```bash
buildah commit ubi-working-container-1 clumsy-bird
```

7. Now it's time to run the container. We'll use the following command to run the container:

```bash
podman run --name clumsy-bird -d -p 8080:80 clumsy-bird
```

This command starts new container 'clumsy-bird' from image, run in detached mode with port mapping (-p 8080:80) to route incoming connections to container's port 80.

8. Now that it's running, we can go over to the next instruqt tab where we’ll see the JavaScript application up and running at [http://localhost:8080](http://localhost:8080/)


You can also verify that the container is running with the command

```bash
podman ps
```

The port mapping can be seen with the command

```bash
podman port clumsy-bird
```