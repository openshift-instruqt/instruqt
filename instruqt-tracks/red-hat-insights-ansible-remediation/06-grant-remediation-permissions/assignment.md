---
slug: grant-remediation-permissions
id: nz7wuqcdoqol
type: challenge
title: Grant remediation permissions
teaser: In this challenge, we will use IAM functionality of Red Hat Console to grant
  remediation permissions to your user account.
notes:
- type: text
  contents: |
    In this challenge, we will grant permissions for executing remediations remotely using the Red Hat Console.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Console
  type: browser
  hostname: console
difficulty: ""
---
## Create a custom Group to grant access
- Click on the `Console` tab and navigate to **Services** > **Identity and Access Management** > **Groups**.
![console-iam-groups.png](..\assets\console-iam-groups.png)
- Click on `Create Group`.
- Enter a group name, for example **Remediation Executors** and click `Next`.
- In the **Add Roles** screen select **Remediations administrator** and click `Next`.
![console-iam-groups-roles.png](..\assets\console-iam-groups-roles.png)
- In the **Add members** screen select your username and click `Next`.
- Click `Submit` to create the new Group.
- Click `Exit` to close the Group confirmation screen.

This should assign the remediation executor permission to your user account.

Click `Next` to continue to the next challenge.


