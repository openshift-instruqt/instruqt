---
slug: 04-troubleshooting-distributed-applications
id: p7vfcxznxx8m
type: challenge
title: 'Distributed Debugging: Troubleshooting in a distributed systems environment'
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
The goal of this exercise is to understand the nature of a distributed systems environment with containers. Quickly and easily troubleshooting problems in containers requires distributed systems thinking. You have to think of things programatically. You can't just ssh into a server and understand the problem. You can execute commands in a single pod, but even that might prevent you from troubleshooting things like network, or database connection errors which are specific to only certain nodes. This can happen because of persnickety differences in locations of your compute nodes in a cloud environment or code that only fails in unforeseen ways at scale or under load.

We are going to simulate one of these problems by using a specially designed test application. In this exercise we will learn how to figure things out quickly and easily.

Inspect each of the files and try to understand them a bit:

```
cat ~/labs/goodbad/Build.yaml
```

```
cat ~/labs/goodbad/Run.yaml
```


Build the test application. **Wait** for the build to successfully complete. You can watch the log output in the OpenShift web interface.

```
oc create -f ~/labs/goodbad/Build.yaml
```


```
oc get builds
```

```
oc get pods
```

You can watch the logs like this. Keep running the following command until you see "Push successful" in the logs:

```
oc logs goodbad-1-build
```

When the above build completes, run the test application:

```
oc create -f ~/labs/goodbad/Run.yaml
```


Get the IP address for the goodbad service

```
oc get svc
```


Now test the cluster IP with curl. Use the cluster IP address so that the traffic is balanced among the active pods. You will notice some errors in your responses. You may also test with a browser. Some of the pods are different - how could this be? They should be identical because they were built from code right?

```
SVC_IP=$(oc get svc | grep goodbad | awk '{print $3}')
for i in {1..20}; do curl $SVC_IP; done
```


Example output:

```
ERROR
ERROR
Hello World
ERROR
```


Take a look at the code. A random number is generated in the entry point and written to a file in /var/www/html/goodbad.txt:

```
cat ~/labs/goodbad/index.php
```

```
cat ~/labs/goodbad/Dockerfile
```


Troubleshoot the problem in a programmatic way. Notice some pods have files which contain numbers that are lower than 7, this means the pod will return a bad response:

```
for i in $(oc get pods | grep goodbad | grep -v build | awk '{print $1}'); do oc exec -t $i -- cat /var/www/html/goodbad.txt; done
```


Continue to troubleshoot the problem by temporarily fixing the file

```
for i in $(oc get pods | grep goodbad | grep -v build | awk '{print $1}'); do oc exec -t $i -- sed -i -e s/[0-9]*/7/ /var/www/html/goodbad.txt; done
```


Write a quick test that verifies the logic of your fix

```
for i in {1..2000}; do curl $SVC_IP 2>&1; done | grep "Hello World" | wc -l
```


Scale up the nodes, and test again. Notice it's broken again because new pods have been added with the broken file

```
oc scale rc goodbad --replicas=10
```

```
for i in {1..2000}; do curl $SVC_IP 2>&1; done | grep "Hello World" | wc -l
```


Optional: As a final challenge, fix the problem permanently by fixing the logic so that the number is always above 7 and never causes the application to break. Rebuild, and redeploy the application. Hint: you have to get the images to redeploy with the newer versions (delete the rc) :-)
