---
slug: 03-create-pipeline
id: hg0xmgr0zy8k
type: challenge
title: Step 3 - Create a Pipeline
notes:
- type: text
  contents: "\U0001F477 Create a Pipeline\n=============================\n\nLearn
    how to create and trigger a Pipeline"
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 700
---
👷 Creating our Pipeline
===============================

A [`Pipeline`](https://tekton.dev/docs/pipelines/pipelines/) defines an ordered series of `Tasks` that you want to execute along with the corresponding inputs and outputs for each `Task`. In fact, tasks should do one single thing so you can reuse them across pipelines or even within a single pipeline.

Below is an example definition of a `Pipeline`, created using the following diagram:

![Web Console Developer](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/pipeline-diagram.png)

Here's is a YAML file that represents the above pipeline:

```
apiVersion: tekton.dev/v1beta1
kind: Pipeline
metadata:
  name: build-and-deploy
spec:
  workspaces:
  - name: shared-workspace
  params:
  - name: deployment-name
    type: string
    description: name of the deployment to be patched
  - name: git-url
    type: string
    description: url of the git repo for the code of deployment
  - name: git-revision
    type: string
    description: revision to be used from repo of the code for deployment
    default: "master"
  - name: IMAGE
    type: string
    description: image to be build from the code
  tasks:
  - name: fetch-repository
    taskRef:
      name: git-clone
      kind: ClusterTask
    workspaces:
    - name: output
      workspace: shared-workspace
    params:
    - name: url
      value: $(params.git-url)
    - name: subdirectory
      value: ""
    - name: deleteExisting
      value: "true"
    - name: revision
      value: $(params.git-revision)
  - name: build-image
    taskRef:
      name: buildah
      kind: ClusterTask
    params:
    - name: TLSVERIFY
      value: "false"
    - name: IMAGE
      value: $(params.IMAGE)
    workspaces:
    - name: source
      workspace: shared-workspace
    runAfter:
    - fetch-repository
  - name: apply-manifests
    taskRef:
      name: apply-manifests
    workspaces:
    - name: source
      workspace: shared-workspace
    runAfter:
    - build-image
  - name: update-deployment
    taskRef:
      name: update-deployment
    workspaces:
    - name: source
      workspace: shared-workspace
    params:
    - name: deployment
      value: $(params.deployment-name)
    - name: IMAGE
      value: $(params.IMAGE)
    runAfter:
    - apply-manifests
```

This pipeline helps you to build and deploy backend/frontend, by configuring the right resources to the pipeline.

Pipeline Steps:

  1. `fetch-repository` clones the source code of the application from a git repository by referring (`git-url` and `git-revision` param)
  2. `build-image` builds the container image of the application using the `buildah` clustertask
  that uses [Buildah](https://buildah.io/) to build the image
  3. The application image is pushed to an image registry by referring (`image` param)
  4. The new application image is deployed on OpenShift using the `apply-manifests` and `update-deployment` tasks

There's also no references to the git repository or the image registry it will be pushed to in the pipeline, as Tekton is designed to be generic and re-usable across environments and stages through the application's lifecycle.

Create the pipeline by running the following:

```
oc create -f https://raw.githubusercontent.com/openshift-labs/learn-katacoda/master/middleware/pipelines/assets/pipeline/pipeline.yaml
```

😄 Triggering our Pipeline
===============================

Now that the pipeline is created, you can trigger it to execute the tasks specified in the pipeline. This is done by creating a `PipelineRun` via `tkn`.

1. Let's start a pipeline to build and deploy our backend application using `tkn`. By creating a `PipelineRun` with the name of our applied `Pipeline`, we can define various arguments to our command like `params` that will be used in the `Pipeline`.

```
tkn pipeline start build-and-deploy -w name=shared-workspace,claimName=source-pvc -p deployment-name=pipelines-vote-api -p git-url=https://github.com/openshift/pipelines-vote-api.git -p IMAGE=image-registry.openshift-image-registry.svc:5000/pipelines-tutorial/vote-api -p git-revision=master --showlog
```

2. Similarly, start a pipeline to build and deploy the frontend application:

```
tkn pipeline start build-and-deploy -w name=shared-workspace,claimName=source-pvc -p deployment-name=pipelines-vote-ui -p git-url=https://github.com/openshift/pipelines-vote-ui.git -p IMAGE=image-registry.openshift-image-registry.svc:5000/pipelines-tutorial/vote-ui -p git-revision=master --showlog
```

As soon as you start the `build-and-deploy` pipeline, a `PipelineRun` will be instantiated and pods will be created to execute the tasks that are defined in the pipeline. Let's list our PipelineRuns:

```
tkn pipelinerun ls
```

After a few minutes, the pipeline should finish successfully!

💻 Verifying pipeline deployment
===============================

To view the `PipelineRun` visually, visit the Pipelines section of the developer perspective. From here, you can see the details of our `Pipeline`, including the YAML file we've applied, the `PipelineRun`, input custom `params`, and more:

![Web Console Pipelines](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/web-console-developer.png)

Now, click on the Topology tab on the left side of the web console. You should see something similar to what is shown in the screenshot below:

![Web Console Deployed](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/application-deployed.png)

By clicking on the arrow icon as shown below, you can open the URL for _ui_ in a new tab and see the application running.

![Web Console URL Icon](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/middleware/pipelines/url-icon.png)

After clicking on the icon, you should see the application running in a new tab. Congratulations! You have successfully deployed your first application using [OpenShift Pipelines](https://cloud.redhat.com/blog/introducing-openshift-pipelines).

⏭️ What's next
===============================

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!