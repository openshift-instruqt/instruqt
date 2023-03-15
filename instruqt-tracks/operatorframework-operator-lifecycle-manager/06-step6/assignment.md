---
slug: step6
id: zytqtzaodo9y
type: challenge
title: Creating the Custom Resource
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
Let's deploy our ArgoCD Server "operand" by creating the ArgoCD manifest via the CLI. You can also do this on the OpenShift console.

```
cd /root/ && \
cat > argocd-cr.yaml <<EOF
apiVersion: argoproj.io/v1alpha1
kind: ArgoCD
metadata:
  name: example-argocd
  namespace: myproject
spec:
  dex:
    image: quay.io/ablock/dex
    openShiftOAuth: true
    version: openshift-connector
  rbac:
    policy: |
      g, system:cluster-admins, role:admin
  server:
    route:
      enabled: true
EOF
```



Create the ArgoCD Custom Resource:

```
oc create -f argocd-cr.yaml
```



The ArgoCD Operator should now begin to generate the ArgoCD Operand artifacts. This can take up to one minute:

```
oc get deployments
oc get secrets
oc get services
oc get routes
```