---
slug: 01-install-operator
id: qxqnd1hrudvg
type: challenge
title: Step 1 - Install the Pipelines Operator
notes:
- type: text
  contents: "\U0001F4BE Install the Pipelines Operator\n=============================\n\nLearn
    how to install the OpenShift Pipelines operator"
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 500
---
❓ What's OpenShift Pipelines?
===============================

[OpenShift Pipelines](https://docs.openshift.com/container-platform/latest/cicd/pipelines/understanding-openshift-pipelines.html) are an OpenShift add-on that can be installed via an operator that is available in the OpenShift OperatorHub. It allows for cloud-native, continuous integration and delivery (CI/CD) solution for building pipelines using [Tekton](https://tekton.dev/).

Let's install the operator using the OpenShift Pipelines Operator in the OpenShift Web Console!

🔒 Logging in with the Web Console
===============================

Click the **Web Console** tab over the terminal area to open the OpenShift web console in a new tab.

![Web Console Login](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/web-console-login.png)

1. Use the following credentials to log in:

* **Username:** `admin`
* **Password:** `admin`

👀 Changing perspectives
========================

Upon logging in, you'll notice in the top left that you're in the **Administrator** perspective:

![Admin Perspective](../assets/admin-perspective.png)

Change the to the **Developer** perspective by selecting **Administrator** and opening the following drop down menu:

![Switch to Developer](../assets/change-to-developer.png)

💾 Installing the OpenShift Pipelines Operator
===============================
In the _Administrator_ perspective of the web console, navigate to **Operators → OperatorHub**. You can see the list of available operators for OpenShift provided by Red Hat as well as a community of partners and open-source projects.

1. Search for `Red Hat OpenShift Pipelines` in the catalog. Click the _Red Hat OpenShift Pipelines_ tile.

![Web Console Hub](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/web-console-hub.png)

2. Feel free to leave the default options selected and click _Install_.

![Web Console Login](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/web-console-settings.png)

3. The installation may take a minute or two, but once complete, you'll now have installed the *OpenShift Pipelines Operator* to your OpenShift Cluster!

Now, let's start the workshop. In the next section, you'll learn about how to run tasks ⬇️
