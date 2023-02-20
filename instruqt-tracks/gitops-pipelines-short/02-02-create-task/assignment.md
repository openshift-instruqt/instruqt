---
slug: 02-create-task
id: ksgrip7ln0d8
type: challenge
title: Step 2 - Create a Sample Task
notes:
- type: text
  contents: |-
    ✅ Create a Sample Task
    =============================

    Learn how to install the OpenShift Pipelines operator
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 600
---
📁 Create a new project
===================================

For this tutorial, you're going to create a simple application that involves a [frontend](https://github.com/openshift/pipelines-vote-ui) and [backend](https://github.com/openshift/pipelines-vote-api). This application needs to deploy in a new project (i.e. Kubernetes namespace). You can start by creating the project with:

```
oc new-project pipelines-tutorial
```

✅ Working with Tasks
===================================

A [`Task`](https://tekton.dev/docs/pipelines/tasks) defines a series of `steps` that run in a desired order and complete a set amount of build work. Every `Task` runs as a Pod on your cluster with each `step` as its own container. For example, the following `Task` outputs "Hello World":

```
apiVersion: tekton.dev/v1beta1
kind: Task
metadata:
  name: hello
spec:
  steps:
    - name: say-hello
      image: registry.access.redhat.com/ubi8/ubi
      command:
        - /bin/bash
      args: ['-c', 'echo Hello World']
```

Apply this  [`Task`](https://raw.githubusercontent.com/openshift-labs/learn-katacoda/master/middleware/pipelines/assets/tasks/hello.yaml) to your cluster just like any other Kubernetes object. Then run it using `tkn`, the CLI tool for Tekton.

```
oc apply -f https://raw.githubusercontent.com/openshift-labs/learn-katacoda/master/middleware/pipelines/assets/tasks/hello.yaml
```

```
tkn task start --showlog hello
```

The output will look similar to the following:

```
TaskRun started: hello-run-9cp8x
Waiting for logs to be available...
[say-hello] Hello World
```

📝 Task Resource Definitions
===================================

Tasks can also take parameters. This way, you can pass various flags to be used in this Task. These `params` can be instrumental in making your Tasks more generic and reusable across Pipelines. For example, a `Task` could apply a custom Kubernetes manifest, like the example below. This will be needed for deploying an image on OpenShift in our next section.

```
apiVersion: tekton.dev/v1beta1
kind: Task
metadata:
  name: apply-manifests
spec:
  workspaces:
  - name: source
  params:
    - name: manifest_dir
      description: The directory in source that contains yaml manifests
      type: string
      default: "k8s"
  steps:
    - name: apply
      image: quay.io/openshift/origin-cli:latest
      workingDir: /workspace/source
      command: ["/bin/bash", "-c"]
      args:
        - |-
          echo Applying manifests in $(inputs.params.manifest_dir) directory
          oc apply -f $(inputs.params.manifest_dir)
          echo -----------------------------------
```

1. Create the `apply-manifests` task:

```
oc create -f https://raw.githubusercontent.com/openshift-labs/learn-katacoda/master/middleware/pipelines/assets/tasks/apply_manifest_task.yaml
```

2. We'll also create a `update-deployment` task, which can be seen with a `cat` command:

```
oc create -f https://raw.githubusercontent.com/openshift-labs/learn-katacoda/master/middleware/pipelines/assets/tasks/update_deployment_task.yaml
```

3. Finally, we can create a PersistentVolumeClaim to provide the filesystem for our pipeline execution, explained more in the next step:

```
oc create -f https://raw.githubusercontent.com/openshift-labs/learn-katacoda/master/middleware/pipelines/assets/resources/persistent_volume_claim.yaml
```

4. You can take a look at the tasks you created using the [Tekton CLI](https://github.com/tektoncd/cli/releases):

```
tkn task ls
```

You should see similar output to this:

```
NAME                DESCRIPTION   AGE
apply-manifests                   4 seconds ago
hello                             1 minute ago
update-deployment                 3 seconds ago
```

In the next section, you will create a pipeline that takes the source code of an application from GitHub and then builds and deploys it on OpenShift ⬇️