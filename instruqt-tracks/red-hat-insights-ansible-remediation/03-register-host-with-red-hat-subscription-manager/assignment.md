---
slug: register-host-with-red-hat-subscription-manager
id: qtqxbgqvhdhg
type: challenge
title: Register host with Red Hat Subscription Manager
teaser: In this challenge, we will register our host with the Red Hat Subscription
  Manager.
notes:
- type: text
  contents: |
    In this challenge, we will add a Red Hat Subscription to our host, which will enable us to use Red Hat Insights and Console to gather host configuration information and assess if any remediation is required.
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Console
  type: browser
  hostname: console
difficulty: ""
---
## Verify host name
-  This system has been assigned a random hostname.
-  Click on the `Terminal` tab and verify the host name using the following command
```
hostname
```
- Make a note of this hostname as it will be used later in this lab.

## Add Red Hat Subscription to host
- To view the current subscription status, type the following command.
 ```
 subscription-manager status
 ```
- The resultant output will show "Unknown" status since we haven't yet registered the host.
![subscription-status-before.png](..\assets\subscription-status-before.png)
- To register the host use the following command. You will be prompted to enter your credentials. Enter the credentials you used in the previous challenge to register for the product trial.
```
subscription-manager register
```
- Check the registration status again using the following command.
	```
	subscription-manager status
	```
- Now that we have registered the host, the status in the output should change to
![subscription-status-after.png](..\assets\subscription-status-after.png)

Click `Check` to continue to the next challenge.