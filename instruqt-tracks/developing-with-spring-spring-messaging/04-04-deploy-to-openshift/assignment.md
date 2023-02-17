---
slug: 04-deploy-to-openshift
id: xtoir6qqdacz
type: challenge
title: Step 4
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/spring-messaging
difficulty: basic
timelimit: 750
---
# Deploy to OpenShift Application Platform

Before we deploy the application to OpenShift we need to add health checks so that OpenShift can correctly detect if our application is working. For this simple application we will simply leverage another Spring Boot project: Spring Actuator.

**1. Add a health check**

Spring Boot provides a nice feature for health checks called Actuator. Actuator is a project which exposes health data under the API path `/health` that is collected during application runtime automatically. All we need to do to enable this feature is to add the following dependency to `pom.xml` after `<!-- TODO: Add Actuator dependency here -->` comment in Visual Editor:

```xml
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-actuator</artifactId>
    </dependency>
```

Save the file.

**2. Deploy a Red Hat AMQ Instance**

Once the operator installation is successful, you will create two instances - an `ActiveMQArtemis` instance and an `ActiveMQArtemisAddress` instance. For your reference, the YAML file containing the instance details has been created for you and you can view the file as follows in Terminal 1:

```
cd /root/projects/rhoar-getting-started/spring/spring-messaging
cat amq.yml
```

You can also observe a **Route** to the AMQ console is defined here, should you choose to play around. Now, execute the following command to create those two instances and the route:

```
oc create -f amq.yml
```

Note that you can ignore the warnings like Unable to recognize `"amq.yml": no matches for kind "ActiveMQArtemis" or "ActiveMQArtemisAddress" in version "broker.amq.io/v2alpha4"`.

**4. Deploy the application to OpenShift**

Run the following command to deploy the application to OpenShift

```
mvn package oc:deploy -Popenshift -DskipTests
```

There's a lot that happens here so lets break it down:

The `mvn package` piece of the above command instructs Maven to run the package lifecycle. This builds a Spring Boot JAR file which is a Fat Jar containing all dependencies necessary to run our application.

For the deployment to OpenShift we are using the [jkube](https://www.eclipse.org/jkube) tool through the `org.eclipse.jkube:openshift-maven-plugin` which is configured in our `pom.xml` (found in the `<profiles/>` section). Configuration files for jkube are contained in the ``src/main/jkube`` folder mentioned earlier.

After the Maven build/deploy is finished, it will typically take less than 20 sec for the application to be available. Then you can go to the OpenShift web console from the developer perspective and click on the route from the topology tab (refer to the image below):

![Spring Messaging App Route](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-messaging/spring-messaging-training-route.png)

You should see the same web application as before. The scheduled Producer will continue to deploy messages every 3 seconds so you should observe a change in the values shown. The number of items in the list will remain 5.

## Congratulations

You have now learned how to deploy a Spring Boot JMS application and a Red Hat AMQ resource to the OpenShift Container Platform.

# What's Next?

Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
