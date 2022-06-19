---
slug: 01-logging-in-via-the-web-console
id: cb9k5j0ynrrf
type: challenge
title: Topic 1 - Logging in Via the Web Console
notes:
- type: text
  contents: |
    ## Goal

    In this track you'll learn how to log in to OpenShift using the web console and with the `oc` command line tool.

    ## Concepts and techniques you'll cover

    * Understanding OpenShift user authentication and authorization basics
    * Using the Web Console to login to OpenShift
    * Using the `oc` tool command line tool to login to OpenShift
    * OpenShift Projects and collaboration

    ## Use case

    You must log in to do anything on an OpenShift cluster. To collaborate on an OpenShift Project, you can authorize other users to see or modify resources in your Projects.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 501
---
In this topic you will learn how to use the command line to discover the URL for accessing the OpenShift web console. Also, you'll use the web console to create a project in OpenShift. You will work with the project you create here throughout the remainder of this track.

# Discovering the web console URL

Discovering the URL of the OpenShift web console is a two-step process. First, you need to confirm that the web console is indeed up and running in OpenShift. Then you need to query the OpenShift `route` resource object in order to get the URL for the web console running in the cluster.

`Step 1:` Run the following command to check that the pod responsible for the OpenShift web console is available. (You might have to wait a minute for the pod to be ready):

```
oc get pods -n openshift-console | grep console
```

You'll get output similar to the following:

```
console-7d599cbf78-4xc9v     1/1     Running   0          23mD
```

----

`Step 2:` Run the following command to find the route to the OpenShift web console:

```
oc get routes console -n openshift-console -o jsonpath='{"https://"}{.spec.host}{"\n"}'
```

You'll get the URL to the web console that is special to your instance of OpenShift running in the Instruqt interactive learning environment. The following is an example URL. **Yours will be different**.

```
https://console-openshift-console.crc-gh9wd-master-0.crc.q82njnglzds2.instruqt.io
```

----

`Step 3:` Copy the URL displayed in the output from `oc get routes` and paste it into a window in your web browser.

You'll be presented with the login page in the web console as shown in the figure below:

![Login](../assets/web-console-login.png)

Use the following username/password pair to log in:

* **Username:** `developer`
* **Password:** `developer`

Upon successful login, you are presented with a "Getting Started" message and the option of creating a new project.

----

`Step 4:` Click the `create a Project` link as shown in the figure below.

![Create Project](../assets/add_project.png)

----

`Step 5:` Name the project `myproject` as shown in the figure below.

![Name project](../assets/create-project-dialog.png)

----

`Step 6:` To see the details of the project you just created, click the **Project** tab on the vertical menu bar on the left of the Web Console, as shown in the figure below.

![Select Project](../assets/select-project.png)

# Congratulations!

 You've just learned how to discover the URL for the OpenShift web console and create a project.

----

**NEXT:** Logging in via the command line
