---
slug: explore-console
id: pfx4gogkjlqi
type: challenge
title: Step 2 - Exploring The Web Console
notes:
- type: text
  contents: Exploring the OpenShift Web Console
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 800
---
This topic focuses on learning how to log into the Red Hat OpenShift web console and then create an application once logged in.

# Logging in with the web console

Your first task is to log into OpenShift from the web console.

----

`Step 1:`
Click the **Web Console** tab from the horizontal menu bar over the terminal to the left to open the OpenShift web console.

You will be presented with the OpenShift login screen. Use the following credentials to log in.
* **Username:** `admin`
* **Password:** `admin`

Log into the OpenShift web console, as shown in the figure below.

![Web Console Login](../assets/web-console-login.png)

|NOTE:|
|----|
|You might see the following warning notification due to using an untrusted security certificate.
![Security warning](../assets/security_warning.png)
If you do get the warning, click the **Advanced** button to complete the process necessary to grant permission to the browser to access the OpenShift Web Console.|

After logging into the web console, take a look a the menu on the left. Notice that you're in the **Administrator** perspective, as shown in the figure below:

![Admin Perspective](../assets/admin-perspective.png)

You need to change the perspective from **Administrator** to **Developer**.

----

`Step 2:` Select the **Developer** perspective from the dropdown on the left side menu in the OpenShift web console as shown in the figure below.

![Switch to Developer](../assets/change-to-developer.png)

Now that you're in the **Developer** perspective, let's take a moment to discuss the concept of a **project** in OpenShift.

# Understanding projects in OpenShift

OpenShift is often referred to as a container application platform in that it's a platform designed for the development and deployment of applications in [Linux containers](https://developers.redhat.com/topics/containers).

OpenShift has an organizational unit named **project**. You use a **project** to group resources in your application. The reason for organizing your application in a **project** is to enable controlled access and quotas for developers or teams.

You can think of a **project** as a visualization of the Kubernetes namespace based on the developer access controls.

Now, let's create a project.

# Creating a project

In this section you will create a project using the OpenShift web console.

----

`Step 3:` Click the **Web Console** tab from the horizontal menu bar over the terminal to the left to open the OpenShift Web Console.

Click the button labeled **+Add** on the menu bar on the left side of the Web Console. The **Add** web page appears.

----

`Step 4:` Click the link with the text **Create a project** as shown in the figure below:

![Create project](../assets/add_project.png)

You'll be presented with the **Add Project** dialog for declaring the project.

----

`Step 5:` Name the project `myproject` as shown in the figure below:

![Name project](../assets/config-project.png)

----

`Step 6:` Then click the button labeled `Create` as shown in the figure above.

You will be presented with the **Add** page as shown in the figure below.

![Select container](../assets/select-container-with-code.png)

----

`Step 7:` Scroll down the page and click the text block labeled `Container images` as shown in the figure above.


You'll be presented with the **Deploy Image** page as shown in the figure below.

![Deploy Image](../assets/deploy-container.png)

----

`Step 8:` Enter the text below in the text box labeled **Image name from external registry**

```
quay.io/openshiftroadshow/parksmap:1.3.0
```

Adding content to the text boxes in the rest of the form is optional.

----

`Step 9:` Scroll down the page and click the button labeled `Create` to continue.

After you create the application, you will be presented with the **Topology** view as shown in the figure below.

You will spend most of your time in the remainder of this tutorial in that perspective.

![Topology View with App](../assets/topology-view-with-app.png)

You are now ready to scale the application up and down.

# Congratulations!

 You deployed an application from a container image using the OpenShift web console.

----
**NEXT:** Scaling your application
