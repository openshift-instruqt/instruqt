---
slug: 01-deploying-an-application
id: c1jh9ejb2a7t
type: challenge
title: Topic 1 - Deploying an Application
notes:
- type: text
  contents: |
    ## Goal

    The goal of this track is to learn how to enumerate, describe, and update application resource objects on OpenShift.

    ## Concepts and techniques you'll cover

    * Understanding how to inspect OpenShift resource objects using the `oc` command line tool
    * Learning how to create an OpenShift application at the command line
    * Learning how to create OpenShift resource objects from using the command `oc create`
    * Learning how to update OpenShift resource objects from using the command `oc edit`
    * Learning how to replace OpenShift resource objects from using the command `oc update`
    * Learning how to delete OpenShift resource objects from using the command `oc delete`

    ## Use case

    You'll use the concepts and techniques described in this track when you want to find, query, and change the OpenShift resources that make up an application.
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 500
---

In this topic, you will log into OpenShift using the `oc login` command line tool. Then you will create an application using `oc new-project`. Finally, you'll expose the application for access outside of the OpenShift cluster using the `oc expose` command.

## Logging into OpenShift from the command line

`Step 1:` Run the following command in the terminal window to the left in order to log into OpenShift.

```
oc login -u developer -p developer https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

You'll get output similar to the following:

```
Login successful.

You don't have any projects. You can create a new project by running

    oc new-project <projectname>
```

## Creating a project using the `oc new-project` command

`Step 2:` Run the following command in the terminal window to the left in order to create an application named `myproject`.

```
oc new-project myproject
```

You'll get output similar to the following:

```
You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app rails-postgresql-example

to build a new example application in Ruby. Or use kubectl to deploy a simple Kubernetes application:

    kubectl create deployment hello-node --image=k8s.gcr.io/serve_hostname

```

## Creating a new application

`Step 3:` Run the following command to create a new appliction in OpenShift named `parksmap`:

```
oc new-app quay.io/openshiftroadshow/parksmap:1.3.0 --name parksmap
```

You'll get output similar to the following:

```
-> Found container image 472c23b (15 months old) from quay.io for "quay.io/openshiftroadshow/parksmap:1.3.0"

    * An image stream tag will be created as "parksmap:1.3.0" that will track this image

--> Creating resources ...
    imagestream.image.openshift.io "parksmap" created
    deployment.apps "parksmap" created
    service "parksmap" created
--> Success
    Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
     'oc expose service/parksmap'
    Run 'oc status' to view your app.
```

After OpenShift creates the application, you are switched automatically to the new project. Now you are ready to deploy the application.

The application you will deploy is the ParksMap web application that was the demonstration project used in *Getting Started with OpenShift for Developers* track.

By default, when using `oc new-app` from the command line to deploy an application, the application will not be exposed outside of the cluster. As mentioned above. you'll use the `oc expose` command to expose the application to the public.

## Exposing the application to the public

`Step 4:` Run the following command to expose the application to the public:

```
oc expose svc/parksmap
```

You'll get output similar to the following:

```
route.route.openshift.io/parksmap exposed
```

# Congratulations!

You've learned how to log into OpenShift from a terminal command line, and how to create an application that is exposed on the Internet.

----
**NEXT:** Understanding resource objects
