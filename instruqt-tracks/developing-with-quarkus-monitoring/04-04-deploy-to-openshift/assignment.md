---
slug: 04-deploy-to-openshift
id: z1kaw1eyx5zb
type: challenge
title: Topic 4 - Integrating Prometheus with OpenShift
notes:
- type: text
  contents: Topic 4 - Integrating Prometheus with OpenShift
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/quarkus/primes
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 200
---
Now that you have the demonstration application built, let's move it into containers that run on the OpenShift cluster. Once the application is deployed to OpenShift cluster, Prometheus can scrape data as the application runs.

Quarkus has the ability to automatically generate OpenShift resources based on default and user supplied configurations. The OpenShift extension is actually a wrapper extension that brings together the [Kubernetes](https://quarkus.io/guides/deploying-to-kubernetes) and [container-image-s2i](https://developers.redhat.com/articles/2021/05/31/learn-quarkus-faster-quick-starts-developer-sandbox-red-hat-openshift) extensions, making it easier for developers to get started with Quarkus on OpenShift.

In this topic, you will add the Maven OpenShift extension to integrate the demonstration application with OpenShift. Then, you'll append the `application.properties` file to add Kubernetes integration configuration to the demonstration application. Finally, you'll exercise a route that represents the demonstration application's RESTful endpoints in the OpenShift cluster.å

# Installing the OpenShift extension

`Step 1:` Run the following command in **Terminal 1** to add the demonstration application to the OpenShift project:

```
mvn quarkus:add-extension -Dextensions="openshift" -f /root/projects/quarkus/primes
```

You'll see output similar to the following:
```
[INFO] Scanning for projects...
[INFO]
[INFO] --------------------------< org.acme:primes >---------------------------
[INFO] Building primes 1.0.0-SNAPSHOT
[INFO] --------------------------------[ jar ]---------------------------------
[INFO]
[INFO] --- quarkus-maven-plugin:2.0.0.Final:add-extension (default-cli) @ primes ---
[INFO] [SUCCESS] ?  Extension io.quarkus:quarkus-openshift has been installed
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  2.320 s
[INFO] Finished at: 2022-04-25T23:53:20Z
[INFO] ------------------------------------------------------------------------
```

----

`Step 2a:` Using the **Visual Editor**, navigate to the directory `primes/src/main/resources/`.

`Step 2b:` Click the `application.properties` file to open it for editing and append the following lines of code the end of the file:

```text
# Configure the OpenShift extension options
quarkus.kubernetes-client.trust-certs=true
quarkus.container-image.build=true
quarkus.kubernetes.deploy=true
quarkus.kubernetes.deployment-target=openshift
quarkus.openshift.expose=true
quarkus.openshift.labels.app.openshift.io/runtime=quarkus
```

`Step 2c:` Click on the `Disk` icon or press the `CTRL+S` keys to save the `application.properties` file.

**KEY POINTS TO UNDERSTAND**

* `quarkus.kubernetes-client.trust-certs=true` - Indicates that the application is using self-signed certificates and that Quarkus should trust them.
* `quarkus.container-image.build=true` - Indicates that the extension is to build a container image.
* `quarkus.kubernetes.deploy=true` - Indicates that the extension will deploy the application container to OpenShift after the container image is built.
* `quarkus.kubernetes.deployment-target=openshift` - Indicates that the extension is to generate and create the OpenShift resources (such as `DeploymentConfig`s and `Service`s) after building the container.
* `quarkus.openshift.route.expose=true` - Indicates that the extension is to generate an OpenShift `Route`.
* `quarkus.openshift.labels.app.openshift.io/runtime=quarkus` - Adds a nice-looking icon to the app when viewing the OpenShift Developer Topology.

# Deploying the demonstration application to OpenShift

Next, let's deploy the application itself.

----

`Step 3:` Run the following command in **Terminal 1** to build and deploy the demonstration application using the OpenShift extension:

```
mvn clean package -DskipTests -f /root/projects/quarkus/primes
```

|NOTE:|
|----|
| This command will take a minute or two to execute because it builds the app, pushes a container image, and finally deploys the container to OpenShift.|

You'll see a lot of screen output. Finally, you'll see the following output when the process finishes:

```console
[INFO] [io.quarkus.deployment.QuarkusAugmentor] Quarkus augmentation completed in 33188ms
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
```

----

`Step 4:` Run the following command in **Terminal 1** to make sure the application is actually done rolling out:

```
oc rollout status -w dc/primes
```

There may be some delay when confirming the rollout. Eventually you will see a rollout success message as shown below:

```
Waiting for rollout to finish: 0 of 1 updated replicas are available...
Waiting for latest deployment config spec to be observed by the controller loop...
replication controller "primes-1" successfully rolled out
```

# Viewing the demonstration application in the OpenShift web console

Next, you'll view the demonstration application in the OpenShift web console.

----

`Step 5:` Click on **Web Console** tab on the horizontal menu bar on top of the terminal console to the left.

You will be presented with the OpenShift Web Console login screen in a new browser tab.

|NOTE:|
|----|
|You might see the following warning notification due to using an untrusted security certificate.
![Security warning](../assets/security_warning.png)
If you do get the warning, click the **Advanced** button to complete the process necessary to grant permission to the browser to access the OpenShift web console.|

----

`Step 6:` Log into OpeShift from the web console using the following credentials:

* Username: `developer`
* Password: `developer`

----

`Step 7a:` Using the web console, go to the `Topology` view in the **Developer** perspective as shown in the figure below.

![Select Topology](../assets/select-topology.png)

`Step 7b:` Select the `quarkus` listing in the project page that appears, as shown in the figure above.

You'll see two circular graphics. One circle represents the demonstration application, named `primes`, that's running in the OpenShift cluster. The other circular graphic represents Prometheus, which is also running in the OpenShift cluster.

Now that both the demonstration application and Prometheus are up and running, you can use `curl` once again to exercise the prime service running on OpenShift.

----

`Step 8:` Run the following command in **Terminal 1** to execute `curl` from the command line using the OpenShift route to the demonstration application. You'll exercise the route to determine if the number `1` is a prime number:

```
curl `oc get route primes -n quarkus -o jsonpath='{"http://"}{.spec.host}{"/is-prime/1"}'`
```

You'll see the following output:

```
1 is not prime.
```

----

`Step 9:` Run the following command in **Terminal 1** to execute `curl` from the command line to determine if the number `350` is a prime number:

```
curl `oc get route primes -n quarkus -o jsonpath='{"http://"}{.spec.host}{"/is-prime/350"}'`
```

You'll see the following output:

```
350 is not prime, it is divisible by 2.
```

----

`Step 10:` Run the following command in **Terminal 1** to execute `curl` from the command line to determine if the number `629521085409773` is a prime number:

```
curl `oc get route primes -n quarkus -o jsonpath='{"http://"}{.spec.host}{"/is-prime/629521085409773"}'`
```

You'll see the following output:

```
629521085409773 is prime.
```

# Congratulations!

You added the Maven OpenShift extension to integrate the demonstration application. You appended the `application.properties` file with the additional Kubernetes integration configuration settings. Finally, you exercised the demonstration application's RESTful endpoints in the OpenShift cluster.

Now that the demonstration application is rolled out and running in OpenShift, Prometheus has started collecting performance metrics. You'll take a look at the metrics in the next topic.

----

**NEXT:** Monitoring application behavior with Prometheus
