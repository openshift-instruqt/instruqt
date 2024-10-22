---
slug: playground
id: vnccbkgpousi
type: challenge
title: OpenShift Playground
notes:
- type: text
  contents: |
    ## Goal

    Explore Red Hat Developer Hub 1.0

    ## Concepts

    * Red Hat Developer Hub
    * Backstage Plugins
    * Software Catalog
    * Software Templates

    ## Use case

    You control an OpenShift cluster for one hour. You can deploy your own container image, or set up a pipeline to build your application from source, then use an Operator to deploy and manage a database backend.

    Sit back and relax!  This demo environment typically takes 10-15 mins to prepare
tabs:
- id: gfdyuqrkqdop
  title: Terminal 1
  type: terminal
  hostname: container
- id: pdrqnyaifn6k
  title: Terminal 2
  type: terminal
  hostname: crc
  cmd: /bin/bash
- id: neussbfiwrg6
  title: Web Console
  type: website
  url: https://console-openshift-console.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- id: gvful64bbuh4
  title: Developer Hub
  type: website
  url: https://rhdh.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 3600
---
Before you get started we recommend reading the following tips. They explain
a bit about how the playground environment is setup and what access you have.

## Installing RHDH

To install RHDH, paste the following in Terminal 1:
```
cd agnosticd/ansible/
```

Remove quay install dep:
```
head -n 33 roles_ocp_workloads/ocp4_workload_redhat_developer_hub_bootstrap/tasks/workload.yml > workload.yml
tail -n 6 roles_ocp_workloads/ocp4_workload_redhat_developer_hub_bootstrap/tasks/workload.yml >> workload.yml
mv workload.yml roles_ocp_workloads/ocp4_workload_redhat_developer_hub_bootstrap/tasks/workload.yml
```

I'm not sure where the `root-user-personal-token` is supposed to come from, but let us provide one:
```
oc new-project gitlab
oc create secret generic root-user-personal-token -n gitlab --from-literal=token=$(oc whoami -t)
```

Run the playbooks ([see docs for more info](https://redhat-cop.github.io/agnosticd/#_how_are_workloads_deployed)):
```
ansible-playbook -i crc, -c local ./configs/ocp-workloads/ocp-workload.yml \
 -e ocp_workloads="['ocp4_workload_redhat_developer_hub_bootstrap','ocp4_workload_redhat_developer_hub']" \
 -e ACTION=create \
 -e guid=97g8f \
 -e common_password=admin
```

## Helm chart installation guide (automated):

```
oc new-project rhdh
```
```
helm repo add openshift-helm-charts https://charts.openshift.io/
```
```
helm show values openshift-helm-charts/redhat-developer-hub > values.yaml
```
```
sed -e 's/^      registry: quay.io/      registry: registry.redhat.io/' -i values.yaml
```
```
sed -e "s/^  host: \"\"/  host: \"rhdh.crc.${INSTRUQT_PARTICIPANT_ID}.instruqt.io\"/" -i values.yaml
```
```
sed -e "s/^  clusterRouterBase: apps.example.com/  clusterRouterBase: \"crc.${INSTRUQT_PARTICIPANT_ID}.instruqt.io\"/" -i values.yaml
```
```
helm upgrade -i rhdh -f values.yaml openshift-helm-charts/redhat-developer-hub
```

## Logging in to the Cluster via Dashboard

Let's also log in to our web console. This can be done by clicking the *Web Console* tab near the top of your screen.

You can login as `admin` user. Use the following credentials:

* Username:
```
admin
```
* Password:
```
admin
```
![Web Console Login](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/web-console-login.png)


You can also login as the `developer` user. Use the following credentials:

* Username:
```
developer
```
* Password:
```
developer
```

## Logging in to the Cluster via CLI

When the OpenShift playground is created you will be logged in initially as
a cluster admin:

```
oc whoami
```

This will allow you to perform
operations which would normally be performed by a cluster admin.

Before creating any applications, it is recommended you login as a distinct
user. This will be required if you want to log in to the web console and
use it.

To login to the OpenShift cluster from the _Terminal_ run:

```
oc login -u admin -p admin
```

This will log you in using the credentials:

* **Username:** ``admin``
* **Password:** ``admin``

Use the same credentials to log into the web console.

## Persistent Volume Claims

Persistent volumes have been pre-created in the playground environment.
These will be used if you make persistent volume claims for an application.
The volume sizes are defined as 100Gi each, however you are limited by how
much disk space the host running the OpenShift environment has, which is
much less.

To view the list of available persistent volumes you can run:

```
oc get pv --as system:admin
```

# Next Steps!

Congratulations on completing this self-paced lab and learning about the capabilities of Red Hat OpenShift. To continue your journey, here's some handy links:

* [Red Hat Developer learning page](https://developers.redhat.com/learn)
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and provide your feedback on the next page. Thanks for playing!
