---
slug: create-service
id: t28fomrsned3
type: challenge
title: Step 4 - Create a Service
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc.${_SANDBOX_ID}.instruqt.io
- title: Visual Editor
  type: code
  hostname: container
  path: /root/
difficulty: basic
timelimit: 300
---
Using the *Visual Editor* tab, view the YAML of `/root/nginx-svc.yaml`.

Now let's create a new Service:
```
oc create -f /root/nginx-svc.yaml
```