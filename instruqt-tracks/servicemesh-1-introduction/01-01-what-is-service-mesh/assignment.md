---
slug: 01-what-is-service-mesh
id: ko0rwzz0ilko
type: challenge
title: What is Service Mesh and why we need it?
notes:
- type: text
  contents: |-
    In this self-paced tutorial, you will learn the basics of how to use OpenShift Service Mesh, which provide a way to control how different parts of an application share data with one another.

    In this scenario, you will:
    * Learn what Red Hat OpenShift Service Mesh is.
    * Use the Red Hat OpenShift Service Mesh in a playground type environment.

    ![Red Hat OpenShift Service Mesh](assets/ossm.png)

    ## Why Service Mesh?

    Red Hat OpenShift Service Mesh provides a platform for behavioral insight and operational control over your networked microservices in a service mesh. With Red Hat OpenShift Service Mesh, you can connect, secure, and monitor microservices in your OpenShift Container Platform environment.  The Red Hat OpenShift Service Mesh uses and is based from the open source projects istio, kiali, and jaeger.

    ## The Environment

    During this scenario, you will be using a hosted OpenShift environment that is created just for you. This environment is not shared with other users of the system. Because each user completing this scenario has their own environment, we had to make some concessions to ensure the overall platform is stable and used only for this training. For that reason, your environment will only be active for a one hour period. Keep this in mind before you get started on the content. Each time you start this training, a new environment will be created on the fly.

    The OpenShift environment created for you is running version 4.7 of the OpenShift Container Platform. This deployment is a self-contained environment that provides everything you need to be successful learning the platform. This includes a preconfigured command line environment, the OpenShift web console, public URLs, and sample applications.

    Now, let's get started!
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 600
---
The term service mesh is used to describe the network of microservices that make up such applications and the interactions between them. As a service mesh grows in size and complexity, it can become harder to understand and manage. Its requirements can include discovery, load balancing, failure recovery, metrics, and monitoring. A service mesh also often has more complex operational requirements, like A/B testing, canary releases, rate limiting, access control, and end-to-end authentication.

Red Hat Service Mesh, based on the open source [Istio project](https://istio.io), provides behavioral insights and operational control over the service mesh as a whole, offering a complete solution to satisfy the diverse requirements of microservice applications. It provides a number of key capabilities uniformly across a network of services:

- **Traffic Management**. Control the flow of traffic and API calls between services, make calls more reliable, and make the network more robust in the face of adverse conditions.

- **Observability**. Gain understanding of the dependencies between services and the nature and flow of traffic between them, providing the ability to quickly identify issues.

- **Policy Enforcement**. Apply organizational policy to the interaction between services, ensure access policies are enforced and resources are fairly distributed among consumers. Policy changes are made by configuring the mesh, not by changing application code.

- **Service Identity and Security**. Provide services in the mesh with a verifiable identity and provide the ability to protect service traffic as it flows over networks of varying degrees of trustability.

In addition to these behaviors, Istio is designed for extensibility to meet diverse deployment needs:

- **Platform Support**. Istio is designed to run in a variety of environments including ones that span Cloud, on-premise, Kubernetes, Mesos etc. We’re initially focused on Kubernetes but are working to support other environments soon.

- **Integration and Customization**. The policy enforcement component can be extended and customized to integrate with existing solutions for ACLs, logging, monitoring, quotas, auditing and more.

These capabilities greatly decrease the coupling between application code, the underlying platform, and policy. This decreased coupling not only makes services easier to implement, but also makes it simpler for operators to move application deployments between environments or to new policy schemes. Applications become inherently more portable as a result.


## What is Traffic?

Using Istio’s traffic management model essentially decouples traffic flow and infrastructure scaling, letting operators specify via Pilot what rules they want traffic to follow rather than which specific pods/VMs should receive traffic - Pilot and intelligent Envoy proxies look after the rest. So, for example, you can specify via Pilot that you want 5% of traffic for a particular service to go to a canary version irrespective of the size of the canary deployment, or send traffic to a particular version depending on the content of the request.
