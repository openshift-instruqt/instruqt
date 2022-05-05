---
slug: 04-deleting-the-application
id: faje3hq0dffo
type: challenge
title: Topic 4 - Deleting the Application Using the Web Console
notes:
- type: text
  contents: Deleting the Application Using the Web Console
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-dzk9v-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 180
---
In this topic you will learn how to delete an OpenShift application from the command line using the `oc delete` command.

In order to delete the ParksMap application, you need to delete all of the resource objects that it uses. The way you identify resources bound to the application is according to the label `app=parkman`.

The label `app=parkman` is a key-value pair that OpenShift assigned to all of the resource objects the ParksMap applications uses.

OpenShift assigned the label to the resource objects when ParksMap was created. Let's take a look at how the `app=parkman` label is applied to the `route` resource object.

----

`Step 1:` Run the following command in the terminal window to view all of the details stored in OpenShift about the resource object `route/parksmap`:

```
oc describe route/parksmap
```

You will see output similar the following:

```
Name:                   parksmap
Namespace:              myproject
Created:                59 minutes ago
Labels:                 app=parksmap
                        app.kubernetes.io/component=parksmap
                        app.kubernetes.io/instance=parksmap
                        app.kubernetes.io/name=parksmap
                        app.kubernetes.io/part-of=parksmap-app
                        app.openshift.io/runtime-version=latest
Annotations:            openshift.io/host.generated=true
Requested Host:         parksmap-myproject.crc-dzk9v-master-0.crc.2fxr0dqhkd8a.instruqt.io
                           exposed on router default (host router-default.crc-dzk9v-master-0.crc.2fxr0dqhkd8a.instruqt.io) 59 minutes ago
Path:                   <none>
TLS Termination:        <none>
Insecure Policy:        <none>
Endpoint Port:          8080-tcp

Service:        parksmap
Weight:         100 (100%)
Endpoints:      10.217.0.118:8080, 10.217.0.140:8080
```

As you can see there are many labels assigned to the `route` resource object. Notice the fourth line shown above:

```
Labels:                 app=parksmap
```

This line indicates that the resource object does indeed have the label `app=parksmap`.

You can view all resource objects in the project according to a particular label by using the `--selector` option with the `oc get all` command.

----

`Step 2:` Run the following command to get all resource objects that have been assigned the label `app=parksmap`.

```
oc get all --selector app=parksmap -o name
```

You'll get output similar to the following:

```
pod/parksmap-55bd768c78-57vwl
pod/parksmap-55bd768c78-bnt4d
service/parksmap
deployment.apps/parksmap
replicaset.apps/parksmap-55bd768c78
imagestream.image.openshift.io/parksmap
route.route.openshift.io/parksmap
```

The resource objects shown above are the ones that have the label `app=parkman`. The resource objects need to be deleted in order to remove the entire ParksMap application from the project.

----

`Step 3:` Run the following command to delete all resource objects according to the label `app=parksmap`:

```
oc delete all --selector app=parksmap
```

You'll get output similar to the following:

```
pod "parksmap-55bd768c78-57vwl" deleted
pod "parksmap-55bd768c78-bnt4d" deleted
service "parksmap" deleted
deployment.apps "parksmap" deleted
imagestream.image.openshift.io "parksmap" deleted
route.route.openshift.io "parksmap" deleted
```

You have now deleted the ParksMap application.

Be advised that under certain conditions it can take seconds, sometimes even a minute or two to delete the application's resource objects.

Remember, you are asking OpenShift to delete the resource. You are not doing the actual delete. Rather, OpenShift scheduled deletion for the particular resource objects. OpenShift tries to shut down applications gracefully. This can take time.

Let's confirm that ParksMap has been deleted.

----

`Step 4` Run the following command to confirm that the all of the resource objects associated with the ParksMap application have been deleted:

```
oc get all -o name
```

When the delete has been completed, no output is returned.

If you do still see any resources listed in the output, keep running `oc delete` until no response is returned.

Be aware that applying the label `app=<app_name>` to resource objects upon application creation is conventional. Another label might be used.

For example, when an application is created from a template, the label's key-value pair is dictated by the template. As a result, a template may use a different labelling convention.

Always use `oc describe` to verify the labels that have been applied and use `oc get all --selector` to verify the matching resources before deleting any resource objects.

# Congratulations!

You've just learned how to delete an application from OpenShift using `oc delete` at the command line

----

**NEXT:** Deploying the application from a container image using the command line
