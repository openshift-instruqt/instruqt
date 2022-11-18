---
slug: step4
id: rc9brkyvdmxi
type: challenge
title: Step 4 - Using Camel K traits
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
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
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

For example, you can edit the first endpoint (`timer:java?period=3000`) in *Routing.java* into the following: `timer:java?period=60000` (1 minute between executions).

Now you can run the integration again:

```
kamel run \
--name routing \
--property file:routing.properties \
Routing.java \
SupportRoutes.xml
```

Now you'll see that Camel K has materialized a cron job (it might take one minute to appear.):

```
oc get cronjob -w
```

You'll find a Kubernetes CronJob named "routing".

```
NAME      SCHEDULE      SUSPEND   ACTIVE   LAST SCHEDULE   AGE
routing   0/1 * * * ?   False     0        39s             51s
```

The running behavior changes, because now there's no pod always running (beware you should not store data in memory when using the cronJob strategy).

You can see the pods starting and being destroyed by watching the namespace:

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

## Congratulations

In this scenario you got to play with Camel K. Focusing on the code, and see the power of how Camel K can enhance your experience when working on Kubernetes/OpenShift. There is much more to Camel K than realtime development and developer joy. Be sure to visit [Camel K](https://camel.apache.org/camel-k/latest/index.html) to learn even more about the architecture and capabilities of this exciting new framework.
