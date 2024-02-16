---
slug: install-connect-rhc-client
id: isrfippzd3ly
type: challenge
title: Install & connect RHC Client
teaser: In this challenge, we will install and connect RHC (Remote Host Configuration)
  Client which will be used for remote remediation via Ansible.
notes:
- type: text
  contents: In this challenge, we will install and connect RHC (Remote Host Configuration)
    Client - a utility provided by Red Hat that assists in remote configuration management
    of the host. This utility will be used to remotely apply remediations using Ansible
    playbooks.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Console
  type: browser
  hostname: console
difficulty: ""
---
## Install RHC Client
-  Click on the `Terminal` tab and install RHC client using the following command.
```
dnf -y install rhc rhc-worker-playbook ansible-core scap-security-guide
```
## Connect RHC Client
-  Enable Red Hat Cloud Connector using the following command.
```
rhc connect
```
- This will enable remote configuration management of the host as shown below.
![rhc-client-connect.png](..\assets\rhc-client-connect.png)

Click `Next` to continue to the next challenge.