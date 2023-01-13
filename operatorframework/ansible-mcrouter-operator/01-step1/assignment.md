---
slug: step1
id: qcnlyxjwol7q
type: challenge
title: Deploying the Mcrouter Operator
notes:
- type: text
  contents: |
    The Mcrouter Operator was built with the [Ansible Operator SDK](https://github.com/operator-framework/operator-sdk/blob/master/doc/ansible/user-guide.md). It is not yet intended for production use.

    [Mcrouter](https://github.com/facebook/mcrouter) is a Memcached protocol router for scaling [Memcached](http://memcached.org/) deployments. It's a core component of cache infrastructure at Facebook and Instagram where mcrouter handles almost 5 billion requests per second at peak.

    Mcrouter features:

    * Memcached ASCII protocol
    * Connection pooling
    * Multiple hashing schemes
    * Prefix routing
    * Replicated pools
    * Production traffic shadowing
    * Online reconfiguration
    * Flexible routing

    Mcrouter is developed and maintained by Facebook.



    At this point in our training, we should have a basic understanding of the *Operator pattern*.
     - Ansible Operator is an Operator which is _powered by Ansible_.
     - Custom Resource events trigger Ansible tasks as opposed to the traditional approach of handling these events with Go code.
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 360
---
Let's begin by connecting to OpenShift:

```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```


Create a new project called `mcrouter`:

```
oc new-project mcrouter
```

Let's use one command to deploy the Mcrouter CRD, Service Account, Role, RoleBinding, and Operator Deployment into the cluster:

```
oc apply -f https://raw.githubusercontent.com/openshift-instruqt/instruqt/v0.0.4/operatorframework/ansible-mcrouter-operator/assets/mcrouter-operator.yaml
```

Let's now verify that all the objects were successfully deployed. Begin by verifying the `kind: Mcrouter` CRD:

```
oc get crd mcrouters.mcrouter.example.com
```

Verify the `mcrouter-operator` Service Account. This Service Account is responsible for the identity of the Mcrouter Operator Deployment.

```
oc get sa
```

Verify the `mcrouter-operator` Role. This Role defines the Role-Based Access Control for the `mcrouter-operator` Service Account.

```
oc get role
```

Verify the `mcrouter-operator` RoleBinding. This RoleBinding applies our Role to the `mcrouter-operator` Service Account.

```
oc get rolebinding
```

Finally, we will verify that the Mcrouter Deployment and its associated pod are successfully running:

```
oc get deploy,pod
```

This Deployment consists of two containers: `operator` and `ansible`. The `ansible` container exists only to expose the standard Ansible stdout logs. The `operator` container contains our Ansible Operator Mcrouter roles/playbooks. Observe the log files for both containers:

```
oc logs deploy/mcrouter-operator -c operator
```

Observe the log files for the Ansible container (it should currently be empty because we have yet to create a Custom Resource).

```
oc logs deploy/mcrouter-operator -c ansible
```

Observe the Service exposing the Operator's [Prometheus metrics endpoint](https://prometheus.io/docs/guides/go-application/#how-go-exposition-works). Ansible-Operator automatically registers this endpoint for you.

```
oc get svc -l name=mcrouter-operator
```