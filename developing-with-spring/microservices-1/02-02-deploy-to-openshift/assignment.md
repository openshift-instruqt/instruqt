---
slug: 02-deploy-to-openshift
id: 9v3gfbg3chkt
type: challenge
title: Step 2
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/microservices-externalized-config
- title: OpenShift Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 1000
---
# Deploy to OpenShift Application Platform

**1. Create a project**

Run the following command to login with the OpenShift CLI in Terminal 1:

```
oc login -u admin -p admin
```

You should see:

```bash
Login successful.
You don't have any projects. You can try to create a new project, by running `oc new-project <projectname>`
```

Let's first create a new project:

```
oc new-project dev --display-name="Dev - Spring Boot App"
```

**2. Additional Configuration**

Before we deploy the application, we have to make a few changes so our application runs smoothly using External Configurations.

The first step is we're going to assign view access rights to the service account we're logged in as. We have to do this before deploying the application so that it's able to access the OpenShift API and read the contents of the `ConfigMap`. We can do that with the following command:

```
oc policy add-role-to-user view -n $(oc project -q) -z default
```

We should see `clusterrole.rbac.authorization.k8s.io/view added: "default"` as output. The next step is to create our `ConfigMap` configuration and deploy it to OpenShift using:

```
cd /root/projects/rhoar-getting-started/spring/microservices-externalized-config && \
  oc create configmap spring-boot-configmap-greeting --from-file=src/main/etc/application.properties
```

We will talk about `ConfigMap`s in greater detail in the next section.

>**NOTE:** The only two parameters this command needs are the name of the ConfigMap to create and the file location. This command is creating a `ConfigMap` named `spring-boot-configmap-greeting`, which also happens to be the name of the application we're deploying. We're going to be using that name in future commands. If you decide to manually run the command or give the `ConfigMap` a different name, make sure you modify the other commands and configuration accordingly.

Now we're ready to deploy!

**3. Deploy the application to OpenShift**

Run the following command to deploy the application to OpenShift:

```
mvn oc:deploy -Popenshift
```

There's a lot that happens here so lets break it down:

For the deployment to OpenShift we are using the [JKube](https://www.eclipse.org/jkube/) tool through the [`openshift-maven-plugin`](https://www.eclipse.org/jkube/docs/openshift-maven-plugin), which is configured in our ``pom.xml`` (found in the `<profiles/>` section). The deployment may take a few minutes to complete.

You can run the command

```
oc rollout status -w dc/spring-boot-configmap-greeting
```

to watch and wait for the deployment to complete.

Once the application deployment completes, navigate to our route in the OpenShift Web Console.

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

or run this command to get the app's Route:

```
oc get route spring-boot-configmap-greeting -n dev -o jsonpath='{"http://"}{.spec.host}{"\n"}'
```

We should see the following screen, meaning everything was successful:

![Greeting Service](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-microservices/greeting-service-mini.png)

**4. Test functionality**

As the page suggests, we're going to put in a name of a fruit and let our greeting service reply with a given greeting. Since our default value in our `ConfigMap` is `Greetings, you picked %s as your favorite fruit!`, that's what we should see after we fill in the textbox and click the button.

## Congratulations

We've now deployed our application to OpenShift and we're ready to see how we can modify certain aspects of our application without downtime through the use of External Configuration via our ConfigMap.