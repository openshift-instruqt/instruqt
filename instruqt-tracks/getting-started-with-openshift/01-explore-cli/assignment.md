---
slug: explore-cli
id: kk7modsnutwk
type: challenge
title: Step 1 - Getting started with OpenShift
notes:
- type: text
  contents: "\U0001F4BB Working with the Command Line\n=============================\n\nLearn
    how to login to OpenShift using the `oc` command"
tabs:
- title: Terminal
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 500
---

💻 Working with the Command Line Interface (CLI)
===============================================

The `oc` command lets you administer your OpenShift cluster and deploy new applications.

The CLI exposes the underlying Kubernetes orchestration system with the enhancements made by OpenShift.

The `oc` command provides all of the functionality of the Kubernetes `kubectl` CLI tool, in addition to specific OpenShift operations.


🔒 Logging in with the CLI
=======================

Log into OpenShift from the command line on the left using the `oc login` command:

```
oc login -u admin -p admin https://api.crc.testing:6443 --insecure-skip-tls-verify=true
```

✅ Login Confirmation
==================

Verify you succesfully logged in as the `admin` user with the `oc whoami` command:

```
oc whoami
```

Select **Next** to create your first project using the **Web Console** ⬇️
