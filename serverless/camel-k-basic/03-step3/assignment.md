---
slug: step3
id: pvfkyaueoty3
type: challenge
title: Step 3 - Externalising Camel K configuration and working in DEV mode
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
timelimit: 300
---
## Applying configuration and routing

One of the most common integration patterns (EIPs) is the content-based router. This step shows how to implement the Routing EIP and how to configure it using external properties.

Let's first create the file properties the Camel K integration will use.
Go to the **Visual Editor** tab (top left), and click the *Create a new file* icon at the folder level `/root/camel-basic`. Name it `routing.properties`, then copy the contents below, and make sure you save it:

```properties
# Marker to identify priority items
priority-marker=*

# List of delivery items for random generation
items=*shopping postcard letter *payslip publicity *taxes
```

The Camel definition will route items by their priority. Items marked with a star will have high priority. Let's create the Camel K integration. Switch back to the **Terminal** and execute the command below:

```
cd /root/camel-basic/
```

Then, execute the following `kamel` client command to initialise a new Java file:

```
kamel init Routing.java
```

Go to the **Visual Editor** tab (top left), choose the new file `Routing.java`, replace its entire content with the code below, and ensure you save the changes:

```java
// camel-k: language=java

import java.util.Random;

import org.apache.camel.PropertyInject;
import org.apache.camel.builder.RouteBuilder;

public class Routing extends RouteBuilder {

  private Random random = new Random();

  @PropertyInject("priority-marker")
  private String priorityMarker;

  @Override
  public void configure() throws Exception {

      //Main Route:
      // 1) generates random items
      // 2) selects priority processing pipeline (Content Based Router EIP)
      from("timer:java?period=3000").id("generator")
        .bean(this, "generateRandomItem({{items}})")
        .choice()
          .when().simple("${body.startsWith('{{priority-marker}}')}")
            .transform().body(String.class, item -> item.substring(priorityMarker.length()))
            .to("direct:priorityQueue")
          .otherwise()
            .to("direct:standardQueue");

      //Priority processing Route
      from("direct:priorityQueue").id("priority")
        .log("!!Priority delivery: ${body}");

      //Standard processing Route
      from("direct:standardQueue").id("standard")
        .log("Standard delivery: ${body}");
  }

  //helper method
  public String generateRandomItem(String items) {

    //generate an array out of the list of items
    String[] list = items.split("\\s");

    //randomly return an item from the list
    return list[random.nextInt(list.length)];
  }
}
```

The `Routing.java` file shows how to inject properties into the routes via property placeholders, like `{{items}}`, and also the usage of the `@PropertyInject` annotation.
The Camel routes use two configuration properties named `items` and `priority-marker` obtained from the external `routing.properties`.

To run the integration, we must include the flag `--property file:<your-file>` to link the configuration file, as shown in the command below:

```
kamel run Routing.java --property file:routing.properties --dev
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

Hit `ctrl+C` on the terminal window. This will also terminate the execution of the integration.
