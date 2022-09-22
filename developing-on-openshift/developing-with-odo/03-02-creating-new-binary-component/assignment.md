---
slug: 02-creating-new-binary-component
id: kvqduzrjsboy
type: challenge
title: Topic 3 -Creating new application components
notes:
- type: text
  contents: Topic 3 - Creating new application components
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-wkzjw-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Visual Editor
  type: code
  hostname: container
  path: /root/backend
difficulty: basic
timelimit: 300
---

In this topic you will add new components to the OpenShift project you created in the previous topic. The components make up the **Wild West** application, which is the demonstration application for this project. Also, once the application is installed you'll view it in the OpenShift web console. In addition, you'll learn how to view logging activity within OpenShift.

As mentioned previously, applications often consist of two or more components that work together to implement the overall application. OpenShift helps organize these modular applications with a concept called, appropriately enough, *the application*. An OpenShift application represents all of an app's components in a logical management unit. The `odo` tool helps you manage that group of components and link them together as an application.

A selection of runtimes, frameworks, and other components are available to an OpenShift cluster for building your applications. This list is referred to as the **Developer Catalog**.

----

`Step 1:` Run the following command in the **Terminal 1** to list the component types in OpenShift Developer Catalog.

```
odo catalog list components
```

You'll get out  put similar to the list snippet shown below:

```
Odo Devfile Components:
NAME                             DESCRIPTION                                                         REGISTRY
dotnet50                         Stack with .NET 5.0                                                 DefaultDevfileRegistry
dotnet60                         Stack with .NET 6.0                                                 DefaultDevfileRegistry
dotnetcore31                     Stack with .NET Core 3.1                                            DefaultDevfileRegistry
go                               Stack with the latest Go version                                    DefaultDevfileRegistry
java-maven                       Upstream Maven and OpenJDK 11                                       DefaultDevfileRegistry
java-openliberty                 Java application Maven-built stack using the Open Liberty ru...     DefaultDevfileRegistry
java-openliberty-gradle          Java application Gradle-built stack using the Open Liberty r...     DefaultDevfileRegistry
java-quarkus                     Quarkus with Java                                                   DefaultDevfileRegistry
.
.
.
```

Administrators can configure the catalog to determine what components are available in the catalog. Thus, the list will vary on different OpenShift clusters.

For this scenario, the cluster's catalog list must include `java` and `nodejs`, which it does. The `java` and `nodejs` catalog items will be used when you build the backend component that is part of the `wildwest` demonstration application.

Now you will build the back end.

# Building the back-end component

`Step 2:` Run the following command in the **Terminal 1** window to the left to navigate into the source directory, `backend`:

```
cd /root/backend
```

----

`Step 3:` Run the following to view the files in the the `backend` directory

```
ls -lh
```

You'll get output similar to the following:

```
total 12K
-rw-r--r-- 1 root root  100 Mar 16 23:22 debug.sh
-rw-r--r-- 1 root root 1.8K Mar 16 23:22 pom.xml
drwxr-xr-x 3 root root 4.0K Mar 16 23:22 src
```

The files and directories in the output above are typical of a [Java Spring Boot](https://spring.io/projects/spring-boot) application that uses the [Maven](https://maven.apache.org/) build system.

The file named `pom.xml` describes the Maven Project Object Model for the `wild-west` application.

The `pom.xml` provides the information required for Maven to build the backend. The pattern for using Maven to do an action against the code is:

```
mvn <command>
```

**WHERE**

`<command>` is a particular Maven action. In this is case we're going to execute the `build` action.

----

`Step 4:`  Run the following command to use Maven to build the `backend` source files into a `.jar` file.

```
mvn package
```

You'll see output similar to the following at the end of the build process:

```
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time:  23.486 s
[INFO] Finished at: 2022-03-16T23:43:41Z
[INFO] ------------------------------------------------------------------------
```

(Since this is the first time running this build, it may take 30-45 seconds to complete. Subsequent builds will run much more quickly.)

The name of the jar file created by running the `mvn` command is `wildwest-1.0.jar`.

Now that the backend's `.jar` file has been built, we can use `odo` to deploy and run it on top of the Java application server we saw earlier in the catalog.

# Deploying the .jar file to container

`Step 5:` Run the command below to create a *component* configuration of *component-type* `java` named `backend`:

```
odo create java-springboot backend --app=app
```

As the component configuration is being created, `odo` will print the following:

```
Devfile Object Creation
 ✓  Checking if the devfile for "java-springboot" exists on available registries [124437ns]
 ✓  Creating a devfile component from registry "DefaultDevfileRegistry" [893ms]
Validation
 ✓  Validating if devfile name is correct [231678ns]
 ✓  Validating the devfile for odo [17ms]
 ✓  Updating the devfile with component name "backend" [961239ns]

Please use `odo push` command to create the component with source deployed
```

The component has been built but it is not yet deployed on OpenShift.

The `odo create` command created a configuration file named `config.yaml` in the local directory of the `backend` component. The configuration file `config.yaml` contains information about the component for deployment.

----

`Step 6:` Run the following command to view the configuration settings of the `backend` component in `config.yaml`:

```
odo config view
```

You'll see output similar to the following:

```
ComponentName: backend
Configs:
- ContainerName: tools
  EnvironmentVariables:
  - Name: DEBUG_PORT
    Value: "5858"
  Ports:
  - ExposedPort: 8080
    Name: 8080-tcp
    Protocol: http
Memory: 768Mi
```

Since `backend` is a binary component, as specified in the `odo create` command above, changes to the component's source code need to be followed by pushing the `.jar` file to a running [Linux container](redhat.com/en/topics/containers/whats-a-linux-container).

----

`Step 7:`  Run the following `odo` command to push the jar file created by Maven into a container.

```
odo push
```

You get output similar to the following snippet:

```
Validation
 ✓  Validating the devfile [364388ns]

Creating Services for component backend
 ✓  Services are in sync with the cluster, no changes are required

Creating Kubernetes resources for component backend
 ✓  Added storage m2 to backend
 ✓  Waiting for component to start [34s]
 ✓  Links are in sync with the cluster, no changes are required
 ✓  Waiting for component to start [2ms]

.
.
.

Pushing devfile component "backend"
 ✓  Changes successfully pushed to component
```

# Viewing the application in the OpenShift web console

The command `odo push` OpenShift created a container to host the `backend` component. Also, `odo` deployed the container into a pod running on the OpenShift cluster, and started up the `backend` component.

----

`Step 8a:` Click the web console tab in the horizontal menu bar at the top of this interactive learning environment to go to the OpenShift web console.

`Step 8b:` Select the **Developer** option from the drop-down menu as shown below:

![Developer Perspective](../assets/select-dev.png)

After selecting the **Developer** option, you will be at the **Topology** view that shows what components are deployed in your OpenShift project.

|NOTE|
|----|
|Sometimes it can take 20-30 seconds for the Topology view to render in the web page. Please be patient and wait.|

When a dark blue circle appears around the back-end component as shown below, the pod is ready and the `backend` component container will start running as shown in the figure below.

![Backend Pod](../assets/backend-pod.png)


# Viewing log output in the terminal window

You can check on the status of an action in `odo` by using the `odo log` command when `odo push` is finished

----

`Step 9:` Run the command shown below to follow the progress of the `backend` component deployment.

```
odo log -f
```

You'll receive output similar to the following:

```
2019-05-13 12:32:15.986  INFO 729 --- [           main] c.o.wildwest.WildWestApplication         : Started WildWestApplication in 6.337 seconds (JVM running for 7.779)
```

The output shown above confirms that the `backend` is running on a container in a pod in `myproject`:

The `backend` jar file has now been pushed, and the `backend` component is running.

When you've completed your review of the logs, send a break signal `CTRL-C` to return to the command prompt.

# Congratulations!

You installed the Java/Maven components for the demonstration application using `odo`. Also, you learned how to view the application in the OpenShift Web Console and view logs using `odo log`.

----

**NEXT:** Deploying components from source-code
