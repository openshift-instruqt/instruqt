---
slug: step5
id: pf2cvqrvgq2q
type: challenge
title: Running the Operator Locally (Outside the Cluster)
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Terminal 2
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-dzk9v-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 500
---
Once the CRD is registered, there are two ways to run the Operator:

* As a Pod inside a Kubernetes cluster
* As a Go program outside the cluster using Operator-SDK. This is great for local development of your Operator.

For the sake of this tutorial, we will run the Operator as a Go program outside the cluster using Operator-SDK and our `kubeconfig` credentials

Once running, the command will block the current session. You can continue interacting with the OpenShift cluster by opening a new terminal window. You can quit the session by pressing `CTRL + C`.

```
cd /root/projects/podset-operator && \
  MATCH_NAMESPACE=myproject KUBECONFIG=/root/.kube/config make run
```

In a new terminal, inspect the Custom Resource manifest:

```
cd $HOME/projects/podset-operator
cat config/samples/app_v1alpha1_podset.yaml
```

Ensure your `kind: PodSet` Custom Resource (CR) is updated with `spec.replicas`

```yaml
apiVersion: app.example.com/v1alpha1
kind: PodSet
metadata:
  name: podset-sample
spec:
  replicas: 3
```

You can easily update this file by running the following command:

```
\cp /tmp/app_v1alpha1_podset.yaml config/samples/app_v1alpha1_podset.yaml
```

Ensure you are currently scoped to the `myproject` Namespace:

```
oc project myproject
```

Deploy your PodSet Custom Resource to the live OpenShift Cluster:

```
oc create -f config/samples/app_v1alpha1_podset.yaml
```

Verify the Podset exists:

```
oc get podset
```

Verify the PodSet operator has created 3 pods:

```
oc get pods
```

Verify that status shows the name of the pods currently owned by the PodSet:

```
oc get podset podset-sample -o yaml
```

Increase the number of replicas owned by the PodSet:

```
oc patch podset podset-sample --type='json' -p '[{"op": "replace", "path": "/spec/replicas", "value":5}]'
```

Verify that we now have 5 running pods
```
oc get pods
```
