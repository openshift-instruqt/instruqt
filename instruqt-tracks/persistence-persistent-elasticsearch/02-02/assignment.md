---
slug: "02"
id: 2r0r8co9bi07
type: challenge
title: Deploy Elasticsearch on ODF
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: service
  hostname: crc
  path: /
  port: 30001
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 225
---
- Apply the YAML file to deploy Elasticsearch

```
oc create -f 2_deploy_elasticsearch.yaml
```

- To make Elasticsearch persistent we have defined ODF PVC under `volumes` section, mounted it under `volumeMounts` inside the deployment manifest file, as shown below. Doing this, Elasticsearch will then store all of its data on the the PersistentVolumeClaim which resides on OpenShift Container Storage.

```
...
    spec:
      volumes:
        - name: ocs-pv-storage
          persistentVolumeClaim:
            claimName: ocs-pv-claim
...
...
...
        volumeMounts:
          - mountPath: "/usr/share/elasticsearch/data"
            name: ocs-pv-storage
```

> As a developer, this should be the most important stage to enable data persistence for your application. When you request PVC that are provisioned via ODF storage class, the OpenShift Container Storage subsystem make sure your application's data is persistent and reliably stored.
