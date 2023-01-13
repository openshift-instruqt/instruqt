# OpenShift Labs on Instruqt

Welcome to the OpenShift Labs on Instruqt repositories. This repo contains the source code of our self-paced labs you can access at https://developers.redhat.com/learn

To learn more about Instruqt for OpenShift Labs, check out our internal presentation [here](https://docs.google.com/presentation/d/1J-QQoiRbrkLzrbuvAZeISBuSmgS2_mIHD9XdbMumuTo/edit?usp=sharing).

## Instruqt

This repository contains images and tracks for the [Instruqt](https://instruqt.com) platform. Red Hat is using Instruqt for in-browser demonstrations of OpenShift labs, as well as the Ansible Automation Platform and RHEL. Please refer to the [Instruqt Documentation](https://docs.instruqt.com) to understand how it works.

### Using Instruqt

The first thing to do is to download the [Instruqt CLI](https://docs.instruqt.com/reference/software-development-kit-sdk), which allows you to create new tracks, push tracks, and more. This [how-to](https://docs.instruqt.com/how-to-guides/build-tracks) guide on building tracks provides a great reference in pair with our  internal presentation for OpenShift-specific labs.

### Login to Instruqt

If don't have an account on Instruqt, create a new account: https://play.instruqt.com/login

Login with the CLI:

```
instruqt auth login
```

This will open a browser where you can login, then your CLI session is authenticated.

The OpenShift Instruqt organization page is hosted at https://play.instruqt.com/openshift

### Track Development

Here's how to get started on working on or maintaining an Instruqt OpenShift track:

#### Creating tracks from scratch/template

*Create a new track, from scratch*

Create an empty track:
```
instruqt track create --title "First track"
```

*Start from an OpenShift template track*

This creates an example track using CRC 4.11 VM with `root` user and authenticated by default with `system:admin` as in [this example](https://github.com/openshift-instruqt/instruqt/tree/master/examples/openshift-example-track):

```
instruqt track create --from openshift/openshift-example-track --title "My First OpenShift Track"
```

*Start from an OpenShift template track with a Fedora sidecar*

This creates an example track using CRC 4.11 VM and a sidecar Fedora container using `root` user where to install packages/dependencies.
The container can be connected to the CRC VM with the oc CLI as in [this example](https://github.com/openshift-instruqt/instruqt/tree/master/examples/openshift-example-track-with-fedora-sidecar):

```
instruqt track create --from openshift/openshift-example-track-with-fedora-sidecar --title "My First OpenShift Track with Fedora Sidecar"
```

#### Track Pull

You can download an existing track:

```
instruqt track pull openshift/operatorframework-k8s-api-fundamentals
```

#### Track Push

You can push the change to your track in this way:

```
instruqt track push
```

#### Check Logs

You can check the logs from your track in this way:

```
instruqt track logs
```

### Converting legacy Katacoda content to Instruqt's format

#### Web Console

If Web Console access is required, replace Katacoda dynamic URLs with this snippet that will let user access to OpenShift from the web console by printing the HTTPS URL. The hypertext is highlighted so it's easy to access then by just clicking on it: 

```
    Access the OpenShift Web Console to login from the Web UI:
    ```
    oc get routes console -n openshift-console -o jsonpath='{"https://"}{.spec.host}{"\n"}'
    ```
    Copy the URL from the output of the above command and open it in your browser.
    We'll deploy our app as the `developer` user. Use the following credentials:
    * Username:
    ```
    developer
    ```
    * Password:
    ```
    developer
    ```
```

#### Routes

Replace Katacoda's dynamic URLs for routes with this snippet:

```
    Get the URL from command line, from *Terminal 1* run this command to get the app's Route:

    ```
    oc get route <route-name> -n <namespace> -o jsonpath='{"http://"}{.spec.host}{"/taster"}{"\n"}'

    ```

    Copy the URL and open it in your browser, or click it from here.
```

#### Editor

Replace all text mentioning to "Click to open a file" with this snippet, just point the users to the Visual Editor tab containing a VSCode web editor:

```
    From the **Visual Editor** Tab, create a new file in this path: `fruit-taster/src/main/java/org/acme/Fruit.java`.
    Then add this code:
    ```java
    ...
    ```
    
    ```go
    ```
```

#### Code blocks

Instruqt doesn't have the click and execute feature, any code block is copy and paste.

Convert any block like this:

`oc get pods`

In this way:

```
oc get pods
```

#### Clean text

sometimes in the code you can find `&lt; &gt;` for `<>` or `&quote;` for `"`, please substitute it if you find it.

If you find this sequence
```
`
``
<br>
```

Replace with this regexp:

```
s/`\n\s+```\n\s+<br>//g
```

#### Assets

There's no relative path concept from assets like in Katacoda's index.json, so you need to download them from internet from the `setup-crc` or `setup-container` script and store in the expected path.

As a convention, we store files into track's `script` dir and images into track's `assets` dir:

```
├── assets
│   ├── images
│   │   └── ansible-op-flow.png
│   ├── podset_controller.go
│   └── podset_types.go
├── config.yml
├── scripts
│   ├── my_script.sh
├── step1
├── step2
├── step3
│   └── setup-container
├── step4
│   └── setup-container
├── step5
├── step6
│   └── setup-container
├── step7
├── track_scripts
│   ├── setup-container
│   └── setup-crc
└── track.yml
```

E.g. from `setup-crc`:

```
#!/bin/bash

curl -s https://raw.githubusercontent.com/openshift-instruqt/instruqt/v0.0.4/operatorframework/go-operator-podset/assets/podset_types.go -o /tmp/podset_types.go
```



## CRC Image

We are currently using nested virtualization with a CRC 4.11 (`rhd-devx-instruqt/openshift-4-11-7-lgph7
`) inside a RHEL 8 VM.

The setting to have this image is from the `config.yml` file:

```
version: "3"
virtualmachines:
- name: crc
  image: rhd-devx-instruqt/openshift-4-11-7-lgph7
  machine_type: n1-highmem-4
  allow_external_ingress:
  - http
  - https
  - high-ports
```

We can also have a sidecar container that can connect to the CRC VM with oc CLI in this way:

```
version: "3"
containers:
- name: container
  image: fedora
  shell: /bin/bash
virtualmachines:
- name: crc
  image: rhd-devx-instruqt/openshift-4-11-7-lgph7
  machine_type: n1-highmem-4
  allow_external_ingress:
  - http
  - https
  - high-ports
```

The connection is made inside the setup scripts like [this one](https://github.com/openshift-instruqt/instruqt/blob/master/developing-on-openshift/developing-with-odo/track_scripts/setup-container). Please refer to Instruqt's documentation to understand [track lifecycle scripts](https://docs.instruqt.com/tracks/lifecycle-scripts).

## Misc

### Mapping with Katacoda
* First level:  [Pathways](https://github.com/openshift-labs/learn-katacoda/blob/master/using-the-cluster-pathway.json)->[Topics](https://play.instruqt.com/openshift/topics/using-the-cluster)
* Second level: [Courses](https://github.com/openshift-labs/learn-katacoda/blob/master/introduction/cluster-access/index.json)->[Tracks](https://play.instruqt.com/openshift/tracks/logging-in-to-an-openshift-cluster)
* Third level: [Steps](https://github.com/openshift-labs/learn-katacoda/tree/master/introduction/cluster-access)->[Challenges/Assignments](https://play.instruqt.com/openshift/tracks/logging-in-to-an-openshift-cluster/challenges/logging-in-via-the-web-console/assignment)


#### How we have skaffolded it

We used git submodules to clone this [repo](https://github.com/openshift-labs/learn-katacoda/) and then we used this [script](https://gist.github.com/blues-man/d74b7aba058e62ba2e2042b4eb5d892c)

```bash
git submodule update --init
python kataklisma.py
```

For each generated directory representing the pathway->topic, inside subfolders with tracks:

```
instruqt track validate && instruqt track push
```

Bulk validate

```
for d in `ls -d */ | grep -v learn-katacoda`; do 
  echo $d;
  cd $d;
  for dd in `ls -d */`; do 
    echo $dd;
    cd $dd; 
    instruqt track validate; 
    cd ..; 
  done;
  cd ..; 
done 
```

Bulk validate and push

```
for d in `ls -d */ | grep -v learn-katacoda`; do 
  cd $d;
  echo $d;
  for dd in `ls -d */`; do 
    echo $dd;
    cd $dd; 
    instruqt track validate && instruqt track push --force;
    cd ..;
  done;
  cd ..; 
done

```
