---
slug: 06-scaling
id: imwwvqx2yk3u
type: challenge
title: Topic 6 - Scaling Quarkus
teaser: Topic 6 - Scaling Quarkus
notes:
- type: text
  contents: Topic 6 - Scaling Quarkus
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
- title: OpenShift Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 800
---
Now that we have our app running on OpenShift, let's see what we can do.

In this topic you're going to scale the number of pods that support the demonstration application.

But, before you start scaling up, you need put a restriction on the amount of memory the application can consume within the OpenShift cluster.

# Implementing a resource constraint to restrict memory usage

Let's make **sure** that the Quarkus app doesn't go beyond using a reasonable amount of memory for each underlying pod. You'll restrict memory consumption by setting memory resource constraints on the application.

You're going to make 50 MB of memory as an upper memory limit. (For what it's worth, a 50 MB memory limit is pretty thin compared to the average Java app.). A 50 MB limit will support scaling up the application quite a bit.

----

`Step 1:` Run the following command in **Terminal 1** to set the 50 MB memory limit.

```
oc set resources dc/getting-started --limits=memory=50Mi
```

You'll get the following output:

```
deploymentconfig.apps.openshift.io/getting-started resource requirements updated
```

# Scaling the app

Now that the memory limit is set, let's see how fast the app can scale up to 10 instances:

----

`Step 2:` Run the following `oc scale` command in **Terminal 1** to scale the demonstration application up to 10 pods.

```
oc scale --replicas=10 dc/getting-started
```

You'll get output similar to the following:

```
0402 00:36:04.661086  484962 warnings.go:70] extensions/v1beta1 Scale is deprecated in v1.2+, unavailable in v1.16+
deploymentconfig.apps.openshift.io/getting-started scaled
```

|BE ADVISED:|
|----|
|You can ignore the warning message, `W1123 19:23:34.344132  306042 warnings.go:70] extensions/v1beta1 Scale is deprecated in v1.2+, unavailable in v1.16+_`.|

----

`Step 3:` Click the **OpenShift Web Console** tab on the horizontal menu bar over the terminal window to the left to return to the Web Console web page.

----

`Step 4:` Click the **Topology** tab on the menu to the left of the **OpenShift Web Console**.

----

`Step 5:` Click the **quarkus** link in the project list of the web page as shown in the figure below.

![Select Topology](..\assets\select-topology.png)

You'll be presented with the application web page. You'll see a circular graphic that represents the Getting Started application running in OpenShift.

----

`Step 6:`  Click the circular graphic in the **quarkus/Sample Quarkus App** web page. The application overview pane will slide out from the right side as shown in the figure below.

![App Topology Information](..\assets\app-top-detail-01.png)

----

`Step 7:` Click the **Details** tab application information pane as shown in the figure below.

![App Pod Information](..\assets\app-top-detail-02.png)

Notice that the **Details** graphic shows see the app scaling dynamically up to 10 pods:

# Increasing the load

`Step 7:` Run the following command in **Terminal 1** to get the route to Getting Started app and assign it to the environment variable `APP_ROUTE`.

```
export APP_ROUTE=`oc get route getting-started -n quarkus -o jsonpath='{"http://"}{.spec.host}{"/hello/greeting/quarkus-on-openshift"}{"\n"}'`
```

----

`Step 8:` Run the following command in **Terminal 1**  to make 10 calls to the Getting Started App using `curl`.

```
for i in {1..10} ; do curl $APP_ROUTE; sleep .05 ; done
```

You will see the 10 instances of the Quarkus app being load-balanced and responding evenly as shown in the following snippet of output:

```console
hello quarkus-on-openshift
hello quarkus-on-openshift
hello quarkus-on-openshift
hello quarkus-on-openshift
...
```

|LEARN MORE ABOUT LOAD BALANCING|
|----|
|For more fun with load balancing and apps, checkout the [Red Hat Developer Istio Tutorial](https://bit.ly/istio-tutorial) and learn how to control scaling with greater precision and flexibility!|

10 not enough? Let's try 50 replicas:

----
`Step 8:` Run the following command in **Terminal 1**  to have OpenShift scale up the number of pods running for the Getting Started app to 50.

```
oc scale --replicas=50 dc/getting-started
```

----

`Step 9:` Go back to the **OpenShift Web Console and look at the *Details** pane of the Getting Started App as shown in the figure below.

![Scale to 50](..\assets\scale-up-to-50.png)

You'll see the app scaling dynamically up to 50 pods.


----

`Step 10:` Once the number of pods is scaled up to 50 in OpenShift Web Console, go back to **Terminal 1** and run the following command:

```
for i in {1..50} ; do curl $APP_ROUTE; sleep .05 ; done
```

All 50 pods are responding evenly to requests.

Try doing this degree of dynamic scaling with your average Java app running!

This tutorial uses a single node OpenShift cluster, but in practice you'll have clusters with many more nodes. OpenShift allows you to easily scale to hundreds or thousands of replicas if and when load goes way up.

`Step 11:` Run the following command in **Terminal 1** to scale the number of pods in the Getting Started app to 100.

```
oc scale --replicas=100 dc/getting-started
```

`Step 12:` Go back to the OpenShift Web Console web page. Notice that OpenShift is dynamically scaling the Getting Started application to 100 pods as shown in the figure below.

![Scale to 100](..\assets\scale-up-to-100.png)

It may take a bit of time for all 100 pods to spin up given this limited resource environment, but they will eventually!

# Working with the solution in an IDE in the Cloud!
Want to continue exploring this solution on your own in the cloud?

You can use the free [Red Hat OpenShift Dev Spaces](https://developers.redhat.com/products/openshift-dev-spaces/overview) IDE running on the free [Red Hat Developer Sandbox](http://red.ht/dev-sandbox). [Click here](https://workspaces.openshift.com) to login or to register if you are a new user. This free service expires after 30 days, but you can always enable a new free 30-day subscription.

Once logged in, [click here](https://workspaces.openshift.com/f?url=https://raw.githubusercontent.com/openshift-katacoda/rhoar-getting-started/solution/quarkus/getting-started/devfile.yaml) to open the solution for this project in the cloud IDE. While loading, if it asks you to update or install any plugins, you can say no.

# Congratulations

This is the final topic in this track.

In this track you got a glimpse of the power of Quarkus apps using traditional JVM-based builds as well as native builds.

There is much more to Quarkus than fast startup times and low resource usage. You can use [Red Hat CodeReady Workspaces](https://developers.redhat.com/products/codeready-workspaces/overview) and other resources on Red Ht learn more.

Also, be sure to visit [quarkus.io](https://quarkus.io) to learn even more about the architecture and capabilities of Quarkus, an exciting new framework for Java developers.

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
