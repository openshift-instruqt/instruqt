---
slug: 05-database
id: ydyvazhz3dg1
type: challenge
title: Externalize the data storage
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/javaee/weather-app
difficulty: intermediate
timelimit: 600
---
So far we have been using an in-memory database that is part of JBoss EAP. However, JBoss EAP only provides this to make it easy to develop and test application. The in-memory database H2 is not recommended for production use.

In this part, you will learn how to setup a simple PostgreSQL database in OpenShift, how to configure a datasource within the JBoss EAP image that connects to the database, and finally how to make use of that database in your application.

**1. Remove the internal in-memory database**

If you recall in step 03 we create a datasource definition as part of the deployment. Let's update it to use PostgresQL.

Open the `src/main/webapp/WEB-INF/weather-ds.xml` file and replace its content for PostgresQL:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<datasources xmlns="http://www.jboss.org/ironjacamar/schema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://www.jboss.org/ironjacamar/schema http://docs.jboss.org/ironjacamar/schema/datasources_1_0.xsd">
  <!-- The datasource is bound into JNDI at this location. We reference
      this in META-INF/persistence.xml -->
  <datasource jndi-name="java:jboss/datasources/WeatherDS"
              pool-name="weather" enabled="true"
              use-java-context="true">
      <connection-url>jdbc:postgresql://weather-postgresql:5432/weather-db</connection-url>
      <driver>postgresql.jar</driver>
      <security>
          <user-name>weather-app-user</user-name>
          <password>secret</password>
      </security>
  </datasource>
</datasources>
```

Save the file.

This configures our app to access the database using a hostname of `weather-postgresql` and corresponding ports, usernames, and password. We'll need to deploy Postgres itself to respond to these connection requests.

**2. Start a PostgreSQL database**

To start a PostgreSQL database in OpenShift we can simply use the image provided as part of the OpenShift distribution.

```
oc new-app -e POSTGRESQL_USER=weather-app-user -e POSTGRESQL_PASSWORD=secret -e POSTGRESQL_DATABASE=weather-db --name=weather-postgresql -l app.openshift.io/runtime=postgresql postgresql:10
```

By using the `-e` flag, we can also pass a set of environment variables that will configure and setup the PostgreSQL database. These environment variables are pretty self explaining. The `-l` flag adds a nice icon to our deployment topology view for the database.

You can see the new database spinning up on the [Topology view](https://console-openshift-console-[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com/topology/ns/my-project/graph):

![Postgres topology view](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-javaee8/postgres-topology.png)

**3. Deploying the application**

We are now ready to test our application in OpenShift using an external database.

First, build the application and verify that we do not have any compilation issues.

```
mvn clean package -f /root/projects/rhoar-getting-started/javaee/weather-app
```

Since EAP does not ship with a Postgres DB driver by default, we'll need to download it and include it with our application. Click the following command to download the driver to the `target/` directory:

```
curl -o /root/projects/rhoar-getting-started/javaee/weather-app/target/postgresql.jar https://jdbc.postgresql.org/download/postgresql-42.2.20.jar
```

Next, build a container by starting an OpenShift S2I build and provide the files as input.

```
oc start-build weather-app --from-dir=/root/projects/rhoar-getting-started/javaee/weather-app/target/ --follow
```

When the build has finished, you can test the REST endpoint directly using for example curl:

```bash
curl -s $APP_URL | jq
```

> **Note:** that it might take a couple of seconds for the application to start so if the command fails at first, please try again.

You should see the same output as before.

You can also test the web application by clicking the route link in OpenShift Web Console.

Note: that it might take a couple of seconds for the application to start so if you see an error page wait 30 secs and then try again.

**4. Verify the database**

Open [this](http://weather-app-my-project.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/index.html) link and click on the US flag. Note the weather icon in New York. It should be sunny:

![Sunny](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-javaee8/sunny.png)

Let's update the database and set it to rainy instead.

```
oc rsh deployment/weather-postgresql
```

```
psql -U $POSTGRESQL_USER $POSTGRESQL_DATABASE -c "update city set weathertype='rainy-5' where id='nyc'";
```

Now, reload the weather page for US and check the weather icon in New York. It should now be rainy.

![Rainy](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-javaee8/rainy.png)
