---
slug: jenkins-install
id: nztpivixukj5
type: challenge
title: Jenkins Installation
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
  path: /root/backend
difficulty: basic
timelimit: 1000
---
**JENKINS SETUP**

Login to the openshift dashboard. Select Developer perspective & right-click Add to Project select From Catalog and search for “Jenkins”.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_catalog_add.png?raw=true)

Select  Jenkins which has extra permission because for this task RBAC permission is required.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_catalog_search1.png?raw=true)

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_install2nd.png?raw=true)

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_install3nd.png?raw=true)

Installation may take some time. After Installation of Jenkins pod appears in the topology view in the **dev-game-app** project. click on the arrow mark to access the dashboard of Jenkins

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_extra_permission_allow.png?raw=true)

Click on `Allow selected permission` to proceed.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_loginwith_admin.png?raw=true)

Select login with openshift & fill in admin/admin credentials.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_dashboard.png?raw=true)

For continuous build & push. We need to create the Build config here by using a config file.

```
oc project dev-game-app
```
Before executing the following command make sure you replace the image name with your container registry.
```
 cat <<EOF | oc create -f -
apiVersion: build.openshift.io/v1
kind: BuildConfig
metadata:
  labels:
    app.kubernetes.io/name: red-api #--------------> your application name
  name: red-api #------------------------> your application name
spec:
  output:
    to:
      kind: DockerImage
      name: quay.io/<username>/cd:latest #----------------->add yourimage
  source:
    # Expect a local directory to be streamed to OpenShift as a build source
    type: Binary
    binary: {}
  strategy:
    type: Docker
    dockerStrategy:
      # Find the image build instructions in ./Dockerfile
      dockerfilePath: Dockerfile
EOF
```
Now create a secret for image building. This secret will help the image to push on the quay container registry. If you don't have a Quay.io container registry account check [**here**](https://docs.quay.io/guides/create-repo.html#:~:text=via%20the%20UI-,To%20create%20a%20repository%20in%20the%20Quay.io%20UI%2C%20click,the%20'Create%20Repository'%20button.). Replace the credentials as per your container registry account in following command.

```
oc create secret docker-registry my-secret --docker-server=quay.io --docker-username=<your-container-registry-id>  --docker-password=xxx
```
```
oc secrets link builder my-secret --for=mount
```

Let’s create Continues Integration pipeline. For that, you need to login first to jenkins console with help of openshift credentials you can login to Jenkins Dashboard.

For pipeline, creation go to New Item select Pipeline & give a name to that Pipeline

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_pipeline.png?raw=true)

Let’s configure the Continous-integration pipeline.
Scroll down in the pipeline section and select the Pipeline script from SCM.

SCM : Git

Repository URL:
```
https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo.git
```


Branch : `*/main`


Script Path: `Jenkinsfile`


![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_filled_pipe.png?raw=true)

When the Developer commits the code in a repo we need something in place which can detect the changes & start the pipeline for that we have to enable the triggers & polling for every minute.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_build_trigger.png?raw=true)

Let’s run the pipeline now from the left menu click on Build Now.


![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_ci_op.png?raw=true)

