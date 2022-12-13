---
slug: step7
id: s12fzgwuixu7
type: challenge
title: Update the CockroachDB Custom Resource
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
Let's now update the CockroachDB `example` Custom Resource and increase the desired number of replicas to `3`:

```
oc patch cockroachdb cockroachdb-sample --type='json' -p '[{"op": "replace", "path": "/spec/statefulset/replicas", "value":3}]'
```

Verify that the CockroachDB Stateful Set is creating two additional pods:

```
oc get pods -l app.kubernetes.io/component=cockroachdb
```

The CockroachDB UI should now reflect these additional nodes as well.
