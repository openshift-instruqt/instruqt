---
slug: explore-cli
id: sy3mg3yzxbjl
type: challenge
title: Step 1 - Getting started with OpenShift
notes:
- type: text
  contents: |
    ## Goal

    The goal of this track is to learn how to use the OpenShift Container Platform to build and deploy an application that has a data backend and a web frontend.

    |What you need to know before you start|
    |----|
    |In order to get full benefit from taking this track, you should...<br>• Be comfortable working at the command line in a terminal window.<br>• Have a general understanding about the purpose and use of [OpenShift](https://www.redhat.com/en/technologies/cloud-computing/openshift/container-platform)|

    ## Concepts and techniques you'll cover

    * Understanding the OpenShift Web Console and viewing perspectives
    * Understanding how to login to OpenShift using the `oc` command line tool
    * How to build applications from a container image using OpenShift Web Console
    * How to access public URLs by working with OpenShift Routes

    ## Use case

    You'll use the concepts and techniques covered in this track to get a basic understanding of how to work with OpenShift in the Web Console and at the command line. OpenShift runs as a layer over Kubernetes and makes working with both Kubernetes and Linux containers easier. The result is that when developers use OpenShift they are free to focus on their code instead of spending time writing Dockerfiles and running container builds.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 800
---
# Working with the Command Line Interface (CLI)

You can access the Red Hat OpenShift CLI with the command `oc`. Using the `oc` command lets you work with the entire OpenShift cluster and deploy new applications.

The CLI exposes the underlying Kubernetes orchestration system with the enhancements made by OpenShift. Users familiar with Kubernetes will be able to adapt to OpenShift quickly.

`oc` provides all of the functionality of the Kubernetes `kubectl` CLI tool. In addition, `oc` makes it easier to work with OpenShift. The CLI is ideal in situations where you are:

* Working directly with project source code
* Scripting OpenShift operations
* Cannot use the web console because of resource bandwidth restrictions

Let's start by logging in with `oc` for your first experience with this CLI.

# Logging in with the CLI
You log into OpenShift from the command line using the `oc login` command.

----

`Step 1:` Run the following command in the terminal window to the left:

```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

Upon successful login, you'll get results similar to the following:

```
Login successful.

You have access to 64 projects, the list has been suppressed. You can list all projects with 'oc projects'

Using project "default".
```

Running the Linux [`whoami`](https://en.wikipedia.org/wiki/Whoami) command reports the current user and implicitly confirms that the login is successful.

----

`Step 2:` Run the following command:

```
oc whoami
```

You'll get the following results:

```
admin
```

# Congratulations!

 You've logged in to OpenShift using the `oc` command line tool.

----

**NEXT:** Create your first project using the **web console**.
