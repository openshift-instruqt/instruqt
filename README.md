# OpenShift Labs on Instruqt

Welcome to the OpenShift Labs on Instruqt repositories. This repo is the source code of labs you find at https://play.instruqt.com/openshift

Please refer to the [Instruqt Documentation](https://docs.instruqt.com/) to understand how it works.

## Instruqt CLI

The first thing to do is to download the [Instruqt CLI](https://docs.instruqt.com/reference/software-development-kit-sdk)

## Login

If don't have an account on Instruqt, create a new account: https://play.instruqt.com/login

Login with the CLI:

```
instruqt auth login
```

This will open a browser where you can login, then your CLI session is authenticated.

## Track Development

You can create a new track in general with this command:

### Track Create

```
instruqt track create --title "First track"
```

Start from an existing track:

```
instruqt track create --from openshift/operatorframework-k8s-api-fundamentals --title "My new track based on k8s-api-fundamentals"
```

### Track Pull

You can download an existing track:

```
instruqt track pull openshift/operatorframework-k8s-api-fundamentals
```

### Track Push

You can push the change to your track in this way:

```
instruqt track pull
```

### Logs

You can check the logs from your track in this way:

```
instruqt track logs
```


## CRC Image

We are currently using nested virtualization with a CRC 4.9 inside a RHEL 8 VM.

The setting to have this image is from the `config.yml` file:

```
version: "2"
virtualmachines:
- name: crc
  image: openshift-instruqt/openshift-instruqt-crc490-211026
  machine_type: n1-standard-8
  allow_external_ingress:
  - http
  - https
  - high-ports
```

We can also have a sidecar container that can connect to the CRC VM with oc CLI in this way:

```
version: "2"
containers:
- name: container
  image: fedora
  shell: /bin/bash
virtualmachines:
- name: crc
  image: openshift-instruqt/openshift-instruqt-crc490-211026
  machine_type: n1-standard-8
  allow_external_ingress:
  - http
  - https
  - high-ports
```

The connection is made inside the setup scripts like [this one](https://github.com/openshift-instruqt/instruqt/blob/master/operatorframework/go-operator-podset/track_scripts/setup-container). Please refer to Instruqt doc to understand [track's lifecycle scripts](https://docs.instruqt.com/tracks/lifecycle-scripts).

## Other

### Mapping with Katacoda
* First level:  [Pathways](https://github.com/openshift-labs/learn-katacoda/blob/master/using-the-cluster-pathway.json)->[Topics](https://play.instruqt.com/openshift/topics/using-the-cluster)
* Second level: [Courses](https://github.com/openshift-labs/learn-katacoda/blob/master/introduction/cluster-access/index.json)->[Tracks](https://play.instruqt.com/openshift/tracks/logging-in-to-an-openshift-cluster)
* Third level: [Steps](https://github.com/openshift-labs/learn-katacoda/tree/master/introduction/cluster-access)->[Challenges/Assignments](https://play.instruqt.com/openshift/tracks/logging-in-to-an-openshift-cluster/challenges/logging-in-via-the-web-console/assignment)


#### How we have skaffolded it


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

