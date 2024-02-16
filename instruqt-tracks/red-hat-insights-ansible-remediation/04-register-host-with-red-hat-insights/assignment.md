---
slug: register-host-with-red-hat-insights
id: 7t5a1we0fljf
type: challenge
title: Register host with Red Hat Insights
teaser: In this challenge, we will register our host with Red Hat Insights
notes:
- type: text
  contents: |
    In this challenge, we will register the host with Red Hat Insights, which will enable us to use Red Hat Insights and Console to gather host configuration information and assess if any remediation is required.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Console
  type: browser
  hostname: console
difficulty: ""
---
## Install Red Hat Insights Client
-  Click on the `Terminal` tab and install Red Hat Insights Client using the following command.
```
dnf -y install insights-client
```
## Add host to Red Hat Insights
- Initiate the registration process with Red Hat Insights using the following command.
```
insights-client --register
```
- After registration is complete, Red Hat Insights will analyse the host and gather critical information to assess vulnerabilities and compliance. This information is sent to Red Hat and will be accessible via the Console.
![insights-client-register.png](..\assets\insights-client-register.png)

## Check host status in Red Hat Insights
- Click on the `Console` tab. Red Hat Console has been pre-opened for you. Red Hat Console is accessible anytime from https://console.redhat.com.
- Login using your credentials.
- Navigate to **Services** > **Inventories** > **Inventory**.
- The systems inventory page will display all registered systems with Red Hat Insights.
- Ensure you see this lab's hostname in the table.
![console-inventory-systems.png](..\assets\console-inventory-systems.png)
- Clicking on the hostname will display further details of the host including general information, vulnerability report, patch report, etc.
![console-inventory-system-details.png](..\assets\console-inventory-system-details.png)
- Navigate the various tabs and explore detailed information provided by Red Hat Insights for the host.
- This information can be used for compliance, remediation or host management.
- Remediation can be done manually via the host or remotely using Ansible.
- In the next challenge, we will use Red Hat Console & Ansible to remotely remediate packages.

Click `Check` to continue to the next challenge.
