---
slug: create-pod
id: 7cyqyx3tvuey
type: challenge
title: Step 3 - Create a Pod
notes:
- type: text
  contents: In this step you will learn how create a new Pod
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Visual Editor
  type: code
  hostname: container
  path: /root/
difficulty: basic
timelimit: 300
---
Using the *Visual Editor* tab, view the YAML of `/root/simple-pod.yaml`.

Now let's create a new Pod:

```
oc create -f /root/simple-pod.yaml
```