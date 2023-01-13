---
slug: 06-replacing-resource-objects
id: ebfyip5viy8f
type: challenge
title: Topic 6 - Replacing Resource Objects
notes:
- type: text
  contents: Replacing Resource Objects
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
In this topic, you will learn how to replace a particular OpenShift resource.

To change an existing resource according to a definition stored in a JSON or YAML file, use the `oc replace` command.

The following set of instructions will show you how to replace an OpenShift resource by executing `oc replace` against a JSON file. You'll also learn how to use the `oc patch` command to replace a resource directly from the command line.

# Replacing an OpenShift resource using a JSON file with `oc replace`

`Step 1:` Run the following `cat` command to create the file named `parksmap-fqdn.json`:

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
			"insecureEdgeTerminationPolicy": "Redirect"
		}
	}
}
EOF
```

----

`Step 2:` Run the following command to apply the contents of `parksmap-fqdn.json` in order to replace the route named `parksmap-fqdn`:

```
oc replace -f parksmap-fqdn.json
```

You'll get the following output:

```
route.route.openshift.io/parksmap-fqdn replaced
```

|NOTE:|
|----|
|In order for `oc replace` to alter the correct resource object, the `metadata.name` value in the JSON or YAML definition file must be the same name as the resource you intend to change.|

To change the value in an existing resource object using `oc replace`, you need to fetch the definition of the existing resource object using the command `oc get`. Then make the desired change and save it. Finally you use `oc replace` to replace the existing resource object with a new one that will be created using the changes you just made.

# Working with `oc patch`

An alternative way to update the route object is to use the `oc patch` command. For example you can use `oc patch` to edit the value of the attribute `route.spec.tls.insecureEdgeTerminationPolicy` with a new value, as you do in the following instruction.

----

`Step 3:` Run the following command to change the value of the attribute `route.spec.tls.insecureEdgeTerminationPolicy` to `true` in the `route` named `route/parksmap-fqdn`:

```
oc patch route/parksmap-fqdn --patch '{"spec":{"tls": {"insecureEdgeTerminationPolicy": "Allow"}}}'
```

You'll get the following output:

```
route.route.openshift.io/parksmap-fqdn patched
```

Be advised that whether you use `oc replace` or `oc patch`, the object you want to replace must already exist or the command you use will fail. If you do not know whether the resource object will already exist, and want it updated if it does, but created if it does not, instead of using `oc replace`, you can use `oc apply` like so:

```
oc apply -f <JSON_OR_YAML_FILE>
```

# Congratulations!

 You've just learned how to replace an existing OpenShift resource object using `oc replace` or `oc path`.

----

**NEXT:** Labelling resource objects
