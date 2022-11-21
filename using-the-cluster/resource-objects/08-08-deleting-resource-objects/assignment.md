---
slug: 08-deleting-resource-objects
id: if4pnb6ucwx1
type: challenge
title: Topic 8 - Deleting Resource Objects
notes:
- type: text
  contents: Deleting Resource Objects
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
In this topic you will learn how to delete resource objects using the `oc delete` command.

You use the `oc delete` command to delete an entire application or just a single resource in an OpenShift cluster. Specific resource objects can be deleted by their names or by matching on a subset of resource objects using labels.

# Working with `oc delete`

`Step 1:` Run the following command to delete a single resource object by supplying the name:

```
oc delete route/parksmap-fqdn
```

You get the following results:

```
route.route.openshift.io "parksmap-fqdn" deleted
```

----

`Step 2:` Run the following command to delete all `route` resource objects that have the `labelName:labelValue` pair `"app":"parksmap"` by using the `--selector` option.

```
oc delete route --selector app=parksmap
```

You get the following results:

```
route.route.openshift.io "parksmap" deleted
route.route.openshift.io "parksmap-fqdn2" deleted
```

When using a label selector, you can list more than one resource object type name by separating them with a comma.

----

`Step 3:` Run the following command to delete all `service` and `route` resource objects that have the `labelName:labelValue` pair `"app":"parksmap"`:

```
oc delete svc,route --selector app=parksmap
```
You get the following results:

```
service "parksmap" deleted
```
Notice that only the `service` resource has been deleted. This is because the `route` resources are deleted in the previous step.

# Delete all resource objects according to a label

You can use the shortcut `all` to match all key resource objects types that are directly associated with the build and deployment of an application.

`Step 4:` Run the following command to delete all objects that have the `labelName:labelValue` pair `"app":"parksmap"`:

```
oc delete all --selector app=parksmap
```

You get the following results:

```
deployment.apps "parksmap" deleted
imagestream.image.openshift.io "parksmap" deleted
```

A good practice to make sure that you are deleting only the resource objects you intended is run the `oc get` with the same parameters you plan to use with `oc delete`. If the result of `oc get` conforms to the resource objects you intend to delete, you can proceed. For example, should you plan to delete all resource objects that have the label `app-parksmap`, running `oc get --selector app=parksmap` will show you the object you will be deleting

# Deleting all resource objects

Use `oc delete all` option delete all objects in an OpenShift project. Use the ``--all` option to confirm that you do really want to delete all resources objects from the project.

```
oc delete all --all
```

## Congratulations!

 You've learned the details of using the `oc delete` command to delete applications and resource objects in an OpenShift cluster.

----

This is the final topic in this track.
