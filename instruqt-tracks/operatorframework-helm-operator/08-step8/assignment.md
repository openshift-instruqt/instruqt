---
slug: step8
id: aawbgwx61nyp
type: challenge
title: Test CockroachDB Cluster Failover
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
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 200
---
If any CockroachDB member fails it gets restarted or recreated automatically by the Kubernetes infrastructure, and will rejoin the cluster automatically when it comes back up. You can test this scenario by killing any of the pods:

```
oc delete pods -l app.kubernetes.io/component=cockroachdb
```

Watch the pods respawn:

```
oc get pods -l app.kubernetes.io/component=cockroachdb
```

Confirm that the contents of the database still persist by connecting to the database cluster:

```
COCKROACHDB_PUBLIC_SERVICE=`oc get svc -o jsonpath={$.items[1].metadata.name}`
oc run -it --rm cockroach-client --image=cockroachdb/cockroach --restart=Never --command -- ./cockroach sql --insecure --host $COCKROACHDB_PUBLIC_SERVICE
```

Once you see the SQL prompt, run the following to confirm the database contents are still present:

```
SELECT * FROM bank.accounts;
```

Exit the SQL prompt:
```
\q
```
