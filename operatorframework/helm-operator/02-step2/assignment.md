---
slug: step2
id: doczktsdkf4t
type: challenge
title: Update the Watches File
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-dzk9v-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 200
---
The `watches.yaml` file maps a Group, Version, and Kind to a specific Helm Chart. Observe the contents of the `watches.yaml`:

```
cd /root/projects/cockroachdb-operator/ && \
  cat watches.yaml
```