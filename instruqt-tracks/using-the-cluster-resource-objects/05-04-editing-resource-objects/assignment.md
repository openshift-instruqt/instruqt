---
slug: 04-editing-resource-objects
id: klq90d5rqoyk
type: challenge
title: Topic 4 - Editing Resource Objects
notes:
- type: text
  contents: Editing Resource Objects
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
In this topic you're going to learn how to make changes to an existing resource object using the `oc edit` command.

When you execute `oc edit` OpenShift will use the `vi` editor that's built into the left side terminal by default. OpenShift will open the given file for a resource object in `vi` automatically.

When it comes time to save your changes and exit `vi` you will strike the `:wq` keys to save the file and exit. Or, you can use the `:q` command to just exit the file.

# Editing a resource object's details

`Step 1:` Run the following command to edit the details of the `route` object named `route/parksmap`.

```
oc edit route/parksmap
```

----

`Step 2:`  Now, enter `:q` to exit `vi`.

----

By default, when editing a definition, it will be displayed as YAML. To edit the definition as JSON add the ``-o json`` option to `oc edit`.

`Step 3:` Run the following command to edit the OpenShift resource `route/parksmap` in JSON.

```
oc edit route/parksmap -o json
```

----

`Step 4:`Now, enter `:q` to exit `vi`.

Any change you make to an OpenShift resource file will be automatically uploaded to the OpenShift cluster. The changes will replace the original definition.

OpenShift uses the declarative configuration model. the platform will then run any steps needed to bring the state of the cluster into agreement with the required state as defined by the resource object.

Be aware that not all fields of a resource object can be changed. Some fields are immutable. Others may represent the current state of the corresponding resource and any change will be overridden again with the current state.

# Congratulations!

 You've learned how to use the `oc edit` command to open a file for editing.

----

**NEXT:** Creating a resource object
