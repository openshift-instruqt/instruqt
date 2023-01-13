---
slug: 02-first-chart
id: phnktxgopn6g
type: challenge
title: Create your first Helm Chart
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Visual Editor
  type: code
  hostname: container
  path: /root/my-chart
difficulty: basic
timelimit: 900
---
At the end of this chapter you will be able to:
- Create your own `Helm Chart`
- Understand `Helm Templates`
- Understand Helm integrations with `Kubernetes`


After having discovered `helm` CLI to install and manage Helm Charts, we can now create our first one from scratch. Before doing that, let's review the core concepts from [official documentation](https://helm.sh/docs/topics/charts/):

- A `Chart` is a Helm package. It contains all of the resource definitions necessary to run an application, tool, or service inside of a Kubernetes cluster.
- A `Repository` is the place where charts can be collected and shared.
- A `Release` is an instance of a chart running in a Kubernetes cluster-


Helm uses a packaging format called charts. A chart is a collection of files that describe a related set of Kubernetes resources, and it organized as a collection of files inside of a directory. The directory name is the name of the chart.

## Creating a new Helm Chart

Navigate to `/root` directory:

```
cd /root
```

With `helm create` command you can create a chart directory along with the common files and directories used in a chart.

An Helm chart called `my-chart` has been already generated with the following command:

`helm create my-chart`


Inside `my-chart/` folder you will find the following files, you can also review them from the **Visual Editor** Tab.

```
cd my-chart
ls -la
```

* `Chart.yaml`: is a YAML file containing multiple fields describing the chart
* `values.yaml`:: is a YAML file containing default values for a chart, those may be overridden by users during helm install or helm upgrade.
* `templates/NOTES.txt`: text to be displayed to your users when they run helm install.
* `templates/deployment.yaml`: a basic manifest for creating a Kubernetes deployment
* `templates/service.yaml`: a basic manifest for creating a service endpoint for your deployment
* `templates/_helpers.tpl`: a place to put template helpers that you can re-use throughout the chart

This command generates a skeleton of your Helm Chart, and by default there is an NGINX image as example:


**1. Chart description**

Let's review our `Chart.yaml`. This contains `version` of the package and `appVersion` that we are managing, typically this can be refered to a container image tag.

**2. Fill chart with custom values**

In our example, we are working on a Helm Template `templates/deployment.yaml` describing a Kubernetes Deployment for our app, containing this structure for `spec.containers.image`:

`image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"`

> **Note:** *By default `appVersion` from `Chart.yaml` is used as image tag*

In `values.yaml` add `image.repository` variable to define the container image for our chart.

From the **Visual Editor** Tab, open `values.yaml` file and add this line after the `# TODO: image repository` comment:

```yaml
repository: bitnami/nginx
```

Now let's define which tag to use for this container image.
Add this line after the `# TODO: image tag"` comment:

```yaml
tag: latest
```


**3. Install**

Install our custom Helm Chart from local folder.

```
cd /root
helm install my-chart ./my-chart
```

This will install NGINX like in previous chapter, and we can follow installation like in previous chapter, either from Terminal or OpenShift Console:

```
oc get pods
```

<img src="https://katacoda.com/embed/openshift/courses/assets/developing-on-openshift/helm/my-chart-helm-chart.png" width="800" />

Review installed revision:

```
helm ls
```

In next chapter we will add an OpenShift Route as a Helm Template, like for `Service`, to be published in a new revision.
