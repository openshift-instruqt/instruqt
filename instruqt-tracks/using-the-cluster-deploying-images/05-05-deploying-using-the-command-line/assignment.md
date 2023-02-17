---
slug: 05-deploying-using-the-command-line
id: ncgsbepeuyem
type: challenge
title: Topic 5 - Deploying the Application from a Container Image Using the Command
  Line
notes:
- type: text
  contents: Deploying the Application from a Container Image Using the Command Line
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 500
---

In this topic you will deploy an application into OpenShift from the command line.

In the previous topic you deleted the ParksMap application. Now, let's reinstall it using the `oc` command line tool.

Remember, previously the container image for the ParksMap application was stored in the Quay.io Container Repository at `quay.io/openshiftroadshow/parksmap:latest`.

You'll use the container image again when installing the application from the command line.

# Confirming the the application's container image on the Quay.io container repository

`Step 1:` Run the following command to search the Quay.io container repository to confirm that the ParksMap container image is indeed stored there:

```
oc new-app --search quay.io/openshiftroadshow/parksmap:latest
```

You will get output similar to the following:

```
container images (oc new-app --image=<image> [--code=<source>])
-----
quay.io/openshiftroadshow/parksmap
  Registry: quay.io
  Tags:     latest
```

This output confirms that the ParksMap container image is stored in the Quay.io container repository.

# Creating the application

`Step 2:` Run the following command in the terminal window to the left to deploy the ParksMap application into your OpenShift project:

```
oc new-app quay.io/openshiftroadshow/parksmap
```

You will get output similar to the following:

```
--> Found container image 0c2f55f (13 months old) from quay.io for "quay.io/openshiftroadshow/parksmap"

    * An image stream tag will be created as "parksmap:latest" that will track this image

--> Creating resources ...
    imagestream.image.openshift.io "parksmap" created
    deployment.apps "parksmap" created
    service "parksmap" created
--> Success
    Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
     'oc expose service/parksmap'
    Run 'oc status' to view your app.
```

OpenShift assigns a default name to the application based on the name of the image, in this case `parksmap`.

You can specify a different name to be given to the application, and the resources created, by using the `--name` option with `oc new-app`.

For example this command will create a version of the ParksMap application with the name, `myparksmap`:
```
oc new-app quay.io/openshiftroadshow/parksmap --name myparksmap
```
# Exposing the application to the public

When you deploy a web application from the command line using `oc`, you need to manually create the `route` resource object that exposes the application publicly on the Internet.

----

`Step 3:` Run the following command to expose the ParksMap application to the public.

```
oc expose service/parksmap
```

You'll get output similar to the following:

```
route.route.openshift.io/parksmap exposed
```


Once you've exposed the application, you need to get the actual URL published by the `route` resource object.

# Creating a route to the application

`Step 4:` Run the following command to get the URL to the ParksMap application:

```
oc get route/parksmap
```

You'll get output similar to the following

```
NAME       HOST/PORT                                                            PATH   SERVICES   PORT       TERMINATION   WILDCARD
parksmap   parksmap-myproject.crc-lgph7-master-0.crc.2fxr0dqhkd8a.instruqt.io          parksmap   8080-tcp                 None
```

Notice the output above has the URL `parksmap-myproject.crc-lgph7-master-0.crc.2fxr0dqhkd8a.instruqt.io`.

This is the `route` to the new instance of the ParkMap application that was just installed. You can copy into a browser window to access the ParksMap application.

The URL you'll get when you run `oc get route/parksmap` will be different than the one shown above because the URL that OpenShift creates depends on unique information that is only available after the application was created.

However, as you can see in the figure below, the URL that was generated for this tutorial does indeed bring up the ParksMap application.

![Command Line URL](../assets/command-line-url.png)

## Congratulations!

You've just learned to how to deploy an OpenShift application from the command line using the `oc` CLI tool.

----

This is the final topic in this track.

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
