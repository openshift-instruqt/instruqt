---
slug: 01-review-the-initial-project
id: bxbrzrrsyipp
type: challenge
title: Step 1
notes:
- type: text
  contents: In this scenario you will learn more about developing Spring Boot applications
    using the [Red Hat Runtimes](https://www.redhat.com/en/products/runtimes) platform.
    You will learn about how OpenShift uses monitoring tools to keep your application
    running / notify you when something unrecoverable happens through the use of *probes*
    .
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/spring/spring-monitoring
- title: Fruit App
  type: service
  hostname: crc
  path: /fruits
  port: 8080
difficulty: basic
timelimit: 1000
---
# Import the code

Let's refresh the code we'll be using. Run the following command to clone the sample project in Terminal 1:

```
cd /root/projects && rm -rf rhoar-getting-started && git clone https://github.com/openshift-katacoda/rhoar-getting-started && cd rhoar-getting-started/spring/spring-monitoring
```

# Review the base structure of the application

For your convenience, this scenario has been created with a base project using the Java programming language and the Apache Maven build tool.

As you review the content, you will notice that there are a couple **TODO** comments. **Do not remove them!** These comments are used as markers for later exercises in this scenario.  From the *Visual Editor* Tab, open: this file `src/main/java/com/example/service/FruitController.java`. This is our rest controller. We will be adding our logging commands here later in this module.

**1. Test the application locally**

As we develop the application we want to be able to test and verify our change at different stages. One way we can do that locally is by using the `spring-boot` maven plugin.

Run the application by executing the following command in Terminal 1:

```
mvn spring-boot:run
```

Once that's completed, open the *Fruit App* Tab to access the app.

You should now see an HTML page with a `Success` welcome message that looks like this:

![Success](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/rhoar-monitoring/landingPage.png)

If you see this then you've successfully set up the application! If not check the logs in the terminal. Spring Boot adds a couple helper layers to catch common errors and print helpful messages to the console so check for those first.

**2. Stop the application**

Before moving on, click in the terminal window and then press <kbd>CTRL</kbd>+<kbd>C</kbd> to stop the running application!

## Congratulations

You have now successfully executed the first step in this scenario. In the next step we will login to OpenShift and create a new project.
