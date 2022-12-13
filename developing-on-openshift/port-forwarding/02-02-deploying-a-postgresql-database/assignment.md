---
slug: 02-deploying-a-postgresql-database
id: zuigvnfkfl1h
type: challenge
title: Topic 2 - Deploying a PostgreSQL database
notes:
- type: text
  contents: Topic 2 - Deploying a PostgreSQL database using the OpenShift `oc new-app`
    command
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 225
---

In this topic you will learn how to create a new application named `postgresql-ephemeral` by using the command `oc new-app`.

----

`Step 1:` Run the following command at the terminal to the left to create a new application that uses a Postgres database named `sampledb`.

```
oc new-app postgresql-ephemeral --name database --param DATABASE_SERVICE_NAME=database --param POSTGRESQL_DATABASE=sampledb --param POSTGRESQL_USER=username --param POSTGRESQL_PASSWORD=password
```

The snippet below shows you some of the output you'll get when you run the `oc new-app` command.

```
.
.
.
--> Creating resources ...
    secret "database" created
    service "database" created
    deploymentconfig.apps.openshift.io "database" created
--> Success
    Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
     'oc expose service/database'
    Run 'oc status' to view your app.
```

Although a database would normally be paired with an [OpenShift persistent volume](https://docs.openshift.com/container-platform/3.11/dev_guide/persistent_volumes.html), the scope of this track is to demonstrate how to access the database in general.

The database instance you've created here only stores the database's data in the filesystem local to the container within the database **pod**.

This means that when the database restarts, all data changes will be lost. Clearly this is not a real-world approach to keeping data persistent within an OpenShift cluster. The remedy is to use actual persistent volumes when deploying applications that need to have an underlying database.

----

`Step 2:` Run the following command to monitor the progress of the application as the database gets deployed and is made ready for use.

```
oc rollout status dc/database
```

You'll get output similar to the following.

```
Waiting for rollout to finish: 0 of 1 updated replicas are available...
Waiting for latest deployment config spec to be observed by the controller loop...
replication controller "database-1" successfully rolled out
```

The command will exit once the database is ready to be used.

When using a database with your front-end web application, you need to configure the web application to know about the database. We will skip that in this course.

# Congratulations!

You just learned to how to create a new OpenShift application that's deployed with a Postgres database.

----

**NEXT:** Accessing an interactive shell