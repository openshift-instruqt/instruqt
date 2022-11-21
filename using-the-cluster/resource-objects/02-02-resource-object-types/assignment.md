---
slug: 02-resource-object-types
id: gdjebricja3k
type: challenge
title: Topic 2 - Understanding Resource Objects
notes:
- type: text
  contents: Understanding Resource Objects
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

In this topic you will learn to list and examine the various resource objects available in OpenShift. You'll also learn about the various ways to use the `oc get` and `oc api-resources` commands.

# Using the `oc get` command

The `oc get` command is the most basic command that exists in OpenShift. You use `oc get` to query OpenShift about resource objects.

The subcommand `all` retrieves all of the information about the key resource objects.

Let's exercise the `all` subcommand to list all of the key resource objects that were created within the project.

----

`Step 1:` Run the following command to list the resource objects:

```
oc get all
```

You'll see output similar to the following:

```
NAME                            READY   STATUS    RESTARTS   AGE
pod/parksmap-867b495f94-m868m   1/1     Running   0          35s

NAME               TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)    AGE
service/parksmap   ClusterIP   10.217.4.215   <none>        8080/TCP   35s

NAME                       READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/parksmap   1/1     1            1           35s

NAME                                  DESIRED   CURRENT   READY   AGE
replicaset.apps/parksmap-7c4b487459   0         0         0       35s
replicaset.apps/parksmap-867b495f94   1         1         1       35s

NAME                                      IMAGE REPOSITORY                                                                                            TAGS    UPDATED
imagestream.image.openshift.io/parksmap   default-route-openshift-image-registry.crc-lgph7-master-0.crc.aa5od8iq5doy.instruqt.io/myproject/parksmap   1.3.0   35 seconds ago

NAME                                HOST/PORT                                                            PATH   SERVICES   PORT       TERMINATION   WILDCARD
route.route.openshift.io/parksmap   parksmap-myproject.crc-lgph7-master-0.crc.aa5od8iq5doy.instruqt.io          parksmap   8080-tcp                 None            None
```

You can use the `-o name` option to restrict output to show only the names of the resources.

----

`Step 2:` Run the following command to restrict output to show only the names of the resources:

```
oc get all -o name
```

You'll get output similar to the following:

```
pod/parksmap-867b495f94-m868m
service/parksmap
deployment.apps/parksmap
replicaset.apps/parksmap-7c4b487459
replicaset.apps/parksmap-867b495f94
imagestream.image.openshift.io/parksmap
route.route.openshift.io/parksmap
```

# Querying a specific resource object

`Step 3:` Run the following command to get a list of the `routes` resources:

```
oc get routes
```

You'll see output similar to the following:

```
NAME       HOST/PORT                                                            PATH   SERVICES   PORT       TERMINATION   WILDCARD
parksmap   parksmap-myproject.crc-lgph7-master-0.crc.aa5od8iq5doy.instruqt.io          parksmap   8080-tcp                 None
```

# Listing the OpenShift resource objects

You can get a list of the different resource object types available in OpenShift by using the `oc api-resources`.

----

`Step 4:` Run the following command to list the resource object types available in OpenShift:

```
oc api-resources
```

The resulting output will be a very long list. The following is a snippet of the result:

```
NAME                                  SHORTNAMES       APIGROUP                              NAMESPACED   KIND
bindings                                                                                     true         Binding
componentstatuses                     cs                                                     false        ComponentStatus
configmaps                            cm                                                     true         ConfigMap
endpoints                             ep                                                     true         Endpoints
events                                ev                                                     true         Event
limitranges                           limits                                                 true         LimitRange
namespaces                            ns                                                     false        Namespace
nodes                                 no                                                     false        Node
.
.
.
```

Many resource object types can be queried using a shorter alias. For example, you can use the alias `cm` instead of the full term `configmaps`.

You can also use the singular term for resource objects instead of the plural. For example, you can use the term `route` instead of the term `routes`.

----

`Step 5:` Run the following command to get a list of all routes. Notice that only the singular term is used:

```
oc get route
```

You'll get output similar to the following:

```
NAME       HOST/PORT                                                            PATH   SERVICES   PORT       TERMINATION   WILDCARD
parksmap   parksmap-myproject.crc-lgph7-master-0.crc.ejsovmyiskmk.instruqt.io          parksmap   8080-tcp                 None
```

Notice that the result above shows the URL to use to access the particular application on the Internet. This URL was created automatically by OpenShift.

# Congratulations!

 You've just learned the basics of using `oc get` and `oc api-resources`.

----

**NEXT:** Querying resource objects
