---
slug: jenkins-install
id: nztpivixukj5
type: challenge
title: Step 3 - Jenkins Installation
notes:
- type: text
  contents: |-
    # Jenkins Setup
    In this challenge, we'll delve into the process of setting up the Jenkins pod from the developers catalog.
tabs:
- title: Terminal
  type: terminal
  hostname: crc
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-rwwzd-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 1000
---
## Jenkins Setup

Log in to the OpenShift dashboard. Select the Developer perspective and right-click "Add to Project." Select "From Catalog" and search for "Jenkins."

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_catalog_add.png?raw=true)

Select Jenkins, which has extra permissions because RBAC permission is required for this task.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_catalog_search1.png?raw=true)

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_install2nd.png?raw=true)

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_install3nd.png?raw=true)

Installation may take some time. After installation of the Jenkins pod appears in the topology view in the **dev-game-app** project, click on the arrow mark to access the dashboard of Jenkins.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_extra_permission_allow.png?raw=true)

Click on "Allow selected permission" to proceed.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_loginwith_admin.png?raw=true)

Select "Login with OpenShift" and fill in admin/admin credentials.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_dashboard.png?raw=true)

To enable continuous build and push, we need to create a build config here using a config file.

```
oc project dev-game-app
```
> [!IMPORTANT]
> If you already have an account of container registry such as Quay.io or Dockerhub, use the credentials in the following steps.
> If you don't have one, kindly visit [quay.io](https://quay.io/) and create an account.

Before executing the following command, ensure that you replace the image with your container registry.

Example :  `name: quay.io/nagesh-redhat/cd:latest`
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
Now, create a secret for image building. This secret will help the image to push to the Quay container registry. Replace the credentials with your container registry account in the following command:

```
oc create secret docker-registry my-secret --docker-server=quay.io --docker-username=<your-container-registry-id>  --docker-password=xxx
```

```
oc secrets link builder my-secret --for=mount
```

Let’s create a Continuous Integration pipeline. To do that, you need to log in first to the Jenkins console with the help of OpenShift credentials so that you can log in to the Jenkins Dashboard.

For pipeline creation, go to New Item, select Pipeline, and give a name to that Pipeline.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_pipeline.png?raw=true)

Let’s configure the Continuous Integration pipeline.
Scroll down in the pipeline section and select the Pipeline script from SCM.

> [!IMPORTANT]
> Kindly provide the URL of  your forked GitHub repository here.

SCM: Git

Repository URL:
```
https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo.git
```


Branch: `*/main`


Script Path: `Jenkinsfile`



![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_filled_pipe.png?raw=true)

When the developer commits the code in a repo, we need something in place that can detect the changes and start the pipeline. For that, we have to enable the triggers and polling for every minute.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_build_trigger.png?raw=true)

Let’s run the pipeline now. From the left menu, click on Build Now.


![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_ci_op.png?raw=true)

In the next and final step, we'll integrate the Ansible Automation Platform & Jenkins.
