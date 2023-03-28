---
slug: aap-installation-login
id: i2r2g73o7xga
type: challenge
title: Step 1 - Ansible Automation platform Installation & Login
notes:
- type: text
  contents: |+
    # Goal

    CI/CD with the Ansible Automation Platform and Jenkins on OpenShift

    ![architecturediagram](https://raw.githubusercontent.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/main/assets/ansible_final1.jpg)

    A subset of application deployment, continuous deployment pipelines help developers release new software features and updates more frequently to support modern business demands. Red Hat Ansible Automation Platform provides the multi-tier, multi-step application orchestration needed for fast, reliable deployment of new features, bug fixes, and code changes while reducing the need for human intervention throughout the release process.

    This Instruqt track provides hands-on experience in deploying a CI/CD pipeline using Ansible Automation Platform and Jenkins on OpenShift.

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

[Continuous integration/continuous deployment (CI/CD) approaches](https://www.redhat.com/en/topics/devops/what-is-ci-cd) can help developers rapidly build, test, and deliver high-quality applications. CI/CD applies automation throughout the application lifecycle, from the integration and testing phases to delivery and deployment, to quickly produce tested, verified applications. Let us understand the two phases:

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

You can login as the `admin` user. Use the following credentials:

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

Log in to the OpenShift Web Console using the admin account.

- Go to the OperatorHub and search for the "Ansible Automation Platform" operator.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_search.png?raw=true)

- Click on "Install."

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_install_button2.png?raw=true)

Once the Ansible Automation Platform Operator is installed, you can optionally verify so from the CLI by running the command:

```
oc get operators
```

This should produce the following output:

```
NAME                                                                     AGE
ansible-automation-platform-operator.ansible-automation-platform         25m
```

Finally, you can verify the installation by running:

```
oc get pods -n aap
```

You will receive something similar to the following output:

```
NAME                                                              READY   STATUS    RESTARTS        AGE
automation-controller-operator-controller-manager-5dbc9d88k4hh5   2/2     Running   0               12m
automation-hub-operator-controller-manager-668769dc9-2tmsc        2/2     Running   0               12m
resource-operator-controller-manager-57b5b58667-phmlh             2/2     Running   0               12m
```

Next, to configure Ansible Automation Platform, create an instance of **Automation Controller** from the installed operator.

Go to installed operators; you will find Ansible Automation Platform there. Click on it. A couple of options will appear; select **Automation Controller**, click on it, and create an Automation Controller. Give a name to the automation controller. Change "example" to **cd-ansible**.

Leave everything default & click on create.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_controller_install.png?raw=true)

[NOTE: Installation may take some time, approx. 5-10 Min.]

Now, verify the automation controller pods are running:
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

To access the UI of the Ansible Automation Platform, we need to run a few commands:

```
export SA_SECRET=cd-ansible
```
Here, my automation controller name is **cd-ansible**. Please replace the name with your automation controller name.

```
oc get route -n aap | grep $(echo ${SA_SECRET}) | awk '{print$2}'
```
After running this command, you will get a result like the one below:

```
cd-ansible-ansible-automation-platform.apps.xdv2l3h5.centralindia.aroapp.io
```
Copy the HOST endpoint and paste it in your browser.

This may take some time to start, about 5-10 minutes.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_login.png?raw=true)

You will then be able to log in with admin permissions using:

 - Username: ```admin```
 - Password:


To retrieve the password for Ansible Automation Platform from Terminal, we need to extract it from the secret.

```
oc get secret $SA_SECRET-admin-password -o jsonpath='{.data.password}' -n aap | base64 --decode
```
You will receive the password.

Paste it on the Ansible Automation Platform login page.

Here, you have to select the username/password option and fill in your details.
Add your Red Hat account to subscribe to Ansible Automation Platform.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_redhat_login.png?raw=true)

Click on **Get Subscription**

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_subcription_select.png?raw=true)

Select the subscription of a `16` node.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_submit_button_dash.png?raw=true)

Now, click on submit button.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/aap_after_login.png?raw=true)

On the next step, we'll take a look at configuration of the Ansible Automation Platform.


