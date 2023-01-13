---
slug: step6
id: 2ojhbl0unxtr
type: challenge
title: Connect to the CockroachDB Cluster
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
Let's talk to the CockroachDB cluster by connecting to the service from within the cluster. CockroachDB is PostgreSQL wire protocol compatible so there's a wide variety of supported clients. For the sake of example, we'll open up a SQL shell using CockroachDB's built-in shell and play around with it a bit.

```
oc run -it --rm cockroach-client --image=cockroachdb/cockroach --restart=Never --command -- ./cockroach sql --insecure --host $COCKROACHDB_PUBLIC_SERVICE
```

Once you see the SQL prompt, run the following to show the default databases:

```
SHOW DATABASES;
```

Create a new database called `bank` and populate a table with arbitrary values:

```
CREATE DATABASE bank;
CREATE TABLE bank.accounts (id INT PRIMARY KEY, balance DECIMAL);
INSERT INTO bank.accounts VALUES (1234, 10000.50);
```

Verify the table and values were successfully created:

```
SELECT * FROM bank.accounts;
```

Exit the SQL prompt:
```
\q
```
