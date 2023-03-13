---
slug: step5
id: dh2okez0uiwl
type: challenge
title: Custom Resource Definitions
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Terminal 2
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 500
---
Begin by running a proxy to the Kubernetes API server:

```
oc proxy --port=8001
```


From *Terminal 2*, let's create a new Custom Resource Definition (CRD) object manifest for Postgres:

```
cd /root && \
cat >> postgres-crd.yaml <<EOF
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: postgreses.rd.example.com
spec:
  group: rd.example.com
  names:
    kind: Postgres
    listKind: PostgresList
    plural: postgreses
    singular: postgres
    shortNames:
    - pg
  scope: Namespaced
  versions:
  - name: v1alpha1
    schema:
      openAPIV3Schema:
        type: object
        x-kubernetes-preserve-unknown-fields: true
    served: true
    storage: true
EOF
```

Create the ***CRD*** resource object:

```
oc create -f postgres-crd.yaml
```

You should now see the Kubernetes API reflect a brand new *api group* called **rd.example.com**:

```
curl http://localhost:8001/apis | jq .groups[].name
```

This will also be reflected in the `oc api-versions` command:

```
oc api-versions
```

Within the `rd.example.com` group there will be an *api version* **v1alpha1** (per our CRD resource object). The database resource resides here.

```
curl http://localhost:8001/apis/rd.example.com/v1alpha1 | jq
```

Notice how `oc` now recognize postgres as a present resource (although there will be no current resource objects at this time).

```
oc get postgres
```

Let's create a new Custom Resource (CR) object manifest for the database:

```
cat >> wordpress-database.yaml <<EOF
apiVersion: "rd.example.com/v1alpha1"
kind: Postgres
metadata:
  name: wordpressdb
spec:
  user: postgres
  password: postgres
  database: primarydb
  nodes: 3
EOF
```

Create the new object:

```
oc create -f wordpress-database.yaml
```

Verify the resource was created:

```
oc get postgres
```

View the details about the wordpressdb object:

```
oc get postgres wordpressdb -o yaml
```

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!