---
slug: integration-of-ansible-automation-platform-and-jenkins
id: x5clyla3ouwj
type: challenge
title: Step 4 - Integration Of Ansible Automation Platform & Jenkins
notes:
- type: text
  contents: |-
    # Integration of Ansible Automation Platform & Jenkins

    We have completed the setup of the Ansible Automation platform and Jenkins continuous integration.

    To connect the Ansible Automation platform and Jenkins, log in to the Jenkins dashboard and install the **Ansible** and **Ansible Tower** plugins from Manage Jenkins.
tabs:
- id: yzdotlyuopxt
  title: Terminal
  type: terminal
  hostname: crc
- id: ybfbniumifgl
  title: Web Console
  type: website
  url: https://console-openshift-console.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 1800
enhanced_loading: null
---
## Integration of Ansible Automation Platform & Jenkins

We have completed the setup of the Ansible Automation platform and Jenkins continuous integration. Now, we need to integrate these two components.

To connect the Ansible Automation platform and Jenkins, log in to the Jenkins dashboard and install the **Ansible** and **Ansible Tower** plugins from Manage Jenkins.

Go to Manage Jenkins > System Configuration > Configure System > Ansible Tower.

Fill in all details of the Ansible Automation Platform Endpoint and credentials. You need to create one set of credentials for logging in to the Ansible Automation platform console.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_tower_conf.png?raw=true)

To check whether the credentials are working or not, click on **Test Connection**. If the connection is successful, **Success** will appear.

Let’s create a new **Freestyle project**.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_freestyle_select.png?raw=true)

In the pipeline from the build section, select Ansible Tower.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_build_tower_select.png?raw=true)

After that, fill in the details as shown below.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_tower_pipeline_filled.png?raw=true)

Select the build triggers as "Build after other projects are built."

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_ci_trigger_in_cd.png?raw=true)

In Build Triggers, check the "Build after other projects are built" option and add the continuous integration pipeline name.

It's time now to see an end-to-end pipeline in action. To do that, you have to clone the GitHub repository in your favorite code editor like VScode or PyCharm.
> [!IMPORTANT]
> Kindly consider here the forked repository.

Checkout into the git folder and make some changes in your GitHub repository.


After completing your changes, it's time to push them to the GitHub repository using git commands:

```
git add .
```

```
git commit -m "my changes"
```

```
git push
```

After push, check the Jenkins dashboard. The Continuous Integration pipeline will start. It will build and push the container image. Later on, the Continuous Deployment pipeline will start with the help of Ansible Automation Platform,  it will deploy the pod in OpenShift cluster.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_cd_op.png?raw=true)

Check the OpenShift cluster from a developer's perspective.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/openshift_game_dployed.png?raw=true)

Click on the route icon to play the game.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/playing_game.png?raw=true)

# What's Next?

Congratulations on completing this lab. Ready to continue learning?

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!