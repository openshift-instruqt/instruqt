---
slug: new-project
id: 74iatcl4ek5c
type: challenge
title: Step 2 - Create a new Project
notes:
- type: text
  contents: In this step you will learn how create a new project
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 300
---
Now let's create a new project where to work with:

```
oc new-project myproject
```