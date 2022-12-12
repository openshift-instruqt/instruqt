---
slug: step5
id: wvfjnrudgycz
type: challenge
title: Access the CockroachDB Web UI
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
Verify that you can access the CockroachDB Web UI by first exposing the CockroachDB Service as a publicly accessible OpenShift Route:

```
COCKROACHDB_PUBLIC_SERVICE=`oc get svc -o jsonpath={$.items[1].metadata.name}`
oc expose --port=http svc $COCKROACHDB_PUBLIC_SERVICE
```

Fetch the OpenShift Route URL and copy/paste it into your browser:

```
COCKROACHDB_UI_URL=`oc get route -o jsonpath={$.items[0].spec.host}`
echo $COCKROACHDB_UI_URL
```