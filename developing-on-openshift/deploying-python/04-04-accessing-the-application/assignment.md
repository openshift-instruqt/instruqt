---
slug: 04-accessing-the-application
id: sykwwmausfyc
type: challenge
title: Topic 4 - Accessing the application using the Web Console
notes:
- type: text
  contents: Topic 4 - Accessing the application using the Web Console
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 300
---
In the previous topics, you built and deployed the Python application. In this topic you will open the application in a web browser from the Topology page using the **Route** assigned by OpenShift.

----

`Step 1:`Click the **Web Console** tab from the horizontal menu bar over the terminal to the left to open the OpenShift web console.

Click on **Topology** button in the left hand menu bar to return to the topology view for the project.

![Topology View](../assets/topology.png)

As you read in a previous topic, when you created the application using the web console, an OpenShift `route` was automatically created for the application. The `route` exposed the application outside of the cluster to the Internet. You'll use the `route`'s URL created by OpenShift to access the application from a web browser window.

----

`Step 2a:` Click on the icon at the top right of the ring in the application visualization as shown in the figure below to quickly access the URL for the deployed application in the Topology view.

![App Running](../assets/app-running.png)

Make sure the ring surrounding the Python logo is dark blue.

`Step 2b:` Click on the Open URL icon as shown in the figure above.

Clicking the icon will open a new tab in your browser that displays a blog web site page as shown in the figure below.

![Blog Web Site](../assets/blog-web-page.png)

This web site is driven by the Python application you built from the source code in GitHub and deployed using the OpenShift web console.

# Congratulations!

You've successfully built and deployed an application from source code using the OpenShift web console.

----
**NEXT:** Deleting the deployment from the command line using the OpenShift CLI Tool

