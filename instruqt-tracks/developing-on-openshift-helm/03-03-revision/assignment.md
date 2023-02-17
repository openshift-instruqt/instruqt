---
slug: 03-revision
id: vvmdo6mdop5c
type: challenge
title: Manage Revisions
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
- Manage multiple `Helm Revisions` for your Helm Chart
- `Upgrade` revisions for new changes
- Revert changes with `Rollback` of revisions

## Upgrade revisions

When we install a Helm Chart on OpenShift, we publish a release into the cluster that we can control in terms of upgrades and rollbacks.

To change something in any already published chart, we can use `helm upgrade` command with new parameters or code from our chart.

## Add OpenShift Route as Template

From the Visual Editor, create a new template for OpenShift Route in `templates` directory. From the `templates` directory, create a new file called `routes.yaml`. Copy the following content to that file:

```yaml
apiVersion: route.openshift.io/v1
kind: Route
metadata:
  name: {{ include "my-chart.fullname" . }}
  labels:
    {{- include "my-chart.labels" . | nindent 4 }}
spec:
  port:
    targetPort: http
  to:
    kind: Service
    name: {{ include "my-chart.fullname" . }}
    weight: 100
  wildcardPolicy: None
```

Run `helm upgrade` to publish a new revision containing a `my-charm` Route:

```
helm upgrade my-chart ./my-chart
```

Verify new `Route` from Terminal:

```
oc get routes
```

Verify new `Revision`:

```
helm ls
```

Verify new `Route` and new `Revision` from Console:

<img src="https://katacoda.com/embed/openshift/courses/assets/developing-on-openshift/helm/my-chart-helm-chart-route.png" width="800" />

<img src="https://katacoda.com/embed/openshift/courses/assets/developing-on-openshift/helm/my-chart-new-revision.png" width="800" />


## Upgrade and Rollback

Let's update again our existing release overriding values in `values.yaml` changing `image.pullPolicy` from chart's default value `IfNotPresent` to `Always`, using same method we adopted previously for changing `service.type` with option `--set`:

```
helm upgrade my-chart ./my-chart --set image.pullPolicy=Always
```

Let's verify that our changes is reflected into resulting `Deployment`:

```
oc get deployment my-chart -o yaml | grep imagePullPolicy
```

Get current `Revision`:

```
helm ls
```

Now that our new release is published and verified, we can decide to rollback to previous version if we need to, and this is possible with `helm rollback` command.

It is also possible to dry-run the rollback with `--dry-run` option:

```
helm rollback my-chart 2 --dry-run
```

Rollback to starting revision:

```
helm rollback my-chart 2
```

Check pods:

```
oc get pods
```

Verify `imagePullPolicy` is rolled back to `Revision` 2 containing `IfNotPresent` Policy:

```
oc get deployment my-chart -o yaml | grep imagePullPolicy
```


## Uninstall

Uninstall will clean everything now, there's no further need to delete manually the `Route` like in first chapter, since the Helm Chart is now managing that resource:

```
helm uninstall my-chart
```

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
