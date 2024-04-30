---
slug: step3
id: rc9brkyvdmxi
type: challenge
title: Step 3 - Using Camel K traits
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
  cmd: /bin/bash
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/camel-basic
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-97g8f-master-0.crc.${_SANDBOX_ID}.instruqt.io/topology/ns/camel-basic?view=graph
  new_window: true
difficulty: basic
timelimit: 375
---
## Running integrations as Kubernetes CronJobs

In Camel K, [*Traits*](https://camel.apache.org/camel-k/latest/traits/traits.html) are high level named features that can be enabled/disabled or configured to customize the behavior of the final integration. For this step, we will rely on Camel K's [**Cron Trait**](https://camel.apache.org/camel-k/latest/traits/cron.html) to run the integration as a CronJob.

Because our Camel route in our previous step is triggered by the `timer` component, Camel K applies by default the Cron trait, ideal for periodic batch processing. As long as the timer's period parameter can be written as a cron expression, the integration can automatically be deployed as a Kubernetes CronJob.

First, let's switch to the working folder by running:

```
cd /root/camel-basic/
```

Next, click [button label="Visual Editor" background="#6c5ce7" ](tab-1).

Now, for example, edit the first endpoint (in ***Routing.java***):
- from:
  - `timer:java?period=3000`
- to:
  - `timer:java?period=60000` (1 minute between executions).

<br/>

Return to your [button label="Terminal" background="#6c5ce7" ](tab-0) and re-run the integration with:

```
kamel run \
--name routing \
--property file:routing.properties \
Routing.java \
SupportRoutes.xml
```

You'll see that Camel K has materialized a cron job using the command below:

> [!NOTE]
> You may need to wait around 1 minute until a job kicks off and you see the results below.

```
oc get cronjob -w
```

You'll find a Kubernetes CronJob named "routing".

```nocopy
NAME      SCHEDULE      SUSPEND   ACTIVE   LAST SCHEDULE   AGE
routing   0/1 * * * ?   False     0        39s             51s
```

The running behavior has changed because now there is more time between executions and the pod scales down until the next scheduled execution.

> [!WARNING]
> When using the cronJob strategy you need to design your application knowing that scheduled jobs do not allow keeping the memory state between runs.

You can see pod starts/stops by watching the namespace by issuing the command:

```
oc get pod -w
```

Hit `ctrl`+`C` on the terminal window.

To see the logs of each integration starting up, you can use the `kamel log` command:

```
kamel log routing
```

You should see every minute a JVM starting, executing a single operation and terminating.


The CronJob behavior is controlled via a Trait called `cron`. Traits are the main way to configure high level Camel K features, to customize how integrations are rendered.

To disable the cron feature and use the deployment strategy, you can run the integration with:

```
kamel run \
--name routing \
--property file:routing.properties \
--trait cron.enabled=false \
Routing.java \
SupportRoutes.xml
```


This will disable the cron trait and restore the classic behavior (always running pod).

You should see it reflected in the logs (which will be printed every minute by the same JVM):

```
kamel log routing
```

Hit `ctrl`+`C` on the terminal window.

<br/>

## Congratulations

In this scenario you got to play with Camel K. Focusing on the code, and see the power of how Camel K can enhance your experience when working on Kubernetes/OpenShift. There is much more to Camel K than realtime development and developer joy. Be sure to visit [Camel K](https://camel.apache.org/camel-k/latest/index.html) to learn even more about the architecture and capabilities of this exciting new framework.

# What's Next?

Congratulations on completing this lab. Keep learning about Apache Camel and OpenShift:

* Read the [Apache Camel page in Red Hat Developers](https://developers.redhat.com/products/redhat-build-of-apache-camel/overview) to learn more about the capabilities of Apache Camel.

* Find more [*Apache Camel* hands-on tutorials](https://developers.redhat.com/products/redhat-build-of-apache-camel/getting-started) you can try for free in the *Developer Sandbox*.

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
