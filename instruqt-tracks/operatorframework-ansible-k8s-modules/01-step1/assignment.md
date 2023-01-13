---
slug: step1
id: ff6oomorcrer
type: challenge
title: Running the k8s Ansible modules locally
notes:
- type: text
  contents: |
    Since you are interested in *using Ansible for lifecycle management of applications on Kubernetes*, it will be beneficial to learn how to use the [Ansible k8s (Kubernetes) module](https://docs.ansible.com/ansible/latest/modules/k8s_module.html#k8s-info-module).

    The k8s module allows you to:
     - Leverage your existing Kubernetes resource files (written in YAML)
     - Express Kubernetes lifecycle management actions in native Ansible.

    One of the biggest benefits of using Ansible in conjunction with existing Kubernetes resource files is the ability to use Ansible's built-in [Jinja templating](https://docs.ansible.com/ansible/latest/user_guide/playbooks_templating.html) engine to customize deployments by simply setting Ansible variables.
difficulty: basic
timelimit: 300
---

    By the end of this scenario, you'll be able to use the Ansible k8s module to:

    - _Create_ and _remove_ Kubernetes resources
    - _Reuse_ existing Kubernetes manifest files with Ansible
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root/tutorial
---
For this example we will *create and delete a namespace* with the switch of an Ansible variable.

Let's begin by connecting to OpenShift:

```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```
---

###### **a. From *Visual Editor* Tab, open `example-role/tasks/main.yml` to contain the Ansible shown below.**

```yaml
---
- name: set test namespace to {{ state }}
  k8s:
    api_version: v1
    kind: Namespace
    name: test
    state: "{{ state }}"
  ignore_errors: true
```

Or can easily update this file by running the following command:

```
curl -s https://raw.githubusercontent.com/openshift-labs/learn-katacoda/master/ansibleop/ansible-k8s-modules/assets/tasksmain1.yml -o /root/tutorial/example-role/tasks/main.yml
```
---

###### **b. Modify vars file `example-role/defaults/main.yml`, setting `state: present` by default.**

```yaml
---
state: present

```

You can easily update this file by running the following command:

```
curl -s https://raw.githubusercontent.com/openshift-labs/learn-katacoda/master/ansibleop/ansible-k8s-modules/assets/defaultsmain1.yml -o /root/tutorial/example-role/defaults/main.yml
```
---

###### **c. Run playbook.yml, which will execute 'example-role'.**

```
cd /root/tutorial && \
    ansible-playbook -i myhosts playbook.yml
```

---

###### **d. Check that the namespace `test` was created.**

```
oc get projects | grep test
```

```
NAME              DISPLAY NAME   STATUS
test                             Active
```
