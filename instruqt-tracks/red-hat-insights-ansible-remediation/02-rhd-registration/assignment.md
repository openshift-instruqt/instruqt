---
slug: rhd-registration
id: udiehz8degwo
type: challenge
title: Register at Red Hat Developer Portal
teaser: Register at the Red Hat Developer Portal.
notes:
- type: text
  contents: In this challenge, we will register with the Red Hat Developer Portal
    and Red Hat Console which provides access to all Red Hat services in one location.
    We will also verify access and version of the test host that will be used in the
    lab.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Console
  type: browser
  hostname: console
difficulty: ""
---
## Register with Red Hat Developer
- Click on the `Console` tab.
- If you have registered with Red Hat earlier, use your credentials to complete the registration process. Alternatively, register for a free account to access Red Hat product trials and technical content.

## Verify host access & version
- A virtual machine with RHEL 9+ has been provided for this demo.
- Click on the `Terminal` tab. This should provide you terminal access to the host.
- To see the installed version of RHEL use the following command.
```
 cat /etc/redhat-release
 ```
Click `Next` to continue to the next challenge.
