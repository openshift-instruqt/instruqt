---
slug: 01-creating-an-initial-project
id: jp6kbmqiml2x
type: challenge
title: Topic 1 - Creating an Initial Project
notes:
- type: text
  contents: |
    ## Goal

    The goal of this lesson is to learn how to deploy an application on OpenShift with the web console and with the `oc` command line tool.

    ## Concepts and techniques you'll cover

    * How to deploy a container image to an OpenShift cluster
    * Understanding how to work with the OpenShift Web Console’s Topology view
    * Understanding how to scale up an application created from a container image
    * Using the OpenShift `oc` tools to  delete an existing application and create a new one

    ## When to use container image deployment

    You deploy a container image on an OpenShift cluster in order to make the application easier to manage, scale, connect and monitor.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 500
---

In this topic, you will learn how to log into an OpenShift cluster from the command line, and also by using the web console.

----

`Step 1:` Run the following command in the terminal window to the left to log into the OpenShift cluster as **Username:** `developer` with **Password:** `developer`:

```
oc login -u developer -p developer https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

You will see the following output when your login is successful:

```
Login successful.

You don't have any projects. You can try to create a new project, by running

    oc new-project <projectname>
```

Once you are logged in, you will create a new project named, `myproject`.

----

`Step 2:` Run the following command to create a project named, `myproject`:

```
oc new-project myproject
```

You will see the following output upon success:

```
Now using project "myproject" on server "https://openshift:6443".

You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app django-psql-example

to build a new example application in Python. Or use kubectl to deploy a simple Kubernetes application:

    kubectl create deployment hello-node --image=gcr.io/hello-minikube-zero-install/hello-node
```

----

`Step 3:`  Switch to the OpenShift web console by clicking the **Web Console** tab, which is the second tab in the horizontal menu bar at the top of the terminal window to the left.

|NOTE:|
|----|
|You might see the following warning notification due to using an untrusted security certificate.
![Security warning](..\assets\security_warning.png)
If you do get the warning, click the **Advanced** button to complete the process necessary to grant permission to the browser to access the OpenShift Web Console.|

----

`Step 4:`  Enter the **Username:** `developer` and **Password:** `developer` pair shown in the figure below.

![login dialog](..\assets\web-console-login.png)

You will see the list of projects you have access to. Since you only created one project previously, you will see that project as shown in the figure below.

![Project list](..\assets\select-project.png)

----

`Step 5:`  Click on `myproject`. You will be presented with the **Topology** page as shown in the figure below.

![Topology without resource](..\assets\topology-no-resources.png)

Notice that the project has no resources.

# Congratulations!

You've just logged in to an OpenShift cluster using the command line as well as using the web console.

----

**NEXT:** Deploying an application from a container image using the web console