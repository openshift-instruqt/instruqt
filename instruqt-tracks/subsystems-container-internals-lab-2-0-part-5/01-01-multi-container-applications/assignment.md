---
slug: 01-multi-container-applications
id: u40hazzegra4
type: challenge
title: 'Multi-Container Workloads: The classic two-tiered, wordpress application'
notes:
- type: text
  contents: |
    ## Background
    This lab is focused on understanding how container images are built, tagged, organized and leveraged to deliver software in a range of use cases.

    By the end of this lab you should be able to:
    - Understand the uses of multi-container applications
    - Internalize the difference between orchestration and application definition
    - Command basic container scaling principles
    - Use tools to troubleshoot containers in a clustered environment

    ## Outline
    - Multi-Container Workloads: The classic two-tiered, wordpress application
    - Cluster Performance: Scaling applications horizontally with containers
    - Cluster Debugging: Troubleshooting in a distributed systems environment

    ## Other Material
    This presentation will give you a background to all of the concepts in this lab
    - [Google Presentation](https://docs.google.com/presentation/d/1S-JqLQ4jatHwEBRUQRiA5WOuCwpTUnxl2d1qRUoTz5g/edit#slide=id.g20639ff941_0_42)
    - [Lab GitHub Repository](https://github.com/openshift-instruqt/instruqt/tree/b18c330172f3b38042eb22ffca8b24ab32ab3490/instruqt-tracks/subsystems-container-internals-lab-2-0-part-5)

    ## Start Scenario
    Once you have watched the background video or went throught the presentation, continue to the exercises
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/labs
difficulty: intermediate
timelimit: 675
---
The goal of this exercise is to build a containerized two tier application in an OpenShift cluster. This application will help you learn about clustered containers and distributed systems. It will teach you about Kubernetes and how it operates with the principles of "defined state" and "actual state" - it constantly monitors the environment and attempts to make the actual state match the defined state.

In Kubernetes/OpenShift, applications are defined with either JSON or YAML files - either file format can be imported or exported, even converting between the two. In this lab, we will use YAML files.

Essentially, the application definition files are a collection of software defined objects in Kubernetes. The objects in the file are imported and become defined state for the application. Important objects include:

- Pods: Collections of one or more containers
- ReplicationControllers: Ensure that the correct number of pods are running.
- Services: Internal object which represents the port/daemon/program running.
- Routes: Expose services to the external world.
- PeristentVolumeClaims: Represents the request for storage and how much. Typically defined in the application by the developer or architect.
- PersistentVolume: Represents the actual storage. Typically defined by sysadmins or automation.

Developers and architects can group these objects/resources in a single file to make sharing and deployment of the entire application easier. These definitions can be stored in version control systems just like code. Let's inspect some of the Kubernetes resource definitions we will use for this lab.

First, create a new OpenShift project:

```
oc new-project myproject

```

Now look at the objects/resources that define the application:

```
cat ~/labs/wordpress-demo/wordpress-objects.yaml
```

Notice there are two Services defined - one for MySQL and one for Wordpress. This allows these two Services to scale independently. The front end can scale with web traffic demand. The MySQL service could also be made to scale with a technology like Galera, but would require special care. You may also notice that even though there are two Services, there is only a single Route in this definition. That's because Services are internal to the Kubernetes cluster, while Routes expose the service externally. We only want to expose our Web Server externally, not our database.

Containers are ephemeral which means their storage is deleted and recreated every time they restart. MySQL tables and the Apacheweb root need storage because we don't want our website data deleted every time a container restarts. To do this, we will define Persistent Volumes in Kubernetes. We will create four persistent volumes - two that have 1GB of storage and two that will have 2GB of storage. In this lab environment, these persistent volumes will reside on the local all-in-one installation, but in a production environment they could reside on shared storage and be accessed from any node in the Kubernetes/OpenShift cluster. In a production environment, they could also be dynamically provisioned with the appropriate resiliency (Gluster, Ceph, AWS EBS Volumes, NFS, iSCSI, others):

```
cat ~/labs/wordpress-demo/persistent-volumes.yaml
```

This host has been initialized with some already available PVs:

```
oc get pv
```

Notice that the persistent volumes are unbound. They are available and waiting, but will not be utilized until you define an application which consumes storage. This is inline with the way Kubernetes constantly tries to drive the actual state toward the defined state. Currently, there is no definition to consume this storage.


Now, let's instantiate our two tier web application with a single command. This single command can be thought of as an API call which tells Kubernetes the desired state or defined state which it will use as a guide:

```
oc create -f ~/labs/wordpress-demo/wordpress-objects.yaml
```

Look at the status of the application. The two pods that make up this application will remain in a "pending" state - why? Kubernetes will connect the Persistent Volume Claims with the available Persistent Volumes, pull images, and schedule the pods to a node. Keep running these commands until the pods start:

```
oc describe pod wordpress-
```

```
oc describe pod mysql-
```

Now, the persistent volume claims for the application will become Bound and satisfy the storage requirements. Kubernetes/OpenShift will now start to converge the defined state and the actual state:

```
oc get pvc
```

Also, take a look at the Persistent Volumes again:

```
oc get pv
```

You may notice the wordpress pod enter a state called CrashLoopBackOff. This is a natural state in Kubernetes/OpenShift which helps satisfy dependencies. The wordpress pod will not start until the mysql pod is up and running. This makes sense, because wordpress can't run until it has a database and a connection to it. Similar to email retries, Kubernetes will back off and attempt to restart the pod again after a short time. Kubernetes will try several times, extending the time between tries until eventually the dependency is satisfied, or it enters an Error state. Luckily, once the mysql pod comes up, wordpress will come up successfully. Here are some useful commands to watch the state:

Show all pods. You may run this command several times waiting for the actual state to converge with the defined state:

```
oc get pods
```

View the events for a pod. You may run these commands several times waiting for the actual state to converge with the defined state:

```
oc describe pod mysql-
```

```
oc describe pod wordpress-
```

Once the pods are scheduled and running, view the terminal output for each pod:

```
oc logs $(oc get pods | grep mysql- | awk '{print $1}')
```

```
oc logs $(oc get pods | grep wordpress- | awk '{print $1}')
```

Finally, ensure that the web interface is up and running. The following curl/grep/awk command will show us the HTML returned form the webserver, letting us know that wordpress is up and running.

```
curl http://$(oc get svc | grep wpfrontend | awk '{print $3}')/wp-admin/install.php
```

Think about it, we just instantiated a fairly complex, multi-service application with a single command and pre-defined state in the YAML files. This is extremely powerful and can be used to construct complex applications with 10, 20, 30 or 100 services.

In this exercise you learned how to deploy a fully functional two tier application with a single command (oc create). As long as the cluster has persistent volumes available to satisify the application, an end user can do this on their laptop, in a development environment or in production data centers all over the world. All of the dependent code is packaged up and delivered in the container images - all of the data and configuration comes from the environment. Production instances will access production persistent volumes, development environments can be seeded with copies of production data, etc. It's easy to see why container orchestration is so powerful.
