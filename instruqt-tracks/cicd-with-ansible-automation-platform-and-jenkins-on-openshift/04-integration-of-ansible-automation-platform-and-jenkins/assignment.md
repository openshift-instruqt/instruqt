---
slug: integration-of-ansible-automation-platform-and-jenkins
id: x5clyla3ouwj
type: challenge
title: Integration Of Ansible Automation Platform & Jenkins
difficulty: basic
timelimit: 3600
---


# Integration Of Ansible Automation Platform & Jenkins

We are done with the Ansible Automation platform setup & Jenkins continuous integration. Now integrate these two components together.

We need to connect the Ansible Automation platform & Jenkins. For that login to the jenkins dashboard & install **Ansible** & **Ansible Tower** plugins from manage Jenkins.

Go into Manage Jenkins > System Configuration > Configure System > Ansible Tower

Fill in all details of Ansible Automation Platform Endpoint & credentials.
You have to create one credentials login & password for the Ansible Automation platform console.


![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_tower_conf.png?raw=true)

To check whether credentials are working or not click on **Test Connection**. If the connection is working **Success** will appear.

Let’s create a new **Freestyle project**

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_freestyle_select.png?raw=true)



In the pipeline from the build section select the Ansible Tower

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_build_tower_select.png?raw=true)

After that fill in the details as shown below.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_tower_pipeline_filled.png?raw=true)

Select the build triggers as Build after other projects are built.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_ci_trigger_in_cd.png?raw=true)

In Build Triggers check the `Build after other projects are built` and add  the continuous integration pipeline name.

It's time now to see an end to end pipeline in action for that you have to clone the GitHub repository in your favorite code editors like VScode or pycharm.

Checkout into the git folder & do some mirror changes like add `#` in any file.

After you are done with your changes it time push the changes in github repository. By using git commands.

```
git add .
```

```
git commit -m "my changes"
```

```
git push
```

After the push check the Jenkins dashboard. The Continues-integration pipeline will start. It will build & push the container image. Later on, the continues-deployment pipeline will start & with the help Ansible Automation Platform it will deploy the pod in Oenshift cluster.

![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/jenkins_cd_op.png?raw=true)

Check the openshift cluster from Developer perspective


![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/openshift_game_dployed.png?raw=true)

Click on the route icon to play the Game.



![AltText](https://github.com/redhat-developer-demos/ansible-automation-platform-continous-delivery-demo/blob/main/assets/playing_game.png?raw=true)
