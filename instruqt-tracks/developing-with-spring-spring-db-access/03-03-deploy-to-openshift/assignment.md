---
slug: 03-deploy-to-openshift
id: jn8qqtqv8xel
type: challenge
title: Step 3
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/spring-db-access
difficulty: basic
timelimit: 1000
---
# Deploy to OpenShift

For running locally the H2 Database has been a good choice, but when we now move into a container platform we want to use a more production-like database, and for that, we are going to use PostgreSQL.

Before we deploy the application to OpenShift and verify that it runs correctly, there are a couple of things we have do. We need to add a driver for the PostgreSQL database that we are going to use, and we also need to add health checks so that OpenShift correctly can detect if our application is working.

**1. Create a project**

Run the following command to login with the OpenShift CLI:

```
oc login -u admin -p admin
```

You should see:

```bash
Login successful.
You don't have any projects. You can try to create a new project, by running `oc new-project <projectname>`
```

Then you'll create the project:

Let's first create a new project

```
oc new-project dev --display-name="Dev - Spring Boot App"
```

**2. Create the database**

Since this is your own personal project you need to create a database instance that your application can connect to. In a shared environment this would typically be provided for you, that's why we are not deploying this as part of your application. It's however very simple to do that in OpenShift. All you need to do is to execute the below command in the console.

```
oc new-app -e POSTGRESQL_USER=dev \
             -e POSTGRESQL_PASSWORD=secret \
             -e POSTGRESQL_DATABASE=my_data \
             openshift/postgresql:12-el8 \
             --name=my-database
```

This command creates a new deployable Postgres instance using the OpenShift Postgresql image named `my-database`. This step may take a minute or two. We can wait for it to complete by running the following command:

```
oc rollout status -w deployment/my-database
```

**3. Review Database configuration**

Take some time and review the `src/main/jkube/deployment.yml` file from the *Visual Editor* Tab.

As you can see that file specifies a couple of elements that are needed for our deployment. It also uses the username and password from a Kubernetes Secret. For this environment we are providing the secret in this file `src/main/jkube/credentials-secret.yml`, however in a production environment this would likely be provided to you by the Ops team.

Now, review the `src/main/resources/application-openshift.properties` file.

In this file we are using the configuration from the `deployment.yml` to read the username, password, and other connection details.

**4. Add the PostgreSQL database driver**

So far our application has only used the H2 embedded Database. We now need to add a dependency for the PostgreSQL driver. We do that by adding a runtime dependency under the `openshift` profile in the `pom.xml` file.

Add this code after the `<!-- TODO: Add PostgreSQL database dependency here -->` line:

```xml
        <dependency>
          <groupId>org.postgresql</groupId>
          <artifactId>postgresql</artifactId>
          <scope>runtime</scope>
        </dependency>
```

**5. Add a health check**

We also need a health check so that OpenShift can detect when our application is responding correctly. Spring Boot provides a nice feature for this called Actuator, which exposes health data under the path `/health`. All we need to do is to add the following dependency to `pom.xml` at the **TODO** comment..

Add this code after the `<!-- TODO: Add Actuator dependency here -->` line:
```xml
    <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-actuator</artifactId>
    </dependency>
```

Save the file.

**6. Deploy the application to OpenShift**

Run the following command to deploy the application to OpenShift

```
mvn oc:deploy -Popenshift -DskipTests -f /root/projects/rhoar-getting-started/spring/spring-db-access
```

This step may take some time to do the Maven build and the OpenShift deployment. After the build completes you can verify that everything is started by running the following command:

```
oc rollout status dc/spring-data-jpa-training
```

Access the web application:

```
oc get routes spring-data-jpa-training -n dev -o jsonpath='{"http://"}{.spec.host}{"\n"}'
```

Copy the URL from the output of the above command then open it in your browser.

Make sure that you can add and remove fruits using the web application.

![Route from Web Console](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-getting-started-spring/jpa-web-openshift.png)

# Open the solution in an IDE in the Cloud!
Want to continue exploring this solution on your own in the cloud? You can use the free [Red Hat CodeReady Workspaces](https://developers.redhat.com/products/codeready-workspaces/overview) IDE running on the free [Red Hat Developer Sandbox](http://red.ht/dev-sandbox). [Click here](https://workspaces.openshift.com) to login or to register if you are a new user. This free service expires after 30 days, but you can always enable a new free 30-day subscription.

Once logged in, [click here](https://workspaces.openshift.com/f?url=https://raw.githubusercontent.com/openshift-katacoda/rhoar-getting-started/solution/spring/spring-db-access/devfile.yaml) to open the solution for this project in the cloud IDE. While loading, if it asks you to update or install any plugins, you can say no.

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
