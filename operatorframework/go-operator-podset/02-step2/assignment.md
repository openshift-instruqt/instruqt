---
slug: step2
id: dzsv1ngmnmyg
type: challenge
title: Creating the API and Controller
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Terminal 2
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root/projects/podset-operator
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-dzk9v-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 800
---
Add a new Custom Resource Definition (CRD) API called PodSet with APIVersion `app.example.com/v1alpha1` and Kind `PodSet`. This command will also create our boilerplate controller logic and [Kustomize](https://kustomize.io) configuration files.

```
cd /root/projects/podset-operator && \
  operator-sdk create api --group=app --version=v1alpha1 --kind=PodSet --resource --controller
```

We should now see the `/api`, `/config`, and `/controllers` directories.
