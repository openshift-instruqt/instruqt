---
slug: step4
id: qdyoxxzbmlwp
type: challenge
title: Step 4
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 450
---
## When the market closes...

Bitcoin market never closes, but closing hours are expected to be present for standard markets. We're going to simulate a closing on the market by stopping the source integration.

When the market closes and updates are no longer pushed into the event mesh, all downstream services will scale down to zero. This includes the two prediction algorithms, the two services that receive events from the mesh and also the external investor service.

To simulate a market close, we will delete the market-source:

```
kamel delete market-source
```

To see the other services going down, go to the [Developer Console Topology view](https://console-openshift-console-[[HOST_SUBDOMAIN]]-443-[[KATACODA_HOST]].environments.katacoda.com/topology/ns/camel-knative/graph) after two minutes, you will see the pod slowly shutdown.

![marketclose](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/middleware-camelk/camel-k-eventing/Eventing-Step4-01-marketclose.png)

## Congratulations

In this scenario you got to play with Camel K and Serverless - Knative Eventing. We use Camel K as a Source to load data into event mesh based on Broker. And create couple of functions using Camel K that subscribe to the events in the mesh. There are much more to Camel K. Be sure to visit [Camel K](https://camel.apache.org/camel-k/latest/index.html) to learn even more about the architecture and capabilities of this exciting new framework.

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
