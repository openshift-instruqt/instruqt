---
slug: 03-modify-the-configmap
id: 5wvgyxdyb10d
type: challenge
title: Step 3
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/microservices-externalized-config
difficulty: basic
timelimit: 1000
---
# Making modifications to the Configuration Map

**1. The ConfigMap**

`ConfigMap`s are a useful tool for decoupling configuration settings from the code. `ConfigMap`s can be used to inject configuration data into a container in much the same way that secrets do, though `ConfigMap`s should not store confidential information. `ConfigMap` objects hold key-pair values representing all of your configuration data.

Notice the following dependency that was added to our `pom.xml`. This allows us to integrate with OpenShift's ConfigMaps.

```xml
     <dependency>
       <groupId>org.springframework.cloud</groupId>
       <artifactId>spring-cloud-starter-kubernetes-config</artifactId>
     </dependency>
```

Click on the `Disk` icon to save the files or press `CTRL-S`:

![Visual Editor](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-microservices/save-pom-file.png)

**2. Modify the ConfigMap**

Let's modify the greeting that our service is returning to the user. Since we set up the greeting in a properties file, we will not need to make any code change to change the functionality. This means that we won't need to have any downtime for this change, we're able to modify the response through our newly created `ConfigMap` from the previous step. We can edit our config map in the OpenShift Console. Navigate to ConfigMaps section in the `dev` project and open our `ConfigMap` in a YAML editor.

Change the `greeting.message` property to: `greeting.message=Bonjour, you picked %s as your favorite fruit!`

![Greeting Service](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-microservices/editconfigmap.png)

Hit `Save` (at the bottom of the editor) and that's all there is to it!

**3. Test changes**

Now that we've modified the `ConfigMap` and deployed our changes, let's test the greeting service and see if it's returning our new value.
Go back to the app in your browser and put in a test value and click the button. Now instead of seeing `Greetings ...`, we should be seeing:

`Bonjour, you picked %s as your favorite fruit!`

This means that we were able to modify our application behavior through External Configuration of the `application.properties` file using a ConfigMap without having to even take down the application. That's pretty powerful!


## Congratulations

You have now learned how to handle Externalized Configuration with ConfigMaps through OpenShift. By creating a `ConfigMap`, we're able to modify application properties on the fly and simply rollout the new changes to our application.