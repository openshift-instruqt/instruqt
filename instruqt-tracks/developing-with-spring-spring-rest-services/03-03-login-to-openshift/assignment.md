---
slug: 03-login-to-openshift
id: z3wwo32proiy
type: challenge
title: Step 3
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/spring-rest-services
- title: OpenShift Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 1000
---
# Login and Deploy to OpenShift Container Platform

**Red Hat OpenShift Container Platform** is the preferred runtime for **Red Hat Runtimes** like **Spring Boot**, **Vert.x**, etc. The OpenShift Container Platform is based on **Kubernetes** which is a Container Orchestrator that has grown in popularity and adoption over the last years. **OpenShift** is currently the only container platform based on Kubernetes that offers multitenancy. This means that developers can have their own personal, isolated projects to test and verify applications before committing to a shared code repository.

OpenShift also ships with a feature rich web console as well as command line tools to provide users with a friendly interface to work with applications deployed to the platform.

**1. Login to the OpenShift Container Platform**

Run the following command in Terminal 1 to login with the OpenShift CLI:

```
oc login -u admin -p admin
```

You should see:

```bash
Login successful.
You don't have any projects. You can try to create a new project, by running `oc new-project <projectname>`
```

Then you'll create the project:

```
oc new-project dev --display-name="Dev - Spring Boot App"
```

Now create a database:

```
oc new-app -e POSTGRESQL_USER=dev \
          -e POSTGRESQL_PASSWORD=secret \
          -e POSTGRESQL_DATABASE=my_data \
          openshift/postgresql:12-el8 \
          --name=my-database
```

Our application knows how to interact with the database because you defined the properties in the `src/main/resources/application-openshift.properties` file. You can see below that the URL, username, password, and driver for the database have been supplied.

```text
spring.datasource.url=jdbc:postgresql://${MY_DATABASE_SERVICE_HOST}:${MY_DATABASE_SERVICE_PORT}/my_data
spring.datasource.username=${DB_USERNAME}
spring.datasource.password=${DB_PASSWORD}
spring.datasource.driver-class-name=org.postgresql.Driver
spring.jpa.hibernate.ddl-auto=create
```

Save the file.

Run the following command to deploy the application to OpenShift in Terminal 1:

```
mvn package oc:deploy -Popenshift -DskipTests -f /root/projects/rhoar-getting-started/spring/spring-rest-services
```

This step may take some time to do the Maven build and the OpenShift deployment. After the build completes you can verify that everything is started by running the following command:

```
oc rollout status dc/spring-rest-services
```

After the rollout is complete you can go to the OpenShift web console, login with **admin**/**admin** credentials, select **dev** project and find the route to your application under **Routes**.

OpenShift ships with a web-based console that will allow users to perform various tasks via a browser.

Click on `OpenShift Web Console` tab then, login using the following credentials from the Web using.

*Note* that you might see *Your connection is not private* notification due to using an untrusted security certificate. Then, proceed to access the OpenShift web console via clicking *Advanced* option.

* Username:
```
admin
```

* Password:
```
admin
```

![Web Console Login](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/quarkus/login.png)

Run **Skip Tour** to skip the new user introduction, you will be presented with a list of projects that your user has permission to view.

![Route from Web Console](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-spring-rest-services/rest-web-openshift.png)

# Open the solution in an IDE in the Cloud!
Want to continue exploring this solution on your own in the cloud? You can use the free [Red Hat CodeReady Workspaces](https://developers.redhat.com/products/codeready-workspaces/overview) IDE running on the free [Red Hat Developer Sandbox](http://red.ht/dev-sandbox). [Click here](https://workspaces.openshift.com) to login or to register if you are a new user. This free service expires after 30 days, but you can always enable a new free 30-day subscription.

Once logged in, [click here](https://workspaces.openshift.com/f?url=https://raw.githubusercontent.com/openshift-katacoda/rhoar-getting-started/solution/spring/spring-rest-services/devfile.yaml) to open the solution for this project in the cloud IDE. While loading, if it asks you to update or install any plugins, you can say no.

## Congratulations

You have now learned how to deploy a RESTful Spring Boot application to OpenShift Container Platform.

You'll find additional resources and other suggested scenarios in the next page.