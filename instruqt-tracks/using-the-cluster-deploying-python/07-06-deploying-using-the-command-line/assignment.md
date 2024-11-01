---
slug: 06-deploying-using-the-command-line
id: 937vrpzmaj4t
type: challenge
title: Topic 6 - Deploying the application from the command line
notes:
- type: text
  contents: Topic 6 - Deploying the application from the command line
tabs:
- id: 0dguhydf9ck6
  title: Terminal 1
  type: terminal
  hostname: crc
- id: cwdexazkpedg
  title: Web Console
  type: website
  url: https://console-openshift-console.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 500
enhanced_loading: null
---

In this topic, you will use the `oc` command line tool to deploy the previously deployed application using the web console.

# Deploying the application using the command line tool

`Step 1:` Run the following command to deploy the blog application:

```
oc new-app python:latest~https://github.com/openshift-instruqt/blog-django-py
```

You'll get output similar to the following:

```
--> Found image f813306 (5 months old) in image stream "openshift/python" under tag "latest" for "python:latest"

    Python 3.9
    ----------
    Python 3.9 available as container is a base platform for building and running various Python 3.9 applications and frameworks. Python is an easy to learn, powerful programming language. It has efficient high-level data structures and a simple but effective approach to object-oriented programming. Python's elegant syntax and dynamic typing, together with its interpreted nature, make it an ideal language for scripting and rapid application development in many areas on most platforms.

    Tags: builder, python, python39, python-39, rh-python39

    * A source build using source code from https://github.com/openshift-instruqt/blog-django-py will be created
      * The resulting image will be pushed to image stream tag "blog-django-py:latest"
      * Use 'oc start-build' to trigger a new build

--> Creating resources ...
    imagestream.image.openshift.io "blog-django-py" created
    buildconfig.build.openshift.io "blog-django-py" created
    deployment.apps "blog-django-py" created
    service "blog-django-py" created
--> Success
    Build scheduled, use 'oc logs -f buildconfig/blog-django-py' to track its progress.
    Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
     'oc expose service/blog-django-py'
    Run 'oc status' to view your app.
```

OpenShift will assign a default name for the application created based on the name of the git repository that hosts the source code from the application. You may see a PodSecurity warning message in the output. This is because the application is being deployed using the default restrictive security context constraints (SCC) for the project.

As you might recall, the URL of the Git repository containing the web application is: `https://github.com/openshift-instruqt/blog-django-py`

In this case, the application is named `blog-django-py`. If you wanted to change the name, you could have supplied the ``--name`` option along with the name you wish to use as an argument.

# Monitoring the application

`Step 2:` Run the following command to monitor the log output from the build as it is running:

```
oc logs bc/blog-django-py --follow
```

This command will exit once the build has been completed. You can also interrupt the command by typing `CTRL+C` in the terminal window.

----

`Step 3:` Run the following command to view the status of any applications deployed to the project:

```
oc status
```

Once the build and deployment of the application have been completed, you will see output similar to the following:

```
root@container:/# oc status
In project myproject on server https://api.crc.testing:6443

svc/blog-django-py - 10.217.5.34:8080
  deployment/blog-django-py deploys istag/blog-django-py:latest <-
    bc/blog-django-py source builds https://github.com/openshift-instruqt/blog-django-py on openshift/python:latest
    deployment #2 running for about a minute - 1 pod
    deployment #1 deployed 2 minutes ago


1 info identified, use 'oc status --suggest' to see details.
```
----

Unlike the case of deploying the application from the web console, the application is not exposed outside of the OpenShift cluster by default.

`Step 4:` Run the following command to expose the application outside of the OpenShift cluster:


```
oc expose service/blog-django-py
```

You will get output similar to the following:

```
route.route.openshift.io/blog-django-py exposed
```

----

`Step 5:` To verify that the application has been deployed and is accessible via the Internet, switch to the OpenShift web console by selecting the **Web Console** tab above the terminal windows to the left. Then click the **Topology** tab on the vertical menu on the left of the web page.

You will see the circular graphic that represents the Python application.

You will note that the visualization in the Topology view doesn't show the icons corresponding to the build and source code repository. This is because they rely on special annotations and labels added to the deployment when creating an application from the web console. These annotations are not added automatically when creating the application from the command line. You can add the annotations later if you want.

The icon for accessing the URL is still present on the visualization. Alternatively, to view the hostname assigned to the route created from the command line, you can run the command:

```
oc get route/blog-django-py
```

You'll get output similar to the following:

```
NAME             HOST/PORT                                                                  PATH   SERVICES         PORT       TERMINATION   WILDCARD
blog-django-py   blog-django-py-myproject.crc.pfrbfxh9ypu7.instruqt.io          blog-django-py   8080-tcp                 None
```

# Congratulations!

You've just used the `oc` OpenShift CLI tool to delete an application created in the OpenShift web console and redeployed it using `oc`.

----

**NEXT:** Triggering new builds from the command line