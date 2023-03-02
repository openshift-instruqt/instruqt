---
slug: aap-configure
id: b4l1xusyizyt
type: challenge
title: Ansible Automation Platform Configuration
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Visual Editor
  type: code
  hostname: container
  path: /root/backend
difficulty: basic
timelimit: 600
---

## Ansible Automation Platform Configuration Setup

After successful installation & login to the Ansible Automation platform. We need to configure the Ansible Automation platform as per our requirements. That requirement will be anything like multi-cloud deployment, Multi-Cluster deployment, Use as continuous delivery, etc.,

We are considering one scenario here of Ansible Automation platform like **Continues Deployment/Delivery**. For that, you need to follow the below steps carefully.
First, let's create Credentials for you need to follow the steps carefully.

**Credentials**:

1 . Create a service account with enough permission so we can interact with the cluster seamlessly.
```

cat <<EOF | oc apply -f -

---
apiVersion: v1
kind: Namespace
metadata:
  name: dev-game-app

---
  apiVersion: v1
  kind: ServiceAccount
  metadata:
      annotations:
      name: containergroup-service-account
      namespace: dev-game-app

---
  kind: Role
  apiVersion: rbac.authorization.k8s.io/v1
  metadata:
    name: role-containergroup-service-account
    namespace: dev-game-app
  rules:
  - apiGroups: ["*"]
    resources: ["*"]
    verbs: ["*"]
---
  kind: RoleBinding
  apiVersion: rbac.authorization.k8s.io/v1
  metadata:
    name: role-containergroup-service-account-binding
    namespace: dev-game-app
  subjects:
  - kind: ServiceAccount
    name: containergroup-service-account
  roleRef:
    kind: Role
    name: role-containergroup-service-account
    apiGroup: rbac.authorization.k8s.io

---
apiVersion: v1
kind: Secret
type: kubernetes.io/service-account-token
metadata:
  name: cicd
  annotations:
    kubernetes.io/service-account.name: "containergroup-service-account"
EOF
```

You successfully created New Namespace for your project “dev-game-app”, Sevice account & RoleBindingCluster.

Login to Ansible Automation platform console and From left menu click on **credentials** select credentials type as “OpenShift or Kubernetes API Bearer Token”.

We need 3 component to require to fill in the credentials.
1.  The OpenShift or Kubernetes API Endpoint of a cluster.
2.  API authentication bearer token of the service account.
3.  Certificate Authority data of the service account.
The endpoint you will get from openshift console. On the top right corner click on “admin” & select “copy login command”.Click on “display”. Login again.

- This API endpoint``` https://api.crc.testing:6443``` will work. Paste it in AAP credentials.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/oc_endpoint.png?raw=true)

You need to extract the token & Certificates by using following commands.

The token is collected in `containergroup-sa.token` file you have to copy the context and paste it in AAP credentials page in `API authentication bearer token` block.

```
dnf install jq -y && oc project dev-game-app && cd backend
```
```
oc get secret cicd -o json | jq '.data.token' | xargs | base64 --decode > containergroup-sa.token
```
The Certificate is collected in `containergroup-ca.crt` file you have to copy the context and paste it in  AAP credentials page in `Certificate Authority data` block.
```
oc get secret cicd -o json | jq '.data["ca.crt"]' | xargs | base64 --decode > containergroup-ca.crt
```

OR

Switch to the visual-editor tab to collect the `Token` and `Certificate`.


![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_cred_filled.png?raw=true)

**Instance Group**:

Now create an instance Group.
From the left side, menu selects Instance Group. Click on Add to create a new `Container Group`.


![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_instancegroup.png?raw=true)

Select the credentials which you have created and check the empty box of Custom pod spec.
Update namespace with `dev-game-app` and the service account name will be `containergroup-service-account` here.

**Inventory**:

Now we have to create an inventory. select inventories click on **Add inventory**. And in the fill in the details. First, add the `Instance group` that you just made. You have to create `Hosts` here. For that select Add & give a name to the host.
On variables
```
---
{'ansible_host': '127.0.0.1', 'ansible_connection': 'local'}
```

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_inventory.png?raw=true)

After adding you can able to check the connectivity with openshift cluster.
For that click on “Run Command”

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_inventory_run_command.png?raw=true)

1.  Details: Select “ping” Module. NEXT
2.  Executive Environment: leave the default
3.  Machine Credentials: Demo Credentials
4.  Preview: Launch


![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_ping_op.png?raw=true)

**Project** :

The project is nothing but an SCM of project where all playbooks & manifests are available. With the help of the project, we need to fetch her. From the left menu select a project and click on Add. give a name to the project.
The Source Control Type is Git. In the Source Control URL fill GitHub URL
```
https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo.git
```
Source Control Branch/Tag/Commit is “main”. And check the empty box of “Update Revision on Launch ”. SAVE it.


![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_project.png?raw=true)

**Templates**:

Templates are nothing but a blueprint for your job. Which runs the job by using all dependencies we created.

Add job template. Select inventory, project, and credentials & select the playbook that you want to run. Save & Launch the template

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_templte.png?raw=true)

 Check the Jobs.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_templete_op.png?raw=true)
