---
slug: step2
id: yjeae0yyoq3n
type: challenge
title: CatalogSources
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
Observe the CatalogSources that ship with OLM and OpenShift 4:

```
oc get catalogsources -n openshift-marketplace
```

We have to include a new CatalagSource to get operators from OperatorHub.io:
```
cd /root && \
cat > operatorhub-catalogsource.yaml <<EOF
apiVersion: operators.coreos.com/v1alpha1
kind: CatalogSource
metadata:
  name: operatorhubio-catalog
  namespace: openshift-marketplace
spec:
  sourceType: grpc
  image: quay.io/operatorhubio/catalog:latest
  displayName: Community Operators
  publisher: OperatorHub.io
EOF
```

Apply the new CatalogSource:

```
oc apply -f operatorhub-catalogsource.yaml
```

Here is a brief summary of each CatalogSource:

* **Certified Operators**:
    * All Certified Operators have passed [Red Hat OpenShift Operator Certification](http://connect.redhat.com/explore/red-hat-openshift-operator-certification), an offering under Red Hat Partner Connect, our technology partner program. In this program, Red Hat partners can certify their Operators for use on Red Hat OpenShift. With OpenShift Certified Operators, customers can benefit from validated, well-integrated, mature and supported Operators from Red Hat or partner ISVs in their hybrid cloud environments.

To view the Operators included in the **Certified Operators** CatalogSource, run the following:

```
oc get packagemanifests -l catalog=certified-operators
```


* **Community Operators**:
    * With access to community Operators, customers can try out Operators at a variety of maturity levels. Delivering the OperatorHub community, Operators on OpenShift fosters iterative software development and deployment as Developers get self-service access to popular components like databases, message queues or tracing in a managed-service fashion on the platform. These Operators are maintained by relevant representatives in the [operator-framework/community-operators GitHub repository](https://github.com/operator-framework/community-operators).

To view the Operators included in the **Community Operators** CatalogSource, run the following:

```
oc get packagemanifests -l catalog=community-operators
```


* **Red Hat Operators**:
    * These Operators are packaged, shipped, and supported by Red Hat.

To view the Operators included with the **RedHat Operators** CatalogSource, run the following:

```
oc get packagemanifests -l catalog=redhat-operators
```


* **Red Hat Marketplace**:
    * Built in partnership by Red Hat and IBM, the Red Hat Marketplace helps organizations deliver enterprise software and improve workload portability. Learn more at [marketplace.redhat.com](https://marketplace.redhat.com).

To view the Operators included in the **Red Hat Marketplace** CatalogSource, run the following:

```
oc get packagemanifests -l catalog=redhat-marketplace
```