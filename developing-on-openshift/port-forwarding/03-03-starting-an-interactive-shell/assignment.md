---
slug: 03-starting-an-interactive-shell
id: pjxykvpnkonh
type: challenge
title: Topic 3 - Starting an interactive shell
notes:
- type: text
  contents: Topic 3 - Starting an interactive shell
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 2250
---

In this topic you will learn how to connect to an underlying Linux container that's driving the OpenShift application, and then work within an interactive shell within the container.

----

`Step 1:` Run the following command to get the name of the `pod` running the Postgres database that is bound to the OpenShift application created in the previous topic. (You'll get the `pod`'s name to access it in following steps):


```
oc get pods --selector name=database
```

You'll get output similar to the following. However, the actual `NAME` of the pod will differ for you. The `NAME` of the `pod` is created dynamically with the `pod` is created.

```
NAME               READY     STATUS    RESTARTS   AGE
database-1-9xv8n   1/1       Running   0          1m
```
----

`Step 2:` Run the following command to extract the `NAME` of the database `pod` and assign it to an environment variable named `POD`:

```
POD=$(oc get pods --selector name=database -o custom-columns=NAME:.metadata.name --no-headers); echo $POD
```
You'll get a response similar to the following, but your response will be different because the name of the OpenShift pod that hosts the database is created dynamically when the pod is created:

```
database-1-958hf
```

----

`Step 3:` Run the following command using `oc rsh` to access an interactive shell within the container of the `pod` running the application's database.

```
oc rsh $POD
```

You'll get a response similar to the following which is a command line prompt within the container running the database.

`sh-4.4$`



----

`Step 3:` Run the `ps x` command to list all of the processes not running in the terminal, and then pipe the results to `grep` to filter out those responses that have the term `postgres`:

```
ps x | grep postgres
```

You get output similar to the following that indicates that Postgres is running:

```
1 ?         Ss     0:00 postgres
58 ?        Ss     0:00 postgres: logger process
60 ?        Ss     0:00 postgres: checkpointer process
61 ?        Ss     0:00 postgres: writer process
62 ?        Ss     0:00 postgres: wal writer process
63 ?        Ss     0:00 postgres: autovacuum launcher process
64 ?        Ss     0:00 postgres: stats collector process
65 ?        Ss     0:00 postgres: bgworker: logical replication launcher
954 pts/0   S+     0:00 grep postgres
```

At this point you are in the Linux container hosting the database. In the following steps, you will work with the Postgres `psql` client provided with the database as part of the installation process.

----

`Step 4:` Run the following `psql` command to log into the underlying Postgres database named `sampledb`. (Remember, you are running this command within a shell in the Linux container):

```
psql sampledb username
```

The output will report that you at a command line within the Postgres client:

```
psql (10.17)
Type "help" for help.

sampledb=>
```

Notice that you can now see the `sampledb=>` command line prompt provided the Postgress database.
----

`Step 5:` Run the following command at the Postgres database server prompt (`sampledb=>`) to get a list of running Postgres databases:

```
 \l
```

You'll get output similar to the following:

```
                                 List of databases
   Name    |  Owner   | Encoding |  Collate   |   Ctype    |   Access privileges
-----------+----------+----------+------------+------------+-----------------------
 postgres  | postgres | UTF8     | en_US.utf8 | en_US.utf8 |
 sampledb  | username | UTF8     | en_US.utf8 | en_US.utf8 |
 template0 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
 template1 | postgres | UTF8     | en_US.utf8 | en_US.utf8 | =c/postgres          +
           |          |          |            |            | postgres=CTc/postgres
```

As you can see, you are now operating within a Postgres database.
----

`Step 6:` Run the following command at the Postgres command line prompt (`sampledb=>`) to quit the database server:


```
\q
```

You'll be taken to the command line prompt within the Linux container, like so:

```
sh-4.4$
```

----

`Step 7:` Run the following command at the Linux container's shell prompt to exit the Linux container:

```
exit
```

**NOTE:** In the steps above, you used a console-based client tool to work with a database within a `pod`'s database server. However, be advused that you **cannot** use a GUI-based tool running on your local machine to work with the database. This is because the database is private to the OpenShift cluster.

Should you need to run database script files to perform operations on the database, you will need to use the `oc rsync` command to copy those files into the Linux container hosting the database.

In the next topic you will learn how to use port forwarding to expose the database pod to public access.

# Congratulations!

You've just learned to access an interactive shell with the Linux container with the database `pod` in OpenShift. Also, you learned how to access the Postgres database server within the Linux container in order to use the Postgres client to work with the database server.

----

**NEXT:** Creating a remote connection