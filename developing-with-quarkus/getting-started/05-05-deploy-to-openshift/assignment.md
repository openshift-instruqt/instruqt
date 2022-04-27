---
slug: 05-deploy-to-openshift
id: uoh2haev5nau
type: challenge
title: Topic 5 - Moving the container to the cloud
teaser: Topic 5 - Moving the container to the cloud
notes:
- type: text
  contents: Topic 5 - Moving the container to the cloud
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
- title: Terminal 2
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-dzk9v-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 5001
---
Now that we have the demonstration application built, let's move it into Linux a container and then on into the cloud.

# Installing the OpenShift extension

Quarkus offers the capability to automatically generate OpenShift resources based on both default and user supplied configuration settings. The OpenShift extension is actually a wrapper extension that brings together the [kubernetes](https://quarkus.io/guides/deploying-to-kubernetes) and [container-image-s2i](https://quarkus.io/guides/container-image#s2i) extensions. The default behavior that comes with the extension makes it’s easier for the user to get started with Quarkus on OpenShift.

----

`Step 1:` Run the following command in **Terminal 1** to add the OpenShift extension to the demonstration project

```bash
mvn quarkus:add-extension -Dextensions="openshift" -f /root/projects/quarkus/getting-started
```

You'll get output similar to the following:

```
[INFO] Scanning for projects...
[INFO]
[INFO] ----------------------< org.acme:getting-started >----------------------
[INFO] Building getting-started 1.0.0-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- quarkus-maven-plugin:2.0.0.Final:add-extension (default-cli) @ getting-started ---
[INFO] [SUCCESS] ?  Extension io.quarkus:quarkus-openshift has been installed
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  2.749 s
[INFO] Finished at: 2022-04-04T15:27:24Z
[INFO] ------------------------------------------------------------------------
```

# Logging to the OpenShift Web Console

`Step 2:` Click the **OpenShift Web Console** tab on the horizontal menu bar over the terminal window.

When you go get to the **OpenShift Web Console** you'll be presented with a login page as shown in the figure below.

![Web Console](../assets/web-console-login.png)

----
`Step 3:`  Login to the **OpenShift Web Console** using the following credentials.

* Username: `developer`
* Password: `developer`

|NOTE:|
|----|
|You might see the following warning notification due to using an untrusted security certificate.
![Security warning](../assets/security_warning.png)
If you do get the warning, click the **Advanced** button to complete the process necessary to grant permission to the browser to access the OpenShift Web Console.|

----

`Step 4:` Run the following command in **Terminal 1** to log into OpenShift from the command line.


```
oc login -u developer -p developer
```

You will see the following output.

```console
Login successful.

You don't have any projects. You can try to create a new project, by running

    oc new-project <projectname>
```

# Creating a project from the command line using `oc`

For this scenario, let's create a project that you'll use to host your application.

`Step 5:` Run the following command to create a new Quarkus project with the display name, `Sample Quarkus App`.

```
oc new-project quarkus --display-name="Sample Quarkus App"
```

You'll get output similar to the following:

```
Now using project "quarkus" on server "https://api.crc.testing:6443".

You can add applications to this project with the 'new-app' command. For example, try:

    oc new-app rails-postgresql-example

to build a new example application in Ruby. Or use kubectl to deploy a simple Kubernetes application:

    kubectl create deployment hello-node --image=k8s.gcr.io/serve_hostname
```

You now have a project to host the application. Next you need to deploy the application.

# Deploying the application to OpenShift


`Step 6:` Run the following command in **Terminal 1** to build and deploy a Quarkus native application:

```
mvn clean package -Pnative -f /root/projects/quarkus/getting-started \
-Dquarkus.kubernetes-client.trust-certs=true \
-Dquarkus.container-image.build=true \
-Dquarkus.kubernetes.deploy=true \
-Dquarkus.kubernetes.deployment-target=openshift \
-Dquarkus.openshift.expose=true \
-Dquarkus.openshift.labels.app.openshift.io/runtime=quarkus
```

**WHERE:**

* `quarkus.kubernetes-client.trust-certs=true` - Indicates that you are using self-signed certificates in this simple example, telling the extension to trust them.
* `quarkus.container-image.build=true` - Indicates that the extension is to build a container image
* `quarkus.kubernetes.deploy=true` - Indicates that the extension is to deploy to OpenShift after the container image is built
* `quarkus.kubernetes.deployment-target=openshift` - Indicates that the extension will generate and create the OpenShift resources such as `DeploymentConfig`s and `Service`s after building the container
* `quarkus.openshift.expose=true` - Indicates that the extension to generate an OpenShift `Route`.
* `quarkus.openshift.labels.app.openshift.io/runtime=quarkus` - Adds a nice-looking icon to the app when viewing the OpenShift Developer Topology

This step will take a few minutes to complete because it rebuilds the native executable, generates a container image and pushes it into OpenShift.

You get a lot of screen output during the execution of the step.

You'll see the following output at the end of the process.

```console
[INFO] [io.quarkus.deployment.QuarkusAugmentor] Quarkus augmentation completed in 139662ms
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  02:34 min
[INFO] Finished at: 2022-04-01T23:18:44Z
[INFO] ------------------------------------------------------------------------
```

----

`Step 7:` Run the following command in **Terminal 1** to ensure that the application is actually done rolling out.

```
oc rollout status -w dc/getting-started
```

You'll get output similar to the following:

```
Waiting for rollout to finish: 0 of 1 updated replicas are available...
Waiting for latest deployment config spec to be observed by the controller loop...
replication controller "getting-started-1" successfully rolled out
```

Wait for that command to report the following before continuing.

```
replication controller "getting-started-1" successfully rolled out`
```


The application is now deployed and running in OpenShift. You can now view it in the **OpenShift Web Console**.

----

`Step 8a:` Click the **Web Console** tab on the horizontal menu bar over the terminal window to the left.

`Step 8b:` Click the **Topology** tab on the left side of the web console as shown in the figure below:

![Show Application in Topology view](../assets/show-app-in-topology.png)

`Step 8c:` Click the **quarkus** link in the Topology view's Project page as shown in the figure above. A circular graphic will appear. This graphic represents the Getting Started application.

----

You can access the application using `curl` once again.

`Step 9:` Run the following command in **Terminal 1** to get the URL to the applications endpoint and assign it to the environment variable named `APP_ROUTE`.

```bash
APP_ROUTE=`oc get route getting-started -n quarkus -o jsonpath='{"http://"}{.spec.host}{"/hello/greeting/quarkus-on-openshift"}{"\n"}'`
```

----
`Step 10` Run the following command in **Terminal 1** to exercise the application's endpoint `/hello/greeting/quarkus-on-openshift`:

```
curl $APP_ROUTE
```

You will see the following output:

```console
hello quarkus-on-openshift
```

# Congratulations!

This step covered the deployment of a Quarkus application on OpenShift. However, there is much more to learn. Integrating Quarkus into OpenShift and the web console has been tailored to make Quarkus applications execute very smooth. For instance, the health extension can be used to perform a [health check](https://docs.openshift.com/container-platform/4.6/applications/application-health.html) on the application; the metric extension produces data that scrape-able by [Prometheus](https://prometheus.io/).

In the next topic you'll move to on to scaling and try a few things.

----
**NEXT:** Scaling Quarkus

