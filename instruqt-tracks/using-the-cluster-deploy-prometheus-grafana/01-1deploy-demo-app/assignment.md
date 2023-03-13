---
slug: 1deploy-demo-app
id: opgxhijpt52z
type: challenge
title: Step 1 - Example of Prometheus metrics being exposed by an application
notes:
- type: text
  contents: |
    ## Goal

    Learn how to use [Prometheus](https://github.com/prometheus/prometheus) on OpenShift to collect metrics from an application and then visualize the results with [Grafana](https://github.com/grafana/grafana).

    ## Concepts

    * Prometheus, exporters, and application metrics
    * Grafana charts and graphs
    * OpenShift Web Console
    * `oc` OpenShift command line tool

    ## Use case

    You can analyze application metrics to spot problems, monitor performance, audit resource use, and improve your understanding of your application's behavior in order to improve it.

    This OpenShift cluster will self-destruct in one hour.
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
## Playing with the demo application

The demo application is a simulated E-commerce food store application that also exposes some of it's metrics (the food store application might take up to an additional minute to be initialized).

### Generating some metrics

The url for the food store is: http://metrics-demo-app-metrics-demo.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/

![Demo Application Home Page](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/introduction/deploy-prometheus-grafana/01-demo-app-home-page.png)

* Once you are able to access the food store application, play around with it,
try to buy the products you like [Everything here is free ;) ].
* When you play around with the food store, you make the server serve some requests (GET/POST/..), <br>
some of the metrics for these requests are generated and exposed for Prometheus to collect.

### Exposed metrics
The exposed metrics can be found here: http://metrics-demo-app-metrics-demo.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com/metrics

* This is the endpoint where Prometheus will scrape (collect) metrics from periodically and store them on a persistent storage device like a hard drive (Using [OpenShift PersistentVolumes](https://docs.openshift.com/container-platform/4.2/storage/understanding-persistent-storage.html#persistent-storage-overview_understanding-persistent-storage)).

![Demo Application Metrics Page](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/introduction/deploy-prometheus-grafana/01-demo-app-metrics-page.png)

* If you don't see similar metrics (pictured above) in your environment, try to make an order with the ecommerce application to generate a few metrics.
