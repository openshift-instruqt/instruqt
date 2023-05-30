---
slug: 07verify-deployment
id: lmomvnxbwzbu
type: challenge
title: Step 7 - Verify Deployment
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 500
---
To verify a successful deployment for our application, head back out to the web console by clicking on the Console at the center top of the workshop in your browser.

Click on the Topology tab on the left side of the web console. You should see something similar to what is shown in the screenshot below:

![Web Console Deployed](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/application-deployed.png)

The Topology view of the OpenShift web console helps to show what is deployed out to your OpenShift project visually. As mentioned earlier, the dark blue lining around the _ui_ circle means that a container has started up and running the _api_ application. By clicking on the arrow icon as shown below, you can open the URL for _ui_ in a new tab and see the application running.

![Web Console URL Icon](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/url-icon.png)

After clicking on the icon, you should see the application running in a new tab.

## Accessing application via CLI

In addition, you can get the route of the application by executing the following command to access the application.

```
oc get route pipelines-vote-ui --template='http://{{.spec.host}}'
```

Congratulations! You have successfully deployed your first application using OpenShift Pipelines.

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!