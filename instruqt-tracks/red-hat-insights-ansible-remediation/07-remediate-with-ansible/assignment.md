---
slug: remediate-with-ansible
id: yxafs5mlicps
type: challenge
title: Remediate with Ansible
teaser: In this challenge, we will use Ansible to remotely perform package remediation
  on the host.
notes:
- type: text
  contents: |
    In this challenge, we will remediate a Red Hat Insights identified package update remotely using Ansible.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Console
  type: browser
  hostname: console
difficulty: ""
---
## Identify package to be updated
-  Click on the `Console` tab and navigate to **Services** > **Inventories** > **Inventory**.
![console-inventory-menu.png](..\assets\console-inventory-menu.png)
-  In the **Systems** table, find the hostname for your host and click on it.
-  Click on the **Patch** tab.
-  A list of recommended advisories for packages will be listed as shown below.
![console-host-patch-packages.png](..\assets\console-host-patch-packages.png)

## Create Ansible Playbook to remediate packages
- Select any advisory for package update that you would like to remediate. For the purpose of this lab, preferably choose one that does not require reboot.
![console-host-patch-packages-select.png](..\assets\console-host-patch-packages-select.png)
- Click on the `Remediate` button to start the process.
- In the Remediation dialog, select **Create new playbook** and enter a name such as **Remediate nghttp2 package**. Click `Next` to continue.
![console-remediate-playbook.png](..\assets\console-remediate-playbook.png)
- Ensure the right host is selected in the **Review systems** screen. In practice, multiple hosts can be remediated at the same time.
![console-remediate-review-systems.png](..\assets\console-remediate-review-systems.png)
- Hosts can be restarted automatically if needed during the remediation process. For the purpose of this lab, click on **Turn off autoreboot** to disable automatic restart.
![console-remediate-submit.png](..\assets\console-remediate-submit.png)
- Click `Submit` to create the playbook.
- In the next screen, click on the playbook name to view the playbook.
![console-remediate-result.png](..\assets\console-remediate-result.png)

## Execute Ansible Playbook to apply remediation
- Click on `Execute playbook` to start the remediation process.
![console-playbook-execute.png](..\assets\console-playbook-execute.png)
- The confirmation screen will show if a direct connection is available to perform remediation.
![console-playbook-execute-confirm.png](..\assets\console-playbook-execute-confirm.png)
- Click `Execute playbook on 1 system` to perform remote remediation.
- The current status of the running task can be seen in the **Latest Activity** section.
![console-playbook-execute-status.png](..\assets\console-playbook-execute-status.png)
- The remediation process might take a couple of minutes to execute. Once completed, the status of the remediation activity will change to **Succeeded** as shown below.
![console-remediate-success.png](..\assets\console-remediate-success.png)

## Verify package update status in Red Hat Insights
- Click on the `Console` tab and navigate to **Services** > **Inventories** > **Inventory**.
- Click on the hostname for your host to see host information.
- Click on the **Patch** tab.
- Verify the package is no longer listed in the advisories list.
![console-host-patch-packages-after.png](..\assets\console-host-patch-packages-after.png)
- Since we have successfully applied the remediation, it no longer shows up in the list of advisories.

Note: Sometimes Red Hat Insights Client might not run immediately to update the changed status of the packages. In such cases, a manual refresh can be triggered by running the following command.
```
insights-client
```

**Congratulations!** You have successfully completed the lab.

Click `Next` to finish the lab.


