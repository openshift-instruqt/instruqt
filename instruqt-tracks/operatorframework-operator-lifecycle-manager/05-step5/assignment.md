---
slug: step5
id: 126g1hwymcvp
type: challenge
title: Reviewing the InstallPlan and Installing the Operator
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 225
---
Fetch the InstallPlan and observe the Kubernetes objects that will be created once approved:

```
ARGOCD_INSTALLPLAN=`oc get installplan -o jsonpath={$.items[0].metadata.name}`
oc get installplan $ARGOCD_INSTALLPLAN -o yaml
```


You can get a better view of the InstallPlan by navigating to the ArgoCD Operator in the [Console](https://console-openshift-console-[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com/).

Navigate to the Operators section of the UI and select the ArgoCD Operator under **Installed Operators**. Ensure you are scoped to the **myproject** namespace. You should click on the InstallPlan on the bottom right of the screen:

![InstallPlan on the OpenShift Console](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/operatorframework/operator-lifecycle-manager/olm-installplan.png)

You can install the Operator by approving the InstallPlan via the OpenShift console or with the following command:

```
oc patch installplan $ARGOCD_INSTALLPLAN --type='json' -p '[{"op": "replace", "path": "/spec/approved", "value":true}]'
```



Once the InstallPlan is approved, you will see the newly provisioned ClusterServiceVersion, ClusterResourceDefinition, Role and RoleBindings, Service Accounts, and Argo-CD Operator Deployment.

```
oc get clusterserviceversion
```


```
oc get crd | grep argoproj.io
```


```
oc get sa | grep argocd
```


```
oc get roles | grep argocd
```


```
oc get rolebindings | grep argocd
```


```
oc get deployments
```



When the ArgoCD Operator is running, we can observe its logs by running the following:

```
ARGOCD_OPERATOR=`oc get pods -o jsonpath={$.items[0].metadata.name}`
oc logs $ARGOCD_OPERATOR -c manager
```


The ArgoCD Operator is now waiting for the creation of an ArgoCD Custom Resource within the `myproject` namespace.