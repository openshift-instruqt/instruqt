---
slug: playground
id: uktxvcbza27d
type: challenge
title: OpenShift Playground
notes:
- type: text
  contents: |
    ## Goal

    Explore OpenShift version 4.14.

    ## Concepts

    * OpenShift Web Console
    * `oc` command line tool

    ## Use case

    You control an OpenShift cluster for one hour. You can deploy your own container image, or set up a pipeline to build your application from source, then use an Operator to deploy and manage a database backend.

    This OpenShift cluster will self-destruct in one hour.
tabs:
- title: Terminal
  type: terminal
  hostname: crc
  cmd: /bin/bash
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-97g8f-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 3600
---
Before you get started we recommend reading the following tips. They explain
a bit about how the playground environment is setup and what access you have.

## Logging in to the Cluster via Dashboard

Let's also log in to our web console. This can be done by clicking the *Web Console* tab near the top of your screen.

You can login as `admin` user. Use the following credentials:

* Username:
```
admin
```
* Password:
```
admin
```
![Web Console Login](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/web-console-login.png)


You can also login as the `developer` user. Use the following credentials:

* Username:
```
developer
```
* Password:
```
developer
```

## Logging in to the Cluster via CLI

When the OpenShift playground is created you will be logged in initially as
a cluster admin:

```
oc whoami
```

This will allow you to perform
operations which would normally be performed by a cluster admin.

Before creating any applications, it is recommended you login as a distinct
user. This will be required if you want to log in to the web console and
use it.

To login to the OpenShift cluster from the _Terminal_ run:

```
oc login -u developer -p developer
```

This will log you in using the credentials:

* **Username:** ``developer``
* **Password:** ``developer``

Use the same credentials to log into the web console.

In order that you can still run commands from the command line as a cluster
admin, the ``sudoer`` role has been enabled for the ``developer`` account.
To execute a command as a cluster admin use the ``--as system:admin`` option
to the command. For example:

```
oc get projects --as system:admin
```

## Creating your own Project

To create a new project called ``myproject`` run the command:

```
oc new-project myproject
```

You could instead create the project from the web console. If you do this,
to change to the project from the command line run the command:

```
oc project myproject
```

## Persistent Volume Claims

Persistent volumes have been pre-created in the playground environment.
These will be used if you make persistent volume claims for an application.
The volume sizes are defined as 100Gi each, however you are limited by how
much disk space the host running the OpenShift environment has, which is
much less.

To view the list of available persistent volumes you can run:

```
oc get pv --as system:admin
```

## Builder Images and Templates

The playground environment is pre-loaded with Source-to-Image (S2I) builders
for Java (Wildfly), Javascript (Node.JS), Perl, PHP, Python and Ruby.
Templates are also available for MariaDB, MongoDB, MySQL, PostgreSQL and
Redis.

You can see the list of what is available, and what versions, under _Add to
Project_ in the web console, or by running from the command line:

```
oc new-app -L
```

## Running Images as a Defined User

By default OpenShift prohibits images from running as the ``root`` user
or as a specified user. Instead, each project is assigned its own unique
range of user IDs that application images have to run as.

If you attempt to run an arbitrary image from an external image registry
such a Docker Hub, which is not built to best practices, or requires that
it be run as ``root``, it may not work as a result.

In order to run such an image, you will need to grant additional privileges
to the project you create to allow it to run an application image as any
user ID. This can be done by running the command:

```
oc adm policy add-scc-to-user anyuid -z default -n myproject --as system:admin
```

# Next Steps!

Congratulations on completing this self-paced lab and learning about the capabilities of Red Hat OpenShift. To continue your journey, here's some handy links:

* [Red Hat Developer learning page](https://developers.redhat.com/learn)
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and provide your feedback on the next page. Thanks for playing!
