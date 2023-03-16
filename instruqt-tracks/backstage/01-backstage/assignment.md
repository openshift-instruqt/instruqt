---
slug: backstage
id: m45z0bv1ps9a
type: challenge
title: Backstage Playground
notes:
- type: text
  contents: |
    ## Goal

    Explore Backstage on OpenShift

    ## Concepts

    * OpenShift Web Console
    * `oc` command line tool

    ## Use case

    You control an OpenShift cluster for one hour. You can deploy your own container image, or set up a pipeline to build your application from source, then use an Operator to deploy and manage a database backend.

    This OpenShift cluster will self-destruct in one hour.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-rwwzd-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Backstage
  type: website
  url: https://backstage.apps.crc-rwwzd-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
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
oc login -u admin -p admin
```

This will log you in using the credentials:

* **Username:** ``admin``
* **Password:** ``admin``

Use the same credentials to log into the web console.

# Accessing Backstage

Check to see if the installation of Backstage has reached completion:

```
oc get pods -n backstage
```

If two pods are up and running, you will be able to access the installation of backstage via the following route:

```
oc get routes -n backstage
```

Or, use the "Backstage" tab to open backstage in a new window
