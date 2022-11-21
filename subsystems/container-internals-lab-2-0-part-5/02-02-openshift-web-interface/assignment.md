---
slug: 02-openshift-web-interface
id: htgfofp089uo
type: challenge
title: 'Inspecting & Troubleshooting: Using the OpenShift web interface'
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/labs
difficulty: intermediate
timelimit: 675
---
In the last step, you created a multi-tier web application. Now, log into the OpenShift web interface which is a convenient place to monitor the state, and troubleshoot things when they go wrong. You can even get a debug terminal into a Pod to troubleshoot if it crashes. This can help you figure out why it crashed. This shouldn't happen in this lab, but as you build applications it surely will. Also, feel free to delete a pod and see what happens. Kubernetes will see that the defined state and actual state no longer match and will recreate it. This is useful when things are taking too long :-)

Access the OpenShift Web Console to login from the Web UI:
```
oc get routes console -n openshift-console -o jsonpath='{"https://"}{.spec.host}{"\n"}'
```
Copy the URL from the output of the above command and open it in your browser.

We'll deploy our app as the `admin` user. Use the following credentials:
* Username:

```
admin
```
* Password:
```
admin
```

Here are some useful locations to investigate what is happening. From `myproject` project, go to the "Events" section. It is useful early in the Pod creation process, when its being scheduled in the cluster and then when the container image is being pulled. Later in the process when a Pod is crashing because of something in the container image itself, its useful to watch the terminal output in the "Logs" section. It can also be useful to run commands live in a Terminal. Sometimes a Pod won't start, so it's useful poke around with using the "Debug in Terminal" section. Get a feel in the following areas of the interface.

First check out the MySQL Pod:

- Workloads -> Pods -> mysql-<id> -> Details
- Workloads -> Pods -> mysql-<id> -> Events
- Workloads -> Pods -> mysql-<id> -> Logs
- Workloads -> Pods -> mysql-<id> -> Terminal

Do the same for Wordpress:

- Workloads -> Pods -> wordpress-<id> -> Details
- Workloads -> Pods -> wordpress-<id> -> Events
- Workloads -> Pods -> wordpress-<id> -> Logs
- Workloads -> Pods -> wordpress-<id> -> Terminal

Once you've spent some time in the web interface, move on to the next lab.
