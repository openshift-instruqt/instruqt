---
slug: 02-deploying-using-the-web-console
id: txxiaagm0ffb
type: challenge
title: Topic 2 - Deploying an Application from a Container Image Using the Web Console
notes:
- type: text
  contents: Deploying an Application from a Container Image Using the Web Console
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-gh9wd-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 500
---
In this topic you will learn how to use the web console to identify a container image in an external container image registry. Then you will use that container image to create an application that runs in the project named `myproject`. The application you'll run is a simple blog web site.

----

`Step 1:` Go back to the project page for `myproject` in the web console and click the **Add+** button on the menu bar on the left.

----

`Step 2:` Scroll down the **Add** page until you get to the text block labeled **Container images**.

----

`Step 3:`  Click the label **Container images** as shown in the figure below.

![Select container](../assets/select-container-with-code.png)


You'll be presented with the **Deploy Image** page as shown in the figure below.

![Deploy Image](../assets/deploy-container.png)

----

`Step 4:`  Enter the text below in the textbox labeled **Image name from external registry**:

```
quay.io/openshiftroadshow/parksmap:latest
```

The text above describes the container image that will be used for the application you're adding. In this case you are adding the ParksMap container image that is stored on the container registry `Quay.io` as shown in the figure below.

![Container image definition](../assets/config-image-00.png)

Once you enter the location of the container image in the text box above, OpenShift will fill in the configuration details automatically. The figure below shows how configuration information is automatically entered for the **General** section.

![Container image definition General](../assets/config-image-01.png)

 The figure below shows how configuration information is automatically entered for the **Resources** section.

 ![Container image definition Adv](../assets/config-image-02.png)

The final section titled **Advanced options**, which you'll see in a moment, has a checkbox that when selected will have OpenShift automatically create a `route` resource object to the application.

A `route` resource object publishes a URL that enables public access to the ParksMap application on the Internet.

The checkbox is selected automatically by OpenShift when adding the container image.

----

`Step 5:` Click the button labeled **Create** at the bottom of the **Add** page as shown in the figure below:

![Save Image](../assets/save-image-config.png)

After you save the container image, OpenShift will do the work of creating the application automatically.

The **Add+** page will close.

Then you'll see the **Topology** page with a circular graphic appear as shown in the figure below.

![Topology View](../assets/topology-view-with-app.png)

This circular graphic represents the ParksMap application.

# Congratulations!

You've just added a container image to the the project named `myproject`.

----

**NEXT:** Exploring the Topology view