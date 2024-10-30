---
slug: 07-labelling-resource-objects
id: hoxyni7ulv4q
type: challenge
title: Topic 7 - Labelling Resource Objects
notes:
- type: text
  contents: Labelling Resource Objects
tabs:
- id: taz0zxswz0q9
  title: Terminal 1
  type: terminal
  hostname: container
- id: ny71wkfx2qsk
  title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 500
enhanced_loading: null
---

In this topic you will learn how to use labels to work with OpenShift resource objects.

# Understanding labels

In OpenShift, a label is similar to a tag. You use a label to identify some aspect of an OpenShift resource object according to the label's key-value pair. For example, the following example shows a snippet of JSON that assigned the label `"app": "parksmap"` to the `metadata` attribute in an OpenShift `route` resource object:

```
	"kind": "Route",
	"apiVersion": "v1",
	"metadata": {
		"name": "parksmap-fqdn",
		"labels": {
			"app": "parksmap"
		}
	}
  ```

Labels are useful for grouping OpenShift resource objects. Also, labels can be used to filter resource objects you are retrieving.

When you deploy an application using `oc new-app` a label is automatically applied to the resource objects created. For example, when you create an application named `parksmap`, OpenShift automatically inserts the labelName-labelValue pair `"app": "parksmap"` into all of the resource objects created for the application. (The code snippet above shows an example of the label inserted into the `route` resource object for an application named `parksmap`. As just mentioned, this label can be used to select a subset of resource objects when running queries.)

When you have multiple applications deployed, you can list all of the resource objects related to a specific application using the command `oc get all` along with the option `--selector`. The `--selector` option describes the label to match.

----

`Step 1:` Run the following command with the `--selector` option to get all resource objects in the cluster that have the label `"app": "parksmap"`:

```
oc get all -o name --selector app=parksmap
```

You get output similar to the following:

```
pod/parksmap-1-dvsqf
replicationcontroller/parksmap-1
service/parksmap
deploymentconfig.apps.openshift.io/parksmap
imagestream.image.openshift.io/parksmap
route.route.openshift.io/parksmap
route.route.openshift.io/parksmap-fqdn
```

# Creating a label with the `oc label` command

You can use the `oc label` command to apply labels to a resource object.

----

`Step 2:` Run the following command to add the label with the name `web` and the value `true` to the OpenShift `service` resource object named `parksmap`:

```
oc label service/parksmap web=true
```

You get the following output

```
service/parksmap labeled
```
----

`Step 3:` Run the following command to query all resource objects that have the label `"web": "true"`:

```
oc get all -o name --selector web=true
```

You get the following output:

```
service/parksmap
```

As you can see in the output above, only the resource object `service/parksmap` was returned in the response.

----

`Step 4:` Run the following command to remove a label from the resource object `service/parksmap`:

```
oc label service/parksmap web-
```

You get the following output:

```
service/parksmap unlabeled
```


Notice that appending the trailing ``-`` to the label name like so, `web-` indicates the label is to be removed.

# Congratulations!

 You've just learned how to add and remove labels to an OpenShift resource object.

----

**NEXT:** Deleting resource objects
