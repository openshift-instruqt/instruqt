---
slug: playground
id: a0kxymmzcjab
type: challenge
title: OpenShift Playground
notes:
- type: text
  contents: |
    ## Goal

    Explore Ingress enhancements to OpenShift version 4.11.

    ## Concepts

    * OpenShift Web Console
    * `oc` command line tool
    * OpenShift Projects and Applications
    * Ingress setup

    ## Use case

    You control an OpenShift cluster for one hour. You can deploy your own container image, or set up a pipeline to build your application from source, then monitor it with Prometheus as it runs. Use an Operator to deploy and manage a database backend for your web app.

    This OpenShift cluster will self-destruct in one hour.
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 3600
---
# Ingress customizations

## Generate a new SSL cert

Is this step needed?  Should we use one issued by instruqt?
```
openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout /tmp/instruqt.key -out /tmp/instruqt.crt -subj "/CN=${HOSTNAME}.crc.${INSTRUQT_PARTICIPANT_ID}.instruqt.io" -addext "subjectAltName=DNS:apps.${HOSTNAME}.crc.${INSTRUQT_PARTICIPANT_ID}.instruqt.io,DNS:*.apps.${HOSTNAME}.crc.${INSTRUQT_PARTICIPANT_ID}.instruqt.io,DNS:api.${HOSTNAME}.crc.${INSTRUQT_PARTICIPANT_ID}.instruqt.io"
```

## Store the new cert as a secret:

```
oc create secret tls instruqt-secret --cert=/tmp/instruqt.crt --key=/tmp/instruqt.key -n openshift-config
```

## Patch the ingress:

Generate an ingress patch file:
```
cat <<EOF > /tmp/ingress-patch.yaml
spec:
  appsDomain: apps.$HOSTNAME.crc.$INSTRUQT_PARTICIPANT_ID.instruqt.io
  componentRoutes:
  - hostname: console-openshift-console.apps.$HOSTNAME.crc.$INSTRUQT_PARTICIPANT_ID.instruqt.io
    name: console
    namespace: openshift-console
    servingCertKeyPairSecret:
      name: instruqt-secret
  - hostname: oauth-openshift.apps.$HOSTNAME.crc.$INSTRUQT_PARTICIPANT_ID.instruqt.io
    name: oauth-openshift
    namespace: openshift-authentication
    servingCertKeyPairSecret:
      name: instruqt-secret
EOF
```

Apply the ingress patch:
```
oc patch ingresses.config.openshift.io cluster --type=merge --patch-file=/tmp/ingress-patch.yaml
```

Patch the API URL:
```
oc patch apiserver cluster --type=merge -p "{\"spec\":{\"servingCerts\": {\"namedCertificates\":[{\"names\":[\"api.${HOSTNAME}.crc.${INSTRUQT_PARTICIPANT_ID}.instruqt.io\"],\"servingCertificate\": {\"name\": \"instruqt-secret\"}}]}}}"
```

Patch the console url:
```
oc patch -p '{"spec": {"host": "console-openshift-console.'$HOSTNAME'.crc.'$INSTRUQT_PARTICIPANT_ID'.instruqt.io"}}' route console -n openshift-console --type=merge
```

Patch the download urls:
```
oc patch -p '{"spec": {"host": "downloads-openshift-console.'$HOSTNAME'.crc.'$INSTRUQT_PARTICIPANT_ID'.instruqt.io"}}' route downloads -n openshift-console --type=merge

```

Patch the default route:
```
oc patch -p "{\"spec\": {\"host\": \"default-route-openshift-image-registry.${HOSTNAME}.crc.${INSTRUQT_PARTICIPANT_ID}.instruqt.io\"}}" route default-route -n openshift-image-registry --type=merge
```

Log in via the new API url:
```
oc login -u admin -p admin api.${HOSTNAME}.crc.${INSTRUQT_PARTICIPANT_ID}.instruqt.io:6443
```

## Test your work:

1. Try logging in via the web console by clicking on the Web Console tab

2. Try logging in via the command line:

```
oc login -u developer -p developer api.${HOSTNAME}.crc.${INSTRUQT_PARTICIPANT_ID}.instruqt.io:6443
```

3. Test ingress settings for the default application routes:

```
oc new-project demo
oc new-app ruby~https://github.com/sclorg/ruby-ex.git
oc expose svc/ruby-ex
oc get route
```

Check the build status:
```
oc get builds
```

Check to make sure the newly built app returns status "200 OK":
```
curl -Ik $(oc get route | head -n 2 | tail -n 1 | awk '{print $2}')
```

Is the app being served from the new ingress routes?
```
oc get route
```
