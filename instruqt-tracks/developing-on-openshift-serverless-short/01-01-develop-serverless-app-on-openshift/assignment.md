---
slug: 01-develop-serverless-app-on-openshift
id: nnlnqaebpuff
type: challenge
title: Develop Serverless Applications on OpenShift
notes:
- type: text
  contents: |
    [serverless-main]: https://www.openshift.com/learn/topics/serverless
    [amq-docs]: https://developers.redhat.com/products/amq/overview
    [pipelines-main]: https://www.openshift.com/learn/topics/pipelines
    [service-mesh-main]: https://www.openshift.com/learn/topics/service-mesh

    In this self-paced tutorial, you will learn how to deploy an OpenShift Serverless, which provides a development model to remove the overhead of server provisioning and maintenance from the developer.

    ## Why Serverless?

    Deploying applications as Serverless services is becoming a popular architectural style. It seems like many organizations assume that _Functions as a Service (FaaS)_ implies a serverless architecture. We think it is more accurate to say that FaaS is one of the ways to utilize serverless, although it is not the only way. This raises a super critical question for enterprises that may have applications which could be monolith or a microservice: What is the easiest path to serverless application deployment?

    The answer is a platform that can run serverless workloads, while also enabling you to have complete control of the configuration, building, and deployment. Ideally, the platform also supports deploying the applications as linux containers.

    ## OpenShift Serverless

    In this track we introduce you to one such platform -- [OpenShift Serverless][serverless-main].  OpenShift Serverless helps developers to deploy and run applications that will scale up or scale to zero on-demand. Applications are packaged as OCI compliant Linux containers that can be run anywhere.  This is known as `Serving`.

    ![OpenShift Serving](../assets/knative-serving-diagram.png)

    Serverless has a robust way to allow for applications to be triggered by a variety of event sources, such as events from your own applications, cloud services from multiple providers, Software as a Service (SaaS) systems and Red Hat Services ([AMQ Streams][amq-docs]).  This is known as `Eventing`.

    ![OpenShift Eventing](../assets/knative-eventing-diagram.png)

    OpenShift Serverless applications can be integrated with other OpenShift services, such as OpenShift [Pipelines][pipelines-main], and [Service Mesh][service-mesh-main], delivering a complete serverless application development and deployment experience.

    This tutorial will focus on the `Serving` aspect of OpenShift Serverless as the first diagram showcases.  Be on the lookout for additional tutorials to dig further into Serverless, specifically `Eventing`.

    ## The Environment

    The OpenShift environment created for you is running the latest version of the OpenShift Container Platform. This deployment is a self-contained environment that provides everything you need to be successful learning the platform. This includes a preconfigured command line environment, the OpenShift web console, public URLs, and sample applications.

    Now, let's get started!
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 300
---

**Red Hat OpenShift Serverless** is a service based on the open source Knative project. It provides an enterprise-grade serverless platform which brings portability and consistency across hybrid and multi-cloud environments. This enables developers to create cloud-native, source-centric applications using a series of Custom Resource Definitions (CRDs) and associated controllers in Kubernetes with the following benefits:

* Get code into production faster
* Any workload, anywhere
* Scale apps up or down based on demand
* Start experimenting with Knative

Find more OpenShift Serverless information [here](https://www.redhat.com/en/technologies/cloud-computing/openshift/serverless).

For your convenience, we've already installed the OpenShift Serverless in the cluster environment in advance.

## 1. Login as a Developer to create a new project

To log in to the non-privileged user in your environment, create a new project by running the following `oc` command in Terminal 1:

```
oc login -u developer -p developer

oc new-project serverless-tutorial
```

## 2. Deploy the Serverless Service

To deploy the service, you will use the `kn` command line tool to work with serverless.

```
kn service create greeter \
   --image quay.io/rhdevelopers/knative-tutorial-greeter:quarkus \
   --namespace serverless-tutorial
```

Watch the status using the commands:

```bash
while : ;
do
  output=`oc get pod -n serverless-tutorial`
  echo "$output"
  if [ -z "${output##*'Running'*}" ] ; then echo "Service is ready."; break; fi;
  sleep 5
done
```

A successful service deployment will show the following `greeter` pods:

```
NAME                                        READY   STATUS    RESTARTS   AGE
greeter-6vzt6-deployment-5dc8bd556c-42lqh   2/2     Running   0          11s
```

## 3. Check out the deployment

The Serverless Service deployments will create a few required serverless resources.  You will dive into each of them below.

### Service

You can see the Serverless Service that you just created by executing:

```
kn service list
```

The output should be similar to:

```
NAME      URL  LATEST            AGE     CONDITIONS   READY   REASON
greeter   https://greeter-serverless-tutorial.crc-lgph7-master-0.crc.gr82i7rvhrlg.instruqt.io   greeter-00001   52s   3 OK / 3   True
```
The Serverless `Service` gives us information about it's `URL`, it's `LATEST` revision, it's `AGE`, and it's status for each service you have deployed.  It is also important to see that `READY=True` to validate that the service has deployed successfully even if there were no pods running in the previous section.

### Route

the `Route` resource maps a network endpoint to one or more Knative revisions. It is possible to manage the traffic in several ways, including fractional traffic and named routes.  Currently, since our service is new, we have only one revision to direct our users to -- in later sections you will show how to manage multiple revisions at once using a `Canary Deployment Pattern`.

You can see the route by executing:
```
kn route list
```

See the `NAME` of the route, the `URL`, as well as if it is `READY` (your URL will be different):

```bash
NAME      URL                                                                                   READY
greeter   https://greeter-serverless-tutorial.crc-lgph7-master-0.crc.gr82i7rvhrlg.instruqt.io   True
```

### Revision

Lastly, you can inspect the `Revisions`.  As per the [OpenShift Serverless Documentation][ocp-serving-components], a `Revision` is a point-in-time snapshot of the code and configuration for each modification made to the workload. Revisions are immutable objects and can be retained for as long as needed. Cluster administrators can modify the `revision.serving.knative.dev` resource to enable automatic scaling of Pods in an OpenShift Container Platform cluster.

Before inspecting revisions, update the image of the service by executing:

```
kn service update greeter \
   --image quay.io/rhdevelopers/knative-tutorial-greeter:latest \
   --namespace serverless-tutorial
```

> **Note:** *Updating the image of the service will create a new revision, or point-in-time snapshot of the workload.*

You can see the revision by executing:
```
kn revision list
```

The output should be similar to:
```bash
NAME            SERVICE   TRAFFIC   TAGS   GENERATION   AGE     CONDITIONS   READY   REASON
greeter-00002   greeter   100%             2            6s      4 OK / 4     True
greeter-00001   greeter                    1            3m17s   3 OK / 4     True
```

Here you can see each revision and details including the percantage of `TRAFFIC` it is receiving.  You can also see the generational number of this revision, **which is incremented on each update of the service**.

## 4. Invoke the Service

Now that you have seen a a few of the underlying resouces that get created when deploying a Serverless Service, you can test the deployment.  To do so you will need to use the URL returned by the serverless route.  To invoke the service you can execute the command:

```
export APP_ROUTE=$(kn route list | awk '{print $2}' | sed -n 2p)
curl --insecure $APP_ROUTE
```

The service will return a response like this:

```
Hi  greeter => '6fee83923a9f' : 1
```

> **NOTE:** *You can also open this in your own local browser to test the service!*

## 5. Scale to Zero

The `greeter` service will automatically scale down to zero if it does not get request for approximately `90` seconds.  Try watching the service scaling down by executing

```
oc get pods -n serverless-tutorial -w
```

Try invoking the service again using the `curl` from earlier to see the service scaling back up from zero.

> **Question:** *Do you see now why the pod might not have been running earlier? The service scaled to zero before you checked!*

## 6. Delete the Service

You can easily delete our service by executing:

```
kn service delete greeter
```

Awesome! You have successfully deployed your very first serverless service using OpenShift Serverless. In the next assignment, you will go a bit deeper in understanding how to distribute traffic between multiple revisions of the same service.