---
slug: login
id: x56duudvrnyi
type: challenge
title: Step 1 - Login to OpenShift
notes:
- type: text
  contents: In this step you will learn how to connect to OpenShift
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 300
---
# Working with the Command Line Interface (CLI)

Let's begin by connecting to OpenShift.

From *Terminal 1*, run the following command to login with the OpenShift CLI:

```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

You should see:

```bash
Login successful.
You don't have any projects. You can try to create a new project, by running `oc new-project <projectname>`
```

Congratulations, you are now authenticated to the OpenShift cluster.

Access the OpenShift Web Console to login from the Web UI:

```
oc get routes console -n openshift-console -o jsonpath='{"https://"}{.spec.host}{"\n"}'
```

Copy the URL from the output of the above command and open it in your browser.

We'll deploy our app as the `admin` user. Use the following credentials:

* Username:
```
admin
```
* Password:
```
admin
```