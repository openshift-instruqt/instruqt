---
slug: aap-configure
id: b4l1xusyizyt
type: challenge
title: Step 2 - Ansible Automation Platform Configuration
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

After a successful installation and login to the Ansible Automation platform, we need to configure it according to our requirements. These requirements could be anything, such as multi-cloud deployment, multi-cluster deployment, or using it for continuous delivery.

In this scenario, we will consider the Ansible Automation platform for continuous deployment/delivery. To do so, you need to follow the steps below carefully.

**Credentials:**

1. Create a service account with sufficient permissions so that we can interact with the cluster seamlessly.
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

You have successfully created a new namespace for your project "dev-game-app", service account, and RoleBindingCluster.

To log in to the Ansible Automation platform console, click on "credentials" from the left menu and select the credentials type as "OpenShift or Kubernetes API Bearer Token".

We need three components to fill in the credentials:
1. The OpenShift or Kubernetes API Endpoint of a cluster.
2. The API authentication bearer token of the service account.
3. The Certificate Authority data of the service account.

You can get the endpoint from the OpenShift console by clicking on "admin" in the top right corner and selecting "copy login command". Then click on "display" and log in again.

This API endpoint `https://api.crc.testing:6443` will work. Paste it into AAP credentials.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/oc_endpoint.png?raw=true)

You need to extract the token and certificates using the following commands.

The token is collected in `containergroup-sa.token` file. You have to copy the context and paste it into AAP credentials page in `API authentication bearer token` block.

```
dnf install jq -y && oc project dev-game-app && cd backend
```
```
oc get secret cicd -o json | jq '.data.token' | xargs | base64 --decode > containergroup-sa.token
```
The certificate is collected in the `containergroup-ca.crt` file. You have to copy the context and paste it in the AAP credentials page in the `Certificate Authority data` block.

```
oc get secret cicd -o json | jq '.data["ca.crt"]' | xargs | base64 --decode > containergroup-ca.crt
```

Alternatively, switch to the visual-editor tab to collect the `Token` and `Certificate`.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_cred_filled.png?raw=true)

**Instance Group:**

Now create an instance group. From the left-side menu, select Instance Group. Click on Add to create a new `Container Group`.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_instancegroup.png?raw=true)

Select the credentials you have created and check the empty box of Custom pod spec. Update namespace with `dev-game-app`, and the service account name will be `containergroup-service-account` here.

**Inventory:**

Now we have to create an inventory. Select inventories, click on **Add inventory**, and fill in the details. First, add the `Instance group` that you just made. You have to create `Hosts` here. For that, select Add & give a name to the host.

On variables:

```
---
{'ansible_host': '127.0.0.1', 'ansible_connection': 'local'}
```

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_inventory.png?raw=true)

After adding, you can check connectivity with OpenShift cluster by clicking on “Run Command”.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_inventory_run_command.png?raw=true)

1. Details: Select the "ping" module. NEXT.
2. Executive Environment: Leave the default.
3. Machine Credentials: Demo Credentials.
4. Preview: Launch.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_ping_op.png?raw=true)

**Project**:

The project is an SCM of the project where all playbooks and manifests are available. With the help of the project, we need to fetch it. From the left menu, select a project and click on Add, then give a name to the project.
The Source Control Type is Git. In the Source Control URL, fill in the GitHub URL:
```
https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo.git
```
Source Control Branch/Tag/Commit is "main". Check the empty box of "Update Revision on Launch". Now, save it.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_project.png?raw=true)

**Templates**:

Templates are a blueprint for your job that runs by using all dependencies we created.

Add a job template. Select inventory, project, and credentials, then select the playbook that you want to run. Save and launch the template.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_templte.png?raw=true)

Check the jobs.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_templete_op.png?raw=true)

Now, we'll take a look at Jenkins setup.