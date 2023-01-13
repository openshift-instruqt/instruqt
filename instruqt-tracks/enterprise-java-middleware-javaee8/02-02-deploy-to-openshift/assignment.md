---
slug: 02-deploy-to-openshift
id: t9n7eg5rax7a
type: challenge
title: Deploy to OpenShift
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/javaee/weather-app/
- title: OpenShift Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: intermediate
timelimit: 600
---
# Deploy to OpenShift

An appropriate Java runtime has been installed for you for building the app. Ensure you can use it by running this command in Terminal 1:

> If the command fails, wait a few moments and try again (it is installed in a background process and make take a few moments depending on system load).

```
$JAVA_HOME/bin/java --version
```

The command should report the version in use, for example (the versions and dates may be slightly different than the below example):

```console
openjdk 11 2018-09-25
OpenJDK Runtime Environment 18.9 (build 11+28)
OpenJDK 64-Bit Server VM 18.9 (build 11+28, mixed mode)
```

**Red Hat OpenShift Container Platform** is the preferred cloud runtime for JBoss EAP
OpenShift Container Platform is based on **Kubernetes** which is the most used Orchestration for containers running in production. We assume you understand the basics of OpenShift, if not, please complete [Introduction to OpenShift]( https://learn.openshift.com/introduction/) course and come back here.

**1. Login to OpenShift Container Platform**

To authenticate to the OpenShift Container Platform, we will use the **oc** command and then specify the server that we
want to authenticate to:

```
oc login -u developer -p developer
```

Congratulations, you are now authenticated to the OpenShift server.

**2. Create project**

For this scenario, you will build a REST service that manages products that we deploy on OpenShift.

```
oc new-project my-project --display-name="Weather App"
```

**3. Login to OpenShift**

Click on `OpenShift Web Console` tab then, login using the following credentials from the Web using.

*Note* that you might see *Your connection is not private* notification due to using an untrusted security certificate. Then, proceed to access the OpenShift web console via clicking *Advanced* option.

* Username:
```
developer
```

* Password:
```
developer
```

After you have authenticated to the web console, click **Skip Tour** to bypass the initial new user tour (feel free to visit it later on). After that, you will be on the initial screen listing the projects you're able to work with, including your newly created _my-project_.

![EAP Logo](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-javaee8/projects.png)

Click on your new project name to be taken to the project topology page which will initially be empty ("No resources found") but that's about to change.

Now that you've logged into OpenShift, let's deploy a single JBoss EAP instance. The deployed JBoss EAP instance will in this step not be connected to a database, but we will see an example of that in a later scenario.

**3. Deploy JBoss EAP image**

To deploy our application we first have to create a container. JBoss EAP comes with a S2I image that packages all the binaries that are needed at runtime. S2I stands for Source-To-Image and is a convenient way for developers to provide either an artifact (E.g. WAR, JAR, etc) or the source code directly and OpenShift will then build a container image for you, so there is no need to have a local container build system and as a developer you do not have to care about patching and maintaining the base image.

We will use the following command to create a build configuration in OpenShift:

```
oc new-build jboss-eap73-openjdk11-openshift:7.3 --binary=true --name=weather-app
```

This command tells openshift to use a base image including JBoss EAP 7.3 with the name `weather-app`  and finally, we tell it to use what is called binary deployment. Binary deployment means that we will build the Java artifacts locally (using maven) and let the S2I process build a container where that artifact is deployed in JBoss EAP.

Now, build the application by executing the following maven command.

```
mvn clean package -f /root/projects/rhoar-getting-started/javaee/weather-app
```

We are now ready to upload our artifact (a WAR file) to the build "weather-app" process that we created earlier.

```
oc start-build weather-app --from-file=/root/projects/rhoar-getting-started/javaee/weather-app/target/ROOT.war --follow
```

This command will upload the artifact to the build config that we created before and start building a container. Please note that this might take a while the first time you execute it since openshift will have to download the EAP image. Next time it will go much faster.

When the build is finished, we are ready to create your application.

```
oc new-app weather-app -l app.openshift.io/runtime=jboss
```

The command new-app will create a running instance based on the container that we built before, and a label `-l` that gives it a nice icon on the topology view.

Go back to the [Topology view](https://console-openshift-console-[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com/topology/ns/my-project/graph) and verify that the application comes up correctly (look for the dark blue circle):

![EAP Logo](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-javaee8/initial-deploy.png)

**4. Expose service route**

Now that our application is running in a container we also have to expose the application to be accessed outside the internal OpenShift network. For that we need to create a route that will forward traffic ffrom the external OpenShift router to our service.

Let's do that next.

```
oc expose svc weather-app
```

You'll notice a new route link icon on the topology view. Click it to access the app:

![EAP Logo](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-javaee8/route-link.png)

You should see the app running:

![EAP Logo](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-javaee8/initial-app.png)

You won't yet be able to select different country flags (you'll get an error popup) - this we will fix in the next step.
