---
slug: 04-cdi
id: jaeln22uhtvz
type: challenge
title: Basics of CDI
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
**1. What is CDI**

CDI, aka Context Dependency Injection, is the core dependency injection framework of the Jakarta EE platform. It provides a uniform architecture for dependency injection and the life cycle management of managed beans. CDI is sometimes compared to Spring Dependency Injection, and it has a lot of similar features, but CDI is tightly integrated with Jakarta EE and is used by many other specifications too, for example, enable control over producing EntityManager from JPA and other resources like JMS queues, etc.

**2. Enable CDI**
To activate CDI we need to create a beans archive and include beans.xml file in the META-INF directory of the classpath. Let's add an empty beans.xml file.

Create a `src/main/webapp/WEB-INF/beans.xml` file then, copy the following content.

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://xmlns.jcp.org/xml/ns/javaee" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
      xsi:schemaLocation="
      http://xmlns.jcp.org/xml/ns/javaee
      http://xmlns.jcp.org/xml/ns/javaee/beans_1_1.xsd"
      bean-discovery-mode="all">
</beans>
```

Save the file.

**3. Let the user select the country**

The application already has a session scoped bean `src/main/java/com/redhat/example/weather/SelectedCountry.java` that can store the users last selected country. The storage is temporary and will be removed as soon as the user closes the browser or the session times out.

To change country the user clicks on one of the flags, it will trigger an HTTP PUT call to `/api/country/{code}` where the code is the country code. We, therefore, need to implement a REST service that updates the selected country.

Open `src/main/java/com/redhat/example/weather/CountryService.java`.

Using CDI we can inject a reference to the SelectedCountry. Since the selected country is annotated with @SessionScope we don't have to care about retrieving a HttpSession object or similar. Instead, we can safely assume that an update to the selected country object will be kept in the user's session.

```java
    @Inject
    SelectedCountry selectedCountry;
```

We can now create a rest service that allows the user to set the country of choice. Our REST service needs to be annotated with @PUT and since the `RestApplication` defines a base path to `/api` and the `CountryService` defines a path of `country` we only need to add a @Path annotation specifying `{code}`. The brackets tell JAX-RS that this is a path parameter and that it will match to any request matching `/api/country/*`. Our rest service should look like this:

```java
    @PUT
    @Path("/{code}")
    public void setSelectedCountry(@PathParam("code") String countryCode) {
        selectedCountry.setCode(countryCode);
    }
```

Save the file.

We are now ready to extend the `WeatherService` class to make use of the user selected country instead of hard-coding the country id.

Open  `src/main/java/com/redhat/example/weather/WeatherService.java` and inject the user selected country.

```java
    @Inject
    SelectedCountry selectedCountry;
```

Then we can replace the hardcoded value of "en" and instead invoke.

```java
selectedCountry.getCode()
```

Save the file.

That's it. Now, as soon as we have deployed the app, users can dynamically change the country by just clicking one of the flags.

**6. Deploy the application**

We are now ready to test our application in OpenShift.

First, build the application and verify that we do not have any compilation issues.

```
mvn clean package -f /root/projects/rhoar-getting-started/javaee/weather-app
```

This command produces a WAR file called ROOT.war under the target directory.

Next, build a container by starting an OpenShift S2I build and provide the WAR file as input.

```
oc start-build weather-app --from-file=/root/projects/rhoar-getting-started/javaee/weather-app/target/ROOT.war --follow
```

When the build has finished, you can test the REST endpoint directly using for example curl.

```bash
curl -s $APP_URL | jq
```

> **Note:** that it might take a couple of seconds for the application to start so if the command fails at first, please try again.

You should see the same output as before.

You can also test the web application by clicking the route link in OpenShift Web Console.

Verify that you can change the cities shown by clicking the different flags.
