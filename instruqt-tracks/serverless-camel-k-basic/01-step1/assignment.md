---
slug: step1
id: 0lfqcvenst8b
type: challenge
title: Step 1 - Running your first Camel K application
notes:
- type: text
  contents: |2

    This scenario will introduce [Camel K ](https://camel.apache.org/camel-k/latest/index.html).

    ## What is Camel K?

    ![Logo](../assets/images/logo-camel.png)

    ### Your Integration Swiss-Army-Knife native on Kubernetes with Camel K

    Apache Camel K is a lightweight integration framework built from Apache Camel that runs natively on Kubernetes and is specifically designed for serverless and microservice architectures.

    Camel K supports multiple languages for writing integrations. Based on the Operator Pattern, Camel K performs operations on Kubernetes resources, bringing integration to the next level and utilizing the benefit of the Apache Camel project, such as the wide variety of components and Enterprise Integration Patterns (EIP).

    Camel K integrate seamlessly with Knative making it the best serverless technology for integration. This scenario will get you started and hands on Camel K.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
  cmd: /bin/bash
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/camel-basic
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-97g8f-master-0.crc.${_SANDBOX_ID}.instruqt.io/topology/ns/camel-basic?view=graph
  new_window: true
difficulty: basic
timelimit: 375
---
In order to run Camel K, you need access to an Kubernetes/OpenShift environment.

We have provisioned for you the following items:
- An OpenShift cluster
- The Camel K Operator
- An OpenShift project (namespace):
  - `camel-basic`

You're already connected to the OpenShift cluster and your session is pointing to the project `camel-basic`.

<br/>

## Creating your first Camel K application
Let's first of all switch to the working folder by running:

```
cd /root/camel-basic/
```

Camel K makes it very easy to get started. \
The `init` command helps you create a simple *Hello World* sample route definition that you can run.

To create the Camel source file using the Java language, run the following command:

```
kamel init hello.java
```

Go to the **Visual Editor** tab, under the folder:
 - `/root/camel-basic`

Inspect the contents of source code generated.

> [!IMPORTANT]
> Click the circle arrow `↻` in the visual editor tab to refresh the view if you don't see the newly created file listed.

> [!NOTE]
> Notice you don't need to specify ANY dependency specification in the folder, Camel K will figure it out, and inject it during the build. So all you need is to JUST write your application. In this case, the `kamel` client will push it to the cluster and the operator will do all the tedious footworks for you.

To run it, from the terminal, execute the following command:

```
kamel run hello.java --dev
```

> [!WARNING]
> If you see the execution entering in an *Error* state showing logs similar to:
> ```nocopy
> Condition "Ready" is "False" for Integration hello: 0/1 nodes are available: 1 node(s) had untolerated taint {node.kubernetes.io/disk-pressure: }. preemption: 0/1 nodes are available: 1 Preemption is not helpful for scheduling..
> Integration "hello" in phase "Error"
> ```
> Wait 2-3 minutes until the execution self-heals and recovers from the error state.

> [!NOTE]
> The lab has been pre-loaded with some base dependencies to accelerate the above execution.
> Otherwise, the very first time you run the application it generally takes around 5-6 mins to start because Camel K needs to pull and build the image for the first time.

<br/>

Wait for the integration to be running (you should see the logs streaming in the terminal window).
```nocopy
No IntegrationPlatform resource in camel-basic namespace
Integration "hello" created
Progress: integration "hello" in phase Waiting For Platform
Condition "IntegrationPlatformAvailable" is "False" for Integration hello: camel-basic/camel-k
Integration "hello" in phase "Waiting For Platform"
Progress: integration "hello" in phase Initialization
Integration "hello" in phase "Initialization"
Progress: integration "hello" in phase Building Kit
Condition "IntegrationPlatformAvailable" is "True" for Integration hello: camel-basic/camel-k
Integration "hello" in phase "Building Kit"
Condition "IntegrationKitAvailable" is "False" for Integration hello: creating a new integration kit
Integration Kit "kit-caqtv154p69csa3fofrg", created by Integration "hello", changed phase to "Build Submitted"
Build "kit-caqtv154p69csa3fofrg", created by Integration "hello", changed phase to "Scheduling"
Build "kit-caqtv154p69csa3fofrg", created by Integration "hello", changed phase to "Pending"
Build "kit-caqtv154p69csa3fofrg", created by Integration "hello", changed phase to "Running"
Integration Kit "kit-caqtv154p69csa3fofrg", created by Integration "hello", changed phase to "Build Running"
```

Once fully started, the logs in your terminal will show you the pod running:

```nocopy
[1] ... Body: Hello Camel K from java]
[1] ... Body: Hello Camel K from java]
[1] ... Body: Hello Camel K from java]
```
<br/>

You can also view the logs from OpenShift's web console
 - Click the [button label="Web Console" background="#6c5ce7" ](tab-2) tab.
 - To login, use the credentials `admin`/`admin`

<br/>

Then follow these steps:
1. Click the round `hello` deployment
1. Find and click the `Resources` tab in the right panel
1. Click the *View logs* link.

The output in the console should be the same as in the terminal.

<br/>

> [!IMPORTANT]
> Camel K's developer mode (enabled with flag `--dev`) hooks the client with the environment, and inmediately pushes any code changes. The code update triggers a new pod instance running the new code and your terminal will start streaming the new logs.

Let's trigger a code update. \
Go back to the editor, find the `simple` expression, and change its value:
 - from `Hello`
 - to  `Riding`.

You should see the execution's output now showing:

```nocopy
[2] ... Body: Riding Camel K from java]
[2] ... Body: Riding Camel K from java]
[2] ... Body: Riding Camel K from java]
```

Hit `ctrl`+`C` on the terminal window. This will also terminate the execution of the integration.

<br/>

## Using declarative languages

Apache Camel supports multiple languages, not just Java. In fact, when working with Camel K, the use of declarative languages like YAML or XML is preferable, instead of Java, better left for advanced uses of Camel.

> [!IMPORTANT]
> If your Camel K integration contains extensive Java code (other than your Camel routes), it probably makes more sense to run it in Camel Quarkus instead which is better fit to manage the project and its dependencies.

<br/>

Try generating code using other languages by executing the following commands:

```
kamel init hello.xml
kamel init hello.yaml

```

Go to the **Visual Editor** tab, under the folder:
  - `/root/camel-basic`

Click the button `↻` (refresh) and inspect the contents of the XML and YAML files generated.

> [!NOTE]
> Observe how all 3 source types have equivalent definitions using different DSLs.

There's no need to execute the new XML/YAML files. \
If you did they, they would produce a similar result as the Java version you ran.

Click *Next* to continue with step 2.
