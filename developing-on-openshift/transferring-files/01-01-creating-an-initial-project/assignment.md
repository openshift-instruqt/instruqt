---
slug: 01-creating-an-initial-project
id: e6xfeurfocu7
type: challenge
title: Topic 1 - Creating an Initial Project
notes:
- type: text
  contents: |
    ## Goal

    The goal of this track is to demonstrate how to copy files to and from a running container without rebuilding the container image. In addition, the track will demonstrate how to use a Persistent Volume and Persistent Volume claim under OpenShift to store data independent of a container.

    ## Concepts and techniques you'll cover

    * Creating OpenShift projects and applications from the command line using the `oc` command
    * Copying files from a container and into a local machine using the `oc resync` command
    * Using the implicit automation available in OpenShift to copy changed files on a local machine to a container's file system.
    * Work with a Persistent Volume and Persistent Volume claim independent of a container

    ## Use case

    You use the concepts and techniques covered in this track when you want to manually or automatically synchronize changes in the files on a local machine with containers in an OpenShift cluster and vice versa.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
difficulty: intermediate
timelimit: 360
---
In this topic you will log in and create a project in OpenShift, for use through the following topics.

Start by logging into the track's OpenShift cluster, using the credentials:

* **Username:** `admin`
* **Password:** `admin`

----

`Step 1:` Run the following command to log into the track's OpenShift cluster:
```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

You will see the output:

```
Login successful.

You have access to 64 projects, the list has been suppressed. You can list all projects with 'oc projects'

Using project "default"
```

----

`Step 2:` Run the following command to create a new project named `myproject`

```
oc new-project myproject
```

You will see output similar to:

```
Now using project "myproject" on server "https://api.crc.testing:6443".

You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app rails-postgresql-example

to build a new example application in Ruby. Or use kubectl to deploy a simple Kubernetes application:

    kubectl create deployment hello-node --image=k8s.gcr.io/serve_hostname
```

# Congratulations!

 You just logged into the track's OpenShift cluster and created a project named `myproject`.

----

**NEXT:** Downloading files from a container
