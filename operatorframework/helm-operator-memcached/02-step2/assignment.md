---
slug: step2
id: 9giskahf0mgq
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
difficulty: basic
timelimit: 257
---
The `watches.yaml` file maps a Group, Version, and Kind to a specific Helm Chart. Observe the contents of the `watches.yaml`:

```
cd /root/projects/memcached-operator && \
  cat watches.yaml
```