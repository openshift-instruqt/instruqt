---
slug: 01-creating-an-initial-project
id: 0sdpul4yutc2
type: challenge
title: Topic 1 - Creating the demonstration project
notes:
- type: text
  contents: |
    ## Goal

    The goal of this track is to teach you how to use port forwarding to run a database as persistent storage on OpenShift. You'll learn how to access a database server in an OpenShift cluster from the command line. Also, you'll learn how to use port forwarding to temporarily expose a database service outside of an OpenShift cluster. Once a database is exposed outside of the cluster you can work with it using a database API tool such as a database administration client.

    ## Concepts and techniques you'll cover

    * Working with the OpenShift `oc` command line tool
    * Creating OpenShift projects and applications from the command line
    * Understanding Persistent Volumes storage in OpenShift clusters using a database
    * Understanding provisional routing of external traffic to cluster services using port forwarding
    * Working with a database in an OpenShift cluster from a local machine using port forwarding

    ## Use case

    You'll use the concepts and techniques covered in this track when you want to deploy an application's database server to an OpenShift cluster and then work with it directly throughout a continuous software development life development (SDLC) as the application matures from the development stage and on toward production release.
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 225
---
In this topic you will learn how to log into an OpenShift cluster from the command line, and then create a demonstration project within the OpenShift cluster.

Let's start by logging in to the underlying OpenShift cluster using the following `Username/Password` credentials.

* **Username:** ``developer``
* **Password:** ``developer``

----

`Step 1:` Run the following command in the the terminal window to the left to log into the underlying OpenShift cluster. (Clicking on the command text below copies the command to your computer's clipboard automatically.)

```
oc login -u developer -p developer https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

You will see output similar to:

```
Login successful.

You don't have any projects. You can try to create a new project, by running

    oc new-project <projectname>
```

----

`Step 2:` Run the following command to create a new project called `myproject`.

```
oc new-project myproject
```

You will see output similar to:

```
ow using project "myproject" on server "https://api.crc.testing:6443".

You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app rails-postgresql-example

to build a new example application in Ruby. Or use kubectl to deploy a simple Kubernetes application:

    kubectl create deployment hello-node --image=k8s.gcr.io/serve_hostname
```

# Congratulations!
You just learned to how to log into an OpenShift cluster from the command line. You also learned how to create an OpenShift project named `myproject` at the command line.

----

**NEXT:** Deploying a PostgreSQL database