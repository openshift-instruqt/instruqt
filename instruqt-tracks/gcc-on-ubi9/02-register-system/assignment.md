---
slug: register-system
id: dfke7iiruily
type: challenge
title: Register system
teaser: Register host with Red Hat Subscription Manager
notes:
- type: text
  contents: In this challenge, we will register the host with the help of a Red Hat
    subscription-manager.
tabs:
- title: Terminal
  type: terminal
  hostname: ubi9
- title: RH portal
  type: browser
  hostname: console
difficulty: ""
---
## Add Red Hat Subscription to host
- To view the current subscription status of host.
 ```
 subscription-manager status
 ```
- Register the host, using following command.
```
subscription-manager register
```
> [!IMPORTANT]
> If the subscription-manager registration fails, please proceed to the **console** tab, log in, and complete the form.
> Please attempt to register the host with subscription-manager again.

After successful registration, click on the **check** button.


