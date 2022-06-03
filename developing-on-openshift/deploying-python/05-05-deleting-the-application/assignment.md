---
slug: 05-deleting-the-application
id: gvkd6hyzkgyj
type: challenge
title: Topic 5 - Deleting the application from the command line
notes:
- type: text
  contents: Topic 5 - Deleting the application from the command line
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-gh9wd-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 300
---

In this topic you will use the OpenShift `oc` command line to tool to delete the application you created using the web console in previous topics. Then you will recreate the application from the command line using `oc`.

# Deleting the application

First, get a list of all of the underling Kubernetes resources running in the OpenShift cluster. (You can think of OpenShift as an architectural layer that runs over a Kubernetes cluster. OpenShift components such as deployments, routes, and service accounts correspond to resource objects in Kubernetes.)

`Step 1:` Run the following command to list the underlying Kubernetes resources running in the OpenShift cluster:

```
oc get all -o name
```

This will display output similar to:

```
pod/blog-django-py-1-build
pod/blog-django-py-64fb76b5c9-6hzhn
service/blog-django-py
deployment.apps/blog-django-py
replicaset.apps/blog-django-py-64fb76b5c9
replicaset.apps/blog-django-py-6c7f488b57
buildconfig.build.openshift.io/blog-django-py
build.build.openshift.io/blog-django-py-1
imagestream.image.openshift.io/blog-django-py
route.route.openshift.io/blog-django-py
```

Since you have only created one application, all of the resources listed above will relate to that application. When you have multiple applications deployed, you need a way to identify those resources according to a specific application so that you only delete components that correspond to the given application.

The way that OpenShift allows you associate resources to a given application is by using labels. You retrieve components according to a label by using a *label selector*.

A resource can none, one or many labels.

You use the `oc describe` command to inspect a resource to view its labels.

----

`Step 2:` Run the following command to view the details of the `route` resource named `blog-django-py`:

```
oc describe route/blog-django-py
```

You will get output similar to the following:

```
Name:                   blog-django-py
Namespace:              myproject
Created:                19 minutes ago
Labels:                 app=blog-django-py
                        app.kubernetes.io/component=blog-django-py
                        app.kubernetes.io/instance=blog-django-py
                        app.kubernetes.io/name=python
                        app.kubernetes.io/part-of=blog-django-py-app
                        app.openshift.io/runtime=python
                        app.openshift.io/runtime-version=3.6
Annotations:            openshift.io/host.generated=true
Requested Host:         blog-django-py-myproject.2886795320-80-simba02.environments.katacoda.com
                          exposed on router default (host apps-crc.testing) 19 minutes ago
Path:                   <none>
TLS Termination:        <none>
Insecure Policy:        <none>
Endpoint Port:          8080-tcp

Service:        blog-django-py
Weight:         100 (100%)
Endpoints:      10.128.0.65:8080
```

 Notice the `Labels:` attribute on the fourth line of the output displayed above. You will see 7 labels described as `key-value` pairs like so:

```
app=blog-django-py
app.kubernetes.io/component=blog-django-py
app.kubernetes.io/instance=blog-django-py
app.kubernetes.io/name=python
app.kubernetes.io/part-of=blog-django-py-app
app.openshift.io/runtime=python
app.openshift.io/runtime-version=3.6
```

Each line in the output above describes a label. The structure is `labelName=labelValue`. Thus in the key-value pair:

```
app=blog-django-py
```

the name of the label is `app` and the value is `app=blog-django-py`.


You can use the `oc` command line tool retrieve resources according to their labels.

----

`Step 3:` Run the command below to get all of the resources that have the label-value pair, `app=blog-django-py`.

```
oc get all --selector app=blog-django-py -o name
```

You'll get the following output:

```
pod/blog-django-py-7b98fb698b-vf6mb
service/blog-django-py
deployment.apps/blog-django-py
replicaset.apps/blog-django-py-7b98fb698b
replicaset.apps/blog-django-py-7fc8bdfb
buildconfig.build.openshift.io/blog-django-py
build.build.openshift.io/blog-django-py-1
imagestream.image.openshift.io/blog-django-py
route.route.openshift.io/blog-django-py
```

----

`Step 4:` Run the following command to retrieve resources that have the label pair `app=blog`:

```
oc get all --selector app=blog -o name
```

In this case, because there are no resources with the label ``app=blog``, the result will be empty.

When you create the application previously using the web console, OpenShift automatically applied the label `app=blog-django-py` to all of the application's resources.

----

`Step 5:` Run the following command to see the labels that OpenShift applied automatically:

```
oc get all --selector app=blog-django-py -o name
```

You'll get output similar to the following:

```
pod/blog-django-py-7b98fb698b-vf6mb
service/blog-django-py
deployment.apps/blog-django-py
replicaset.apps/blog-django-py-7b98fb698b
replicaset.apps/blog-django-py-7fc8bdfb
buildconfig.build.openshift.io/blog-django-py
build.build.openshift.io/blog-django-py-1
imagestream.image.openshift.io/blog-django-py
route.route.openshift.io/blog-django-py
```
----

Using labels to select resources provides an easy way to delete resources that are associated with a particular application.

`Step 6:` Run the following command to delete all of the resources associated with the Python application you installed previously.

```
oc delete all --selector app=blog-django-py
```

You'll get output similar to the following:

```
pod "blog-django-py-7b98fb698b-vf6mb" deleted
service "blog-django-py" deleted
deployment.apps "blog-django-py" deleted
buildconfig.build.openshift.io "blog-django-py" deleted
build.build.openshift.io "blog-django-py-1" deleted
imagestream.image.openshift.io "blog-django-py" deleted
route.route.openshift.io "blog-django-py" deleted
```
----

`Step 7:` Run the following command in the terminal window to confirm that the resources have been deleted.

```
oc get all --selector app=blog-django-py -o name
```

The response will be an empty response.

# Congratulations!

You have successfully deleted an application using the OpenShift `oc` command line tool.

----

**NEXT:** Deploying an application in OpenShift using the `oc` command line tool.
