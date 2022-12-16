---
slug: 02-deploy-to-openshift
id: 9cwxogkbpbsk
type: challenge
title: Step 2
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/spring-monitoring
- title: OpenShift Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 1000
---
# Deploy to OpenShift Application Platform
**1. Deploying the application to OpenShift**

Run the following command to login with the OpenShift CLI in Terminal 1:

```
oc login -u admin -p admin
```

You should see:

```bash
Login successful.
You don't have any projects. You can try to create a new project, by running `oc new-project <projectname>`
```

Let's create a project that you will use to house your applications.

```
oc new-project dev --display-name="Dev - Spring Boot App"
```

Run the following command to deploy the application to OpenShift in Terminal 1:

```
mvn package oc:deploy -Popenshift -DskipTests -f /root/projects/rhoar-getting-started/spring/spring-monitoring
```

This step may take some time to do the Maven build and the OpenShift deployment. After the build completes you can verify that everything is started by running the following command:

```
oc rollout status dc/spring-monitoring
```

**2. Using a Route to reach the application from the internet**

Now that our application is deployed to OpenShift, how do external users access it? The answer is with a **Route**. By using a route, we are able to expose our services and allow for external connections at a given hostname.

OpenShift ships with a web-based console that will allow users to perform various tasks via a browser.

Click on `OpenShift Web Console` tab then, login using the following credentials from the Web using.

*Note* that you might see *Your connection is not private* notification due to using an untrusted security certificate. Then, proceed to access the OpenShift web console via clicking *Advanced* option.

* Username:
```
admin
```

* Password:
```
admin
```

![Web Console Login](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/quarkus/login.png)

Run **Skip Tour** to skip the new user introduction.

Switch to `Developer Perspective` then click on `Topology` view in `Dev` project.
![Routes](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-monitoring/routes.png)

Access the application endpoint by adding `/fruits` to the route URL that you click on `Open UR` link.

We should now see the same `Success` page that we saw when we first tested our app locally:

![Success](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-monitoring/landingPage.png)

## Congratulations

You have now learned how to access the application via an external route. In our next step, we will navigate through OpenShift's web console in order to view our application and learn about health checks.