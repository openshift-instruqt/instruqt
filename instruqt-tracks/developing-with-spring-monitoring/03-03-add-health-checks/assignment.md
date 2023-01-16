---
slug: 03-add-health-checks
id: qcqjksliao7y
type: challenge
title: Step 3
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/spring-monitoring
difficulty: basic
timelimit: 1000
---
# Implementing Health Checks

Now that our project has been deployed to OpenShift and we've verified that we're able to hit our endpoint, it's time to add a health check to the application.

**1. View Health Checks**

Our application is now up and running on OpenShift and accessible to all users. However how do we handle an application failure? Without constantly manually veriifying the application there would be no way to know when the application crashes. Luckily OpenShift can handle this issue by using probes.

There are two types of probes that we can create; a `liveness probe` and a `readiness probe`. Liveness probes are used to check if the container is still running. Readiness probes are used to determine if containers are ready to service requests. We're going to be creating a health check, which is a liveness probe that we'll use to keep track of our application health.

Our health check will continually poll the application to ensure that the application is up and healthy. If the check fails, OpenShift will be alerted and will restart the container and spin up a brand new instance. You can read more about the specifics [here](https://docs.openshift.com/container-platform/4.9/applications/application-health.html).

Since a lack of health checks can cause container issues if they crash, OpenShift will alert you with a warning message if your project is lacking one.

In _Topology_ view, select your deployment. You should see something like this:

![Missing Health Checks](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-monitoring/healthChecks.png)

Since we have a Spring Boot application we have an easy option for implementation of health checks. We're able to pull in the `Spring Actuator` library.

**2. Add Health Checks with Actuator**

Spring Actuator is a project which exposes health data under the API path `/actuator/health` that is collected during application runtime automatically. All we need to do to enable this feature is to add the following dependency to ``pom.xml`` at the **TODO** comment.

```xml
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-actuator</artifactId>
    </dependency>
```

Click on the `Disk` icon to save the files or press `CTRL-S`:

![Visual Editor](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-monitoring/save-pom-file.png)

Notice how the previous warning message from before regarding missing health checks is no longer present. This is because of the dependency that we just added to ourt `pom.xml`. Adding this dependency triggers jkube to create Readiness/Liveness probes for OpenShift. These probes will periodically query the new health endpoints to make sure the app is still up.

Run the following command again to re-deploy the application to OpenShift:

```
mvn package oc:deploy -Popenshift -DskipTests -f /root/projects/rhoar-getting-started/spring/spring-monitoring
```

Now that we've added Spring Actuator, we're able to hit their provided `/actuator/health` endpoint. We can navigate to it by either adding `/actuator/health` to our landing page, or by clicking on the Route below.


Run this command to get the app's Route:

```
oc get route spring-monitoring -n dev -o jsonpath='{"http://"}{.spec.host}{"/actuator/health"}{"\n"}'

```

We should now see the following response, confirming that our application is up and running properly:

```json
{"status":"UP","groups":["liveness","readiness"]}
```

OpenShift will now continuously poll this endpoint to determine if any action is required to maintain the health of our container.

**3.Other Spring Actuator endpoints for monitoring**

The `/actuator/health` endpoint isn't the only endpoint that Spring Actuator provides out of the box. We're going to take a closer look at a few of the different endpoints so we can see how they help us with monitoring our newly deployed application, specifically the `/metrics` and `/beans` endpoints. A list of all other Spring Actuator endpoints can be found [here](https://docs.spring.io/spring-boot/docs/current/reference/html/production-ready-endpoints.html).

Unlike the `/actuator/health` endpoint some of these endpoints can return sensitive information and require authentication. For simplicity purposes we will be removing this security requirement in order to hit the endpoints, but this is not recommended for a production environment with sensitive data. From the *Visual Editor* Tab, open up the application.properties file `src/main/resources/application.properties` and add this code to disable endpoint security after the `# TODO: Add Security preference here` line:

```text
management.endpoints.web.exposure.include=*
```

Save the file.

If we redeploy the application again with:

```
mvn package oc:deploy -Popenshift -DskipTests -f /root/projects/rhoar-getting-started/spring/spring-monitoring
```

Now we can hit the `/actuator/metrics` endpoint from the Web Console or from here:

```
oc get route spring-monitoring -n dev -o jsonpath='{"http://"}{.spec.host}{"/actuator/metrics"}{"\n"}'

```

This returns a list of metrics types accessible to us:

```json
{"names":["http.server.requests","jvm.buffer.count","jvm.buffer.memory.used","jvm.buffer.total.capacity","jvm.classes.loaded","jvm.classes.unloaded","jvm.gc.live.data.size","jvm.gc.max.data.size","jvm.gc.memory.allocated","jvm.gc.memory.promoted","jvm.gc.pause","jvm.memory.committed","jvm.memory.max","jvm.memory.used","jvm.threads.daemon","jvm.threads.live","jvm.threads.peak","jvm.threads.states","logback.events","process.cpu.usage","process.files.max","process.files.open","process.start.time","process.uptime","system.cpu.count","system.cpu.usage","system.load.average.1m","tomcat.sessions.active.current","tomcat.sessions.active.max","tomcat.sessions.alive.max","tomcat.sessions.created","tomcat.sessions.expired","tomcat.sessions.rejected"]}
```

We can then navigate to `/actuator/metrics/[metric-name]`. For example for JVM Memory Usage:

```
oc get route spring-monitoring -n dev -o jsonpath='{"http://"}{.spec.host}{"/actuator/metrics/jvm.memory.max"}{"\n"}'
```

This will display different types of metric data about the JVM Metrics:

```json
{"name":"jvm.memory.max","description":"The maximum amount of memory in bytes that can be used for memory management","baseUnit":"bytes","measurements":[{"statistic":"VALUE","value":9.115271167E9}],"availableTags":[{"tag":"area","values":["heap","nonheap"]},{"tag":"id","values":["CodeHeap 'profiled nmethods'","PS Eden Space","CodeHeap 'non-profiled nmethods'","Compressed Class Space","PS Old Gen","PS Survivor Space","Metaspace","CodeHeap 'non-nmethods'"]}]}
```

In addition to the different monitoring endpoints we also have informational endpoints like the `/actuator/beans` endpoint, which will show all of the configured beans in the application. Spring Actuator provides multiple informational endpoints on top of the monitoring endpoints that can prove useful for information gathering about your deployed Spring application and can be helpful while debugging your applications in OpenShift.

# Open the solution in an IDE in the Cloud!
Want to continue exploring this solution on your own in the cloud? You can use the free [Red Hat CodeReady Workspaces](https://developers.redhat.com/products/codeready-workspaces/overview) IDE running on the free [Red Hat Developer Sandbox](http://red.ht/dev-sandbox).

## Congratulations

You have now included a health check in your Spring Boot application that's living in the OpenShift Container Platform.
