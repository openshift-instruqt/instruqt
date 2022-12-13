---
slug: step1
id: plmsl5qgyc6k
type: challenge
title: The Ansible Operator
notes:
- type: text
  contents: |
    This section will give a brief overview of the *Ansible Operator* with a step-by-step example of developing an Ansible Operator using [Operator SDK](https://sdk.operatorframework.io).

    The reader is expected to have a basic understanding of the *Operator pattern*.
     - Ansible Operator is an Operator which is _powered by Ansible_.
     - Custom Resource events trigger Ansible tasks as opposed to the traditional approach of handling these events with Go code.

    Ansible Operator development and testing is fully supported as a first-class citizen within the Operator SDK. Operator SDK can be used to create new Operator projects, test existing Operator projects, build Operator images, and generate new Custom Resource Definitions (CRDs) for an Operator.
difficulty: basic
timelimit: 225
---

    By the end of this section the reader should have a basic understanding of:

    * What the Ansible Operator is
    * How the Ansible Operator maps Custom Resource events to Ansible code
    * How to pass extra variables to Ansible code via the operator
    * How to leverage existing roles from Ansible Galaxy
    * How to deploy and run the Ansible Operator in a OpenShift cluster
    * How to run the Ansible Operator Locally for development
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root
---
***

_This step doesn't require changes to the interactive environment, but feel free to explore._

***

## Why an Operator?

Operators make it easy to manage complex stateful applications on top of Kubernetes. However writing an operator today can be difficult because of challenges such as using low level APIs, writing boilerplate, and a lack of modularity which leads to duplication.

The Operator SDK is a framework that uses the controller-runtime library to make writing operators easier by providing:

* High level APIs and abstractions to write the operational logic more intuitively
* Tools for scaffolding and code generation to bootstrap a new project fast
* Extensions to cover common operator use cases

## What is an Ansible Operator?

A collection of building blocks from Operator SDK that enables Ansible to handle the reconciliation logic for an Operator.

## Included in Operator Framework

Ansible Operator is one of the available types of Operators that Operator SDK is able to generate. Operator SDK can create an operator using Golang, Helm, or Ansible.

## How do I use it?

Build your Ansible code on top of a provided base image along with some metadata to map Kubernetes events to Ansible Playbooks or Roles.

![Ansible Operator Flow](https://raw.githubusercontent.com/openshift-labs/learn-katacoda/master/ansibleop/ansible-operator-overview/assets/images/ansible-op-flow.png)

The following workflow is for a new **Ansible** operator:

1. Create a new Operator project using the Operator SDK Command Line Interface (CLI)
2. Write the reconciling logic for your object using Ansible Playbooks and Roles
3. Use the SDK CLI to build and generate the operator deployment manifests
4. Optionally add additional CRD's using the SDK CLI and repeat steps 2 and 3

Now, let's dig into the specifics and walk through an example.
