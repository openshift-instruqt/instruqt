---
slug: 05-creating-resource-objects
id: 2wkeusbxt2zt
type: challenge
title: Topic 5 - Creating Resource Objects
notes:
- type: text
  contents: Creating Resource Objects
tabs:
- id: eib5t9pxbj9x
  title: Terminal 1
  type: terminal
  hostname: container
- id: 0r9omrlgjz7d
  title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 500
enhanced_loading: null
---
In this topic you will learn how to create OpenShift resource objects using the `oc create` command.

The `oc create` command provides a generic way to create a resource object from a definition written in a JSON or YAML file. Also you can use `oc create` with a variety of command line options to configure and create resource objects directly in a terminal.

For example, you can create a secure route for the application that has a custom host name by defining the particulars of the resource object in a JSON file.

Let's create a file named `parksmap-fqdn.json` that describes a `route` resource. Then, after the JSON file is created, you'll create the `route` resource by executing the command, `oc create -f parksmap-fqdn.json`.

# Creating a resource object using a configuration file

`Step 1:` Run the following command to create the JSON file, named `parksmap-fqdn.json`:

```
cat << EOF > parksmap-fqdn.json
{
    "kind": "Route",
    "apiVersion": "v1",
    "metadata": {
        "name": "parksmap-fqdn",
        "labels": {
            "app": "parksmap"
        }
    },
    "spec": {
        "host": "www.example.com",
        "to": {
            "kind": "Service",
            "name": "parksmap",
            "weight": 100
        },
        "port": {
            "targetPort": "8080-tcp"
        },
        "tls": {
            "termination": "edge",
            "insecureEdgeTerminationPolicy": "Allow"
        }
    }
}
EOF
```

----

`Step 2:` Run the following command to verify that the file `parksmap-fqdn.json` has been saved to disk:

```
ls -lh parksmap-fqdn.json
```

You get output similar to the following:

```
rw-r--r-- 1 root root 519 Mar 22 21:49 parksmap-fqdn.json
```

----

`Step 3:` Run the following command to create the OpenShift `route` resource named `parksmap-fqdn`:

```
oc create -f parksmap-fqdn.json
```

You'll get output similar to the following:

```
Using non-groupfied API resources is deprecated and will be removed in a future release, update apiVersion to "route.openshift.io/v1" for your resource.
route.route.openshift.io/parksmap-fqdn created
```

|NOTE:|
|----|
|The `Using non-groupfied API resources...` deprecation warning shown in the output above is advising developers to upgrade the manifest file to a new version of the `route` resource. It is not fatal. The code will work fine as is.|

The route as defined as the JSON file above has a unique value for `route.metadata.name` which is `parksmap-fqdn`.

----

`Step 4:` Run the following command in the terminal window to the left.

```
oc get routes
```

You get results as follows:

```
NAME            HOST/PORT                                                            PATH   SERVICES   PORT       TERMINATION   WILDCARD
parksmap        parksmap-myproject.crc-lgph7-master-0.crc.dlzdxnbljgoz.instruqt.io          parksmap   8080-tcp                 None
parksmap-fqdn   www.example.com                                                             parksmap   8080-tcp   edge/Allow    None                                                      parksmap   8080-tcp   edge/Allow    None
```

Notice in the response above that there are two routes defined. One has the name `parksmap`. The other has the name `parksmap-fqdn`. The name `parksmap-fqdn` was created by running `oc create` against the JSON file.

# Creating a resource object using command line options

The `oc create` command provides a subcommand specifically for creating a route at the command line as you'll see when you run the command that follows.

----

`Step 5:` Run the following command to create a route using only information in the command line:

```
oc create route edge parksmap-fqdn2 --service parksmap --insecure-policy Allow --hostname www.otherexample.com
```

You'll get output similar to the following:

```
route.route.openshift.io/parksmap-fqdn2 created
```

----

`Step 6:` Now run the following command to get a list of routes in the cluster:

```
oc get routes
```

You'll get output similar to the following:

```
NAME             HOST/PORT                                                            PATH   SERVICES   PORT       TERMINATION   WILDCARD
parksmap         parksmap-myproject.crc-lgph7-master-0.crc.xdos3cn6o5qf.instruqt.io          parksmap   8080-tcp                 None
parksmap-fqdn    www.example.com                                                             parksmap   8080-tcp   edge/Allow    None
parksmap-fqdn2   www.otherexample.com                                                        parksmap   8080-tcp   edge/Allow    None
```

# Congratulations!

 You've just created an OpenShift `route` resource using the `oc` command line tool.

----

**NEXT:** Replacing resource objects
