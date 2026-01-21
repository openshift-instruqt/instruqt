---
slug: selinux-modes
id: 0eodsxi9otyv
type: challenge
title: SELinux modes
notes:
- type: text
  contents: '## Register RHEL host using ''subscription-manager'' and verify status
    of SELinux.'
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Console
  type: browser
  hostname: console
difficulty: ""
---
## Add Red Hat Subscription to host
- To view the current subscription status of host.
 ```
 subscription-manager status
 ```
- Register the host using following command.
```
subscription-manager register
```
> [!IMPORTANT]
> If the subscription-manager registration fails, please proceed to the **console** tab, log in, and complete the form.
> Thereafter, attempt to register the host with subscription-manager again.

- Attach the subscription to the server using the command below.
```
subscription-manager attach
```
## Explore SELinux modes
SELinux operates in three distinct modes: Enforcing, Permissive, and Disabled.

- **Enforcing**: In this mode, SELinux actively enforces the defined security policies. Any violation triggers an immediate response, such as blocking unauthorized access or generating an alert.
- **Permissive**: In permissive mode, SELinux logs violations while enforcing policies and without actively blocking them. This mode is useful for identifying policy gaps before transitioning to full enforcement.
- **Disabled**: SELinux is turned off in disabled mode, and DAC becomes the primary access control mechanism. While this might be necessary for specific legacy applications, it's not recommended for systems requiring strong security.

To check the current SELinux status
```
sestatus
```

You will receive similar results on your terminal as shown below.
```
SELinux status:                 enabled
SELinuxfs mount:                /sys/fs/selinux
SELinux root directory:         /etc/selinux
Loaded policy name:             targeted
Current mode:                   enforcing
Mode from config file:          enforcing
```

To make permanent changes, you have to configure the file located at /etc/selinux/config.
```
cat /etc/selinux/config
```
By default, SELinux in RHEL is set to **enforcing** mode, and the type is set to **targeted**, as shown below
```
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - No SELinux policy is loaded.
SELINUX=enforcing
# SELINUXTYPE= can take one of these two values:
#       targeted - Targeted processes are protected,
#       mls - Multi Level Security protection.
SELINUXTYPE=targeted
```

After successful registration and exploration of SELinux modes, click on the **check** button.