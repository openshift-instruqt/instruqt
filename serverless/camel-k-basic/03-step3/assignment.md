---
slug: step3
id: pvfkyaueoty3
type: challenge
title: Step 3 - Externalising configuration
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/camel-basic
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-gh9wd-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 375
---
## Applying configuration and routing

One of the most common integration patterns (*EIP*s) is the content-based router. This step shows how to implement the Routing EIP and how to configure it using external properties.

Let's first create the source files needed for this step. Run the following set of commands:

```
cd /root/camel-basic/
touch routing.properties
touch Routing.java
touch SupportRoutes.xml

```

> **Note:** we are defining 2 Camel source files, using the Java and XML DSLs (*Domain Specific Language*). Camel supports multiple languages. This example shows how you can load multiple Camel source files irrespectively of their DSL language.

### 1. Define the configuration.

Go to the **Visual Editor** tab (top left), select the `routing.properties` file, then copy the contents below, and make sure you save it:

```properties
# Marker to identify priority items
priority-marker=*

# List of delivery items for random generation
items=*shopping,postcard,letter,*payslip,publicity,*taxes
```

Items marked with a star in the configuration will have high priority. The *Routing* definition that follows will route items by their priority.


### 2. Define the main routing logic.

Select the `Routing.java` file in the editor's file tree and paste the contents from the code below, and ensure you save the changes:

```java
// camel-k: language=java

import org.apache.camel.PropertyInject;
import org.apache.camel.builder.RouteBuilder;

public class Routing extends RouteBuilder {

  @PropertyInject("priority-marker")
  private String priorityMarker;

  @Override
  public void configure() throws Exception {
      //Main Route:
      // 1) generates random item
      // 2) Choose priority pipeline (Content Based Router EIP)
      from("timer:java?period=3000").id("main")
        .to("direct:random-item-generator")
        .choice()
          .when().simple("${body.startsWith('{{priority-marker}}')}")
             //this transformation discards the star character
            .transform().body(String.class, item -> item.substring(priorityMarker.length()))
            .to("direct:priorityQueue")
          .otherwise()
            .to("direct:standardQueue");
  }
}
```

Note in code above how the annotation `@PropertyInject` is used to inject configured properties into variables. Also note how curly brackets `{{...}}` are used inside Camel routes to fetch configured properties (known as *Property Placeholders*).

Look at the routing logic to see how *Camel* routes delivery items to different queues depending on their priority.

### 3. Define the additional routes to support the main Route.

The java file previously defined contains the main routing logic. To showcase a declarative language we're now using the XML DSL that will define extra Camel routes necessary to run the example (Item generator and simulated priority queues).

From the editor, select the `SupportRoutes.xml` file and paste the contents from the XML code below, and ensure you save the changes:

```xml
<!-- camel-k: dependency=camel-csv -->
<routes id="camel" xmlns="http://camel.apache.org/schema/spring">

  <!-- Priority processing Route -->
  <route id="priority">
    <from uri="direct:priorityQueue"/>
    <log message="!!Priority delivery: ${body}"/>
  </route>

  <!-- Standard processing Route -->
  <route id="standard">
    <from uri="direct:standardQueue"/>
    <log message="Standard delivery: ${body}"/>
  </route>


  <!-- Randomly pick an item  from the configuration list -->
  <route id="random">
    <from uri="direct:random-item-generator"/>

    <!-- load the list of items from configuration-->
    <setBody>
      <simple>{{items}}</simple>
    </setBody>

    <!-- unmarshal CSV to a Java Map -->
    <unmarshal>
        <csv/>
    </unmarshal>

    <!-- select 1st line (it's a CSV value with a single line) -->
    <setBody>
      <simple>${body[0]}</simple>
    </setBody>

    <!-- pick a random item -->
    <setBody>
      <simple>${body[${random(0,${body.size})}]}</simple>
    </setBody>
  </route>

</routes>
```


### 4. Run the integration

The execution command must include the flag `--property file:<your-file>` to link the configuration file with the integration. To run it, use the command below:

```
kamel run \
--dev \
--name routing \
--property file:routing.properties \
Routing.java \
SupportRoutes.xml
```
Once it started. You can find the pod running this Routing application in the terminal.

```
[1] ... Standard delivery: publicity
[1] ... Standard delivery: postcard
[1] ... !!Priority delivery: taxes
[1] ... Standard delivery: letter
[1] ... !!Priority delivery: taxes
[1] ... Standard delivery: letter
[1] ... !!Priority delivery: shopping
[1] ... Standard delivery: postcard
[1] ... Standard delivery: letter
```

Now make some changes to the property file and see the integration redeployed.
For example, change the word `postcard` with `*postcard` to see it sent to the priority queue.

Hit `ctrl`+`C` on the terminal window. This will also terminate the execution of the integration.

Click *Next* to continue with step 4.
