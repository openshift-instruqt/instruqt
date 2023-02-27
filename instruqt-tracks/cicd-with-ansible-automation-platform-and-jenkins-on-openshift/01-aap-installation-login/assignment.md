---
slug: aap-installation-login
id: i2r2g73o7xga
type: challenge
title: Ansible Automation platform Installation & Login
notes:
- type: text
  contents: |+
    # Goal

    CI/CD with Ansible Automation Platform and jenkins on Openshift

    ![architecturediagram](https://raw.githubusercontent.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/main/assets/ansible_final1.jpg)

    A subset of application deployment, continuous deployment pipelines help developers release new software features and updates more frequently to support modern business demands. Red Hat Ansible Automation Platform provides the multitier, multistep application orchestration needed for fast, reliable deployment of new features, bug fixes, and code changes, while reducing the need for human intervention throughout the release process.

    This Instruqt track provides hands-on experince of deploying CI/CD pipeline using Ansible Automation Platform and Jenkins on openshift.

    Let's get started!



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
timelimit: 1000
---

# CI/CD with Ansible Automation Platform and Jenkins

[Continuous integration/continuous deployment (CI/CD) approaches](https://www.redhat.com/en/topics/devops/what-is-ci-cd) can help developers rapidly build, test, and deliver high-quality applications. CI/CD applies automation throughout the application life cycle, from the integration and testing phases to delivery and deployment, to quickly produce tested, verified applications. Let us understand the two phases:

-   Continuous integration (CI) helps developers rapidly verify functionality and merge their code changes back to a shared branch more frequently. Merged code changes are validated by automatically building the application and running different levels of automated testing, typically unit and integration tests, to ensure the changes work. If testing discovers a conflict between new and existing code, CI makes it easier and faster to fix those bugs.

-   Continuous deployment (CD) automates the process of releasing an application to production. There are few manual gates in the development pipeline stage just before production, so CD relies heavily on well-designed test automation. As a result, a developer’s change to a cloud application could go live within minutes of writing it if it passes all automated tests. CD makes it much easier to continuously receive and incorporate user feedback.


Together, CI and CD practices allow developers to release changes to applications in smaller pieces, making application deployment more reliable. By definition, CI/CD pipelines require automation, and [Red Hat Ansible Automation Platform](https://developers.redhat.com/products/ansible/overview) is a foundation for building and operating automation across an organization. The platform includes all the tools needed to implement enterprise-wide automation, including CI/CD pipelines.



## Logging into the Cluster via CLI

When the OpenShift environment is created you will be logged in initially as
a cluster admin by using the following command :

```
oc login -u admin -p admin https://api.crc.testing:6443
```
Check user
```
oc whoami
```

This will allow you to perform operations that would normally be performed by a cluster admin.


## Create a Project

To create a new project called ``dev-game-app`` run the command:

```
oc new-project dev-game-app
```

## Logging into the Cluster via Dashboard

This can be done by clicking the *Web Console* tab near the top of your screen.

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




## **Installing Ansible Automation Platform**

Login to OpenShift Web Console using admin account.

- Go to the OperatorHub and search for the "Ansible Automation Platform" operator.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_search.png?raw=true)

- Click on Install

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_install_button2.png?raw=true)

Once Ansible Automation Platform Operator is installed, you can optionally verify that from CLI by running the command
```
oc get operators
```
This should have the following output.

```
NAME                                                                     AGE
ansible-automation-platform-operator.ansible-automation-platform         25m
```
Finally, you can verify the installation by running

```
oc get pods -n aap
```
You will get something similar to the following output.

```
NAME                                                              READY   STATUS    RESTARTS        AGE
automation-controller-operator-controller-manager-5dbc9d88k4hh5   2/2     Running   0               12m
automation-hub-operator-controller-manager-668769dc9-2tmsc        2/2     Running   0               12m
resource-operator-controller-manager-57b5b58667-phmlh             2/2     Running   0               12m
```

Next to configure Ansible Automation Platform create an instance of **Automation controller** from the installed operator.

Go to installed operators you will get Ansible Automation Platform there click on it. A couple of options will appear from that select the  **Automation Controller** click on & create Automation Controller. Give a name to the automation controller. change example to  **cd-ansible**

Leave everything default & click on create.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_controller_install.png?raw=true)

[NOTE: Installation may take some time 5-10 Min.]

- verify automation controller pods running.
```
oc get pods -n aap
```

You will get something similar to the following output.
```
NAME                                                              READY   STATUS    RESTARTS        AGE
automation-controller-operator-controller-manager-5dbc9d88k4hh5   2/2     Running   0               12m
automation-hub-operator-controller-manager-668769dc9-2tmsc        2/2     Running   0               12m
cd-ansible-7bb7b7b4c5-xn546                                       4/4     Running   0               12m
cd-ansible-postgres-13-0                                          1/1     Running   0               12m
resource-operator-controller-manager-57b5b58667-phmlh             2/2     Running   0               12m
```

To get UI of Ansible Automation Platform. We need to run a few commands.

```
export SA_SECRET=cd-ansible
```
here my automation controller name id **cd-ansible**. Please replace the name with your automation controller name.

```
oc get route  -n aap | grep $(echo ${SA_SECRET}) | awk '{print$2}'
```
After running this command you get a result like below

```
cd-ansible-ansible-automation-platform.apps.xdv2l3h5.centralindia.aroapp.io
```
Copy the HOST endpoint & paste in the browser.

This may take some time to start about 5-10 min.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_login.png?raw=true)

You will then be able to login with admin permissions with the:

 - Username: ```admin```
 - Password:


To grab the password of Ansible Automation Platform, from Terminal we need to extract the password from secret.

```
oc  get secret $SA_SECRET-admin-password  -o jsonpath='{.data.password}' -n aap | base64 --decode
```
You will get the password.

Paste it on the ansible automation platform login page.

Here you have to select the username/password option to fill in your details.
Add your redhat account to get subscription to Ansible Automation platform.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_redhat_login.png?raw=true)

Click on  **Get Subscription**

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_subcription_select.png?raw=true)
Select the subscription of `16` node.
![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_submit_button_dash.png?raw=true)
Now click on submit button.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_after_login.png?raw=true)


