---
slug: 03-querying-resource-objects
id: mwaybmtuxgni
type: challenge
title: Topic 3 - Querying Resource Objects
notes:
- type: text
  contents: Querying Resource Objects
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 180
---
In this topic you will learn how to get information about a resource object using a variety of `oc` commands.

# Describing a resource object

To get a more detailed description of a specific resource object, you can use the ``oc describe`` command.

`Step 1:` Run the following command to view the details of the parksmap `route`.

```
oc describe route/parksmap
```

You will see output similar to the following:

```
Name:                   parksmap
Namespace:              myproject
Created:                2 minutes ago
Labels:                 app=parksmap
                        app.kubernetes.io/component=parksmap
                        app.kubernetes.io/instance=parksmap
Annotations:            openshift.io/host.generated=true
Requested Host:         parksmap-myproject.crc-5nvrm-master-0.crc.vzc8lf1zaimp.instruqt.io
                           exposed on router default (host router-default.crc-5nvrm-master-0.crc.vzc8lf1zaimp.instruqt.io) 2 minutes ago
Path:                   <none>
TLS Termination:        <none>
Insecure Policy:        <none>
Endpoint Port:          8080-tcp

Service:        parksmap
Weight:         100 (100%)
Endpoints:      10.217.0.111:8080
```

Whenever passing a specific resource object as an argument to an ``oc`` command, there are two conventions that can be used. The first is to use a single string of the form ``type/name``. The second is to pass the ``type`` and ``name`` as separate consecutive arguments. The command:

```
oc describe route parksmap
```

is therefore equivalent.

# Viewing information in a JSON or YAML format

The output produced by `oc describe` is intended to be a human readable format. To get the raw object details as JSON or YAML, you can use the `oc get` command, listing the name of the resource and the output format.

For JSON output, you can use:

```
oc get route/parksmap -o json
```

For YAML output, you can use:

```
oc get route/parksmap -o yaml
```

# Working with `oc explain`

To see a description of the purpose of specific fields in a resource object, you can use the `oc explain` command, providing it with a path selector for the field.

`Step 2:` Run the following command to see the description of the `route` object's `host.spec` attribute:

```
oc explain route.spec.host
```

This will output:

```
KIND:     Route
VERSION:  route.openshift.io/v1

FIELD:    host <string>

DESCRIPTION:
     host is an alias/DNS that points to the service. Optional. If not specified
     a route name will typically be automatically chosen. Must follow DNS952
     subdomain conventions.
```
# Congratulations!

 You've learned how to query resource objects using the `oc describe`, `oc explain`, and `oc get` commands.

----

**NEXT:** Editing resource objects
