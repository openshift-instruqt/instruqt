---
slug: 03-using-syncwaves-and-hooks
id: 6d6icwg4a0oz
type: challenge
title: Using Syncwaves and Hooks Together
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 800
---
Now that you got your hands on syncwaves and resource hooks, you will
now use them together to see how you can control how your deployment
rolls out.

## Background

In the previous sections you learned how to order the application
of manifests using syncwaves. You also went over how you phase your
deployments with resource hooks.

In this section we will use syncwaves within each phase to show how you
can further refine the deployment process.

Take a look at the following diagram.

![resource-wave-hooks](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/resource-hooks.png)

The workflow can be summarized like this:

* The `PreSync` phase will run and manifests will be applied in their syncwave order.
* Once the `PreSync` phase is successful, the `Sync` phase begins.
* The `Sync` phase will apply the manifests in the their syncwave order
* Finally, after the `Sync` phase is done, the `PostSync` phase applies the manifests in the syncwave order.

## Exploring Manifests

Using Kustomize, we will be adding 3 addition manifests.

* A `PreSync` Job with a syncwave of 0 [welcome-php-presync-job.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/apps/welcome-php/overlays/syncwaves-and-hooks/welcome-php-presync-job.yaml)
* A `PreSync` Pod with a syncwave of 1 and a hook deletion policy [welcome-php-presync-pod.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/apps/welcome-php/overlays/syncwaves-and-hooks/welcome-php-postsync-pod.yaml)
* A `PostSync` Pod with a hook deletion policy [welcome-php-postsync-pod.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/apps/welcome-php/overlays/syncwaves-and-hooks/welcome-php-postsync-pod.yaml)

The manifest will apply in the following order.

* `PreSync` - The Job will start and finish. The the Pod will start and finish. Once these are both done successfully the `PreSync` phase is considered "done".
* `Sync` - All the manifests will apply in their respective syncwave order. Once this is done successfully, the `Sync` phase is considered done.
* `PostSync` - The Pod will start and finish. Once it's successfully finished, the resource is deleted.


## Deploying the Application

Take a look at the manifest file [welcome-syncwaves-and-hooks.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/components/applications/welcome-syncwaves-and-hooks.yaml)

As before, we are using Kustomize to deploy the same application,
but in a different namespace and we are loading in the 3 additional
manifests. You can see the specific implementation in the [git repo](https://github.com/redhat-developer-demos/openshift-gitops-examples/tree/main/apps/welcome-php/overlays/syncwaves-and-hooks)

Create this application

```
oc apply -f https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/components/applications/welcome-syncwaves-and-hooks.yaml
```

This should create the 3rd application on Argo CD.

![waves-and-hooks-card](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/waves-and-hooks-card.png)

Clicking on this card should take you to the tree view.

![waves-and-hooks-tree](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/waves-and-hooks-tree.png)

Here you can observe the sync process happening in the order
specified. You will also note that the `PreSync` Pod and the `PostSync`
pod were deleted after the sync process because of the deletion policy
annotation.

Take a look to verify:

```
oc get pods,jobs -n welcome-waves-and-hooks
```

You should see the following output.

```shell
NAME                               READY   STATUS      RESTARTS   AGE
pod/welcome-php-6986bd99c4-vv499   1/1     Running     0          4m52s
pod/welcome-presyncjob-8jtqj       0/1     Completed   0          5m24s

NAME                           COMPLETIONS   DURATION   AGE
job.batch/welcome-presyncjob   1/1           18s        5m24s
```

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
