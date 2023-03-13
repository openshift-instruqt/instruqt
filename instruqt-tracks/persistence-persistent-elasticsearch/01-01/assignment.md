---
slug: "01"
id: gip1w5x6sg06
type: challenge
title: Create Project and PVC
notes:
- type: text
  contents: |
    # What is OpenShift Container Storage (ODF)

    Red Hat® OpenShift® Container Storage is software-defined storage for containers. Engineered as the data and storage services platform for Red Hat OpenShift, Red Hat OpenShift Container Storage helps teams develop and deploy applications quickly and efficiently across clouds.

    # What will you learn

    In this tutorial you will learn how to create Persistent Volumes and use that for deploying Elasticsearch. You will then deploy a demo app which is a e-library search engin for 100 classic novels. Once the app is successfully deployed, you could search any word from 100 classic novels, the search is powered by Elasticsearch which is using persistent storage from ODF. The logical architecture of the app that you will deploy looks like this

    ![alt text](https://github.com/mulbc/learn-katacoda/raw/master/persistence/persistent-elasticsearch/architecture.png)
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
- You have been auto logged in as ```
admin` user, verify by running `oc whoami
``` on the command line.

> You can click on the above command (and all others in this scenario) to automatically copy it into the terminal and execute it.

- Create a new project, that we will use throughout this scenario and create a PersistentVolumeClaim on ODF storage class which will be used by Elasticsearch pod to persist data

```
oc create -f 1_create_ns_ocs_pvc.yaml
```

```
oc project e-library
```

- To verify get the Storage Class (SC) and PersistentVolumeClaim (PVC)

```
oc get pvc
```

```
oc get sc
```

- With just a few lines of YAML, you have created a PVC named `ocs-pv-claim` on storage class `ocs-storagecluster-ceph-rbd` which is provisioned from OpenShift Container Storage. Elasticsearch needs persistence for its data and OpenShift Container Storage is one of the simplest and reliable option that you can choose to persist data for you apps running on OpenShift Container Platform.
- Let's continue to the next section to deploy the Elasticsearch cluster.
