---
slug: 01-exploring-kustomize
id: jygx5whmnqt1
type: challenge
title: Exploring Kustomize
notes:
- type: text
  contents: |
    ## Goal

    This guide helps you get familiar with how to use Kustomize on Argo CD on OpenShift.


    ## Concepts

    [Kustomize](https://kustomize.io/) traverses a Kubernetes manifest to add, remove or update configuration options without forking. It is available both as a standalone binary and as a native feature of `kubectl` (and by extension `oc`).

    The principals of `kustomize` are:

    * Purely declarative approach to configuration customization
    * Manage an arbitrary number of distinctly customized Kubernetes configurations
    * Every artifact that kustomize uses is plain YAML and can be validated and processed as such
    * As a "templateless" templating system; it encourages using YAML without forking the repo it.

    ![Kustomize Logo](https://raw.githubusercontent.com/openshift-instruqt/instruqt/master/assets/gitops/kustomize_logo.png)

    ## Use case

    This is a simple guide that takes you through the following steps:

    * Exploring the Kustomize syntax
    * Deploying a Kustomized application

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
timelimit: 900
---
Welcome! In this section we will be exploring the `kustomize` CLI and the
capabilities built into the `kubectl` command.

## Exploring the Kustomize CLI

The `kustomize` CLI should have been installed as part of the lab
setup. Verify that it has been installed.

```
kustomize version --short
```

This should display the version, it should look something like this.

```shell
{kustomize/v4.0.5  2021-02-13T21:21:14Z  }
```

Kustomize, at its core, is meant to build native Kubernetes manifests
based on YAML, while leaving the original YAML in tact. It achives this
in a "template-less" templating format. This is done by providing a `kustomization.yaml` file.

We will be focusing on two sub-commands the `build` command and the
`edit` command.

The `build` command takes the YAML source (via a path or URL) and creates
a new YAML that can be piped into `kubectl create`. To get started, download
the git respository for this exercise (it's important do perform the following
operations under the `/opt` directory):

```
cd /opt
git clone https://github.com/redhat-developer-demos/openshift-gitops-examples.git
cd openshift-gitops-examples
```

We will work with an example in the `components/kustomize-build/` directory.

```
cd components/kustomize-build/
```

Here you should see two files, a `kustomization.yaml` file and a `welcome.yaml` file

```
ls -l
```

Taking a look at the [welcome.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/components/kustomize-build/welcome.yaml)
file shows nothing special. Just a standard Kubernetes manifest.

What if, for example, we wanted to add a `label` to this manifest without editing it? This is where the [kustomization.yaml](https://raw.githubusercontent.com/redhat-developer-demos/openshift-gitops-examples/main/components/kustomize-build/kustomization.yaml) file comes in.

As you can see in the output there isn't much. The two sections for this
example are the `resources` and the `patchesJson6902` sections.

`resources` is an array of individual files, directories, and/or URLs where other manifests are stored. In this example we are just loading in one file. The [`patchesJson6902` is a patching RFC](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/patchesjson6902/) that `kustomize` supports. As you can see, in the `patchesJson6902` file, I am adding a label to this manifest.

> **NOTE** You can read about what options are available for patching in the [official documentaion site](https://kubectl.docs.kubernetes.io/references/kustomize/kustomization/)

Build this manifest by running:

```
kustomize build .
```
and you can see that the new label got added to the manifest!

You can use the `kustomize edit` command instead of writing YAML. For
example, you can change the image tag this `Deployment` uses from `latest`
to `ffcd15` by running the following:

```
kustomize edit set image quay.io/redhatworkshops/welcome-php:ffcd15
```

This will update the `components/kustomize-build/kustomization.yaml` file with an
images` section. Now when you run `kustomize build . ` you should see not only the new label
but also the new `ffcd15` image tag.

> **NOTE** You may have to close the `kustomization.yaml` tab and re-open it to see the changes.

You can see how you can take existing YAML and modify it for
your specific environment without the need to copy or edit the original.

Kustomize can be used to write a new YAML file or be pipped into
the `kubectl` (or `oc`) command. Example:

```shell
kustomize build . | oc apply -f -
```

## Exploring Kustomize with Kubectl

Since Kubernetes 1.14, The `kubectl` command (and by extention the
`oc` cli) has support for Kustomize built in.  You can see this by
running the following command:

```
kubectl kustomize --help
```

This runs the `kustomize build` command. You can see this by running: `kubectl kustomize`


Although you can use this to pipe it into the apply command, you
don't have to. The `kubectl apply` command has the `-k` option that
will run the build before it applies the manifest.

To test this out, first create a project:

```
oc new-project kustomize-test
```

Next make sure you are on the project:

```
oc project kustomize-test
```

Finally run the command to build and apply the manifests:

```
kubectl apply -k ./
```

> **NOTE** You can pass not only directories, but URLs as well. The
> only requirement is that you have a `kustomization.yaml` file in
> the path.

This should create the deployment and you should see the pods running in the namespace:

```
kubectl get pods -n kustomize-test
```

You can see the deployment was created with the additional labels:

```
kubectl get deployment welcome-php -o jsonpath='{.metadata.labels}' | jq -r
```

Also, the image was updated based on the customization that was made:

```
kubectl get deploy welcome-php  -o jsonpath='{.spec.template.spec.containers[].image}{"\n"}'
```

As you can see `kustomize` can be a powerful tool.
