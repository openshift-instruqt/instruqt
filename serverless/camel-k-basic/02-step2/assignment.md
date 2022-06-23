---
slug: step2
id: 0lfqcvenst8b
type: challenge
title: Step 2 - Creating and running your first Camel K application
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/camel-basic
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-gh9wd-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 300
---
## Creating your first Camel K application
Let's first of all switch to the working folder by running:

```
cd /root/camel-basic/
```

Camel K makes it very easy to get started. The `init` command helps you create a simple *Hello World* sample route definition you can run.

To create the Camel source file using the Java language, run the following command:

```
kamel init hello.java
```

Go to the **Visual Editor** tab, under the folder /root/camel-basic and inspect the contents of source code generated.

> **Note:** notice you don't need to specify ANY dependency specification in the folder, Camel K will figure it out, and inject it during the build. So all you need is to JUST write your application. In this case, the `kamel` client will push it to the cluster and the operator will do all the tedious footworks for you.

To run it, execute the following command:

```
kamel run hello.java --dev
```

Wait for the integration to be running (you should see the logs streaming in the terminal window).
```
No IntegrationPlatform resource in camel-basic namespace
Integration "hello" created
Progress: integration "hello" in phase Waiting For Platform
Integration hello in phase "Waiting For Platform"
Condition "IntegrationPlatformAvailable" is "False" for Integration hello: camel-basic/camel-k
Progress: integration "hello" in phase Initialization
Progress: integration "hello" in phase Building Kit
Integration hello in phase "Initialization"
Condition "IntegrationPlatformAvailable" is "True" for Integration hello: camel-basic/camel-k
Integration hello in phase "Building Kit"
Condition "IntegrationKitAvailable" is "False" for Integration hello: creating a new integration kit
Integration hello subresource kit-cama5g90ags7ke44d0t0 (Integration Kit) changed phase to "Build Submitted"
Integration hello subresource kit-cama5g90ags7ke44d0t0 (Build) changed phase to "Scheduling"
Integration hello subresource kit-cama5g90ags7ke44d0t0 (Build) changed phase to "Pending"
Integration hello subresource kit-cama5g90ags7ke44d0t0 (Build) changed phase to "Running"
Integration hello subresource kit-cama5g90ags7ke44d0t0 (Integration Kit) changed phase to "Build Running"
```

It's going to take 5-6 mins to start up your first application, since it needs to pull and build the image for the first time. But the next build will only take seconds.

Once it started, you can find the pod running this basic application in the terminal.

```
[1] ... Body: Hello Camel K from java]
[1] ... Body: Hello Camel K from java]
[1] ... Body: Hello Camel K from java]
```

Go to  **Web Console** tab. Login if you have not already do so. Click into the *hello-xxxxxxxxxx* pod, click on the log tab. The output in the console should be the same as in the terminal.

Camel K's developer mode (the command's flag `--dev`) hooks the client with the environment, and inmediately pushes any code changes. The code update triggers a new pod instance running the new code and your terminal will start streaming the new logs.

Let's trigger a code update. Go back to the editor and try changing the word `Hello` to  `Riding`. And see what happens.


```
[2] ... Body: Riding Camel K from java]
[2] ... Body: Riding Camel K from java]
[2] ... Body: Riding Camel K from java]
```

Hit `ctrl+C` on the terminal window. This will also terminate the execution of the integration.

## Using declarative languages
Apache Camel supports multiple languages, not just Java. In fact, when working with Camel K, the recomendation is to use a declarative language like YAML or XML. Java is generally a better fit for advanced uses of Camel.

 > **Tip:** if your integration contains extensive Java code (other than your Camel routes), probably Camel Quarkus would be a better fit.

Try generating code using other languages by executing the following commands:

```
kamel init hello.xml
```
and
```
kamel init hello.yaml
```

Go to the **Visual Editor** tab, under the folder /root/camel-basic and inspect the contents of the XML and YAML files generated.

You don't need in this lab to execute the new XML/YAML files, but if you did they would produce a similar result as running the Java version one.

