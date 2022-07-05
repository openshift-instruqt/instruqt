---
slug: 04-synchronizing-files-with-a-container
id: hvbgllcrysns
type: challenge
title: Topic 4 - Synchronizing Files with a Container
notes:
- type: text
  contents: Topic 4 - Synchronizing files with a container
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
difficulty: intermediate
timelimit: 360
---

In this topic you will learn how to implement automatic synchronization of the file updates between the local machine and the file system for the SimpleMessage application running within this track's OpenShift clusters.

In addition to being able to manually upload or download files when you choose to, the `oc rsync` command can be configured to perform live synchronization of files between your local computer and the container.

When automated updates are in force, your local computer's file system will be monitored for any changes made to files. When there is a change to a file, the changed file will automatically be copied to the container's file system. This same process can also be run in the opposite direction, with changes made in the container automatically copied back to your local computer.

An example of where automatic updates can be useful is during the development of an application. Automatic updates are particularly useful for interpreted programming languages like Node.js, PHP, Python, or Ruby.

Interpreted languages require no separate compilation phase before deployment. Thus, you can update files used at runtime and see the changes immediately. Also, OpenShift allows you to restart the web server in cases where the changes you make require a server restart.

The following steps show how to set up `oc rsync` to do automatic updates. You will change the contents of the `message.txt` file on the local machine.Once `message.txt` is changed, the file will automatically upload to the pod running SimpleMessage.

The result is that the new message stored in the `message.txt` file will appear in the SimpleMessage web page automatically.

|NOTE|
|----|
|This topic uses the `oc rsync` command many time. Thus, you might want to learn the details of the command before proceeding. Click this [link](https://docs.openshift.com/container-platform/3.11/dev_guide/copy_files_to_container.html) to go to a in-depth discussion of  `oc rsync`|

----

The first thing you need to do is to recreate an instance of the environment variable `POD`. (The interactive learning environment requires that each time a topic is run the need environment variables need to be recreated.)

`Step 1:` Run the following command to extract the `simplemessage` pod name from the OpenShift cluster and store it in the environment variable named `POD`:

```
POD=$(oc get pods --selector deployment=simplemessage -o custom-columns=NAME:.metadata.name --no-headers) && echo $POD
```

You'll get output similar to the following but your specific pod name will be different:

`simplemessage-8688fb4cb7-pnpmc`


----

`Step 2:` Run the following command to navigate to the `/tmp` directory. (You stored the file `message.txt` in `/tmp` in the last tropic):

```
cd /tmp
```

----

`Step 2:` Run the following command in the terminal window to the left:

```
oc rsync . $POD:/opt/app-root/src --no-perms --watch > /dev/null 2>&1 &
```

The command you just ran will make OpenShift notice when a file changes on the local machine, so it will copy the changed file onto the application's container's filesystem. This synchronization process runs in the background so that you can still work in the terminal window.

----

`Step 3:` Run the following command to confirm that you are in the right directory `/tmp`:

```
pwd
```

You'll get the following output
```
/tmp
```

----

`Step 4:` Run the following command to read the contents of `message.txt`:

```
cat message.txt
```

You get the following output:

```
OpenShift really, really, really rocks!!!!
```

This is the message you updated in the previous topic.

----

`Step 5:` Run the following command to update the contents of the `message.txt` file with a new message:

```
echo 'I like OpenShift!' > message.txt
```
----

`Step 6:` Run the following command to verify that the contents of `message.txt` have changed:

```
cat message.txt
```

You get the following output:

```
I like OpenShift!
```

----

`Step 7:` Run the following command in **Terminal 1** to get the URL to the SimpleMessage application running in the OpenShift cluster:

```
export APP_ROUTE=`oc get route simplemessage -n myproject -o jsonpath='{"http://"}{.spec.host}'` && echo $APP_ROUTE
```

You'll get output similar to the following. (Your actual URL will be different):

```
http://simplemessage-myproject.crc-5nvrm-master-0.crc.ai7oaxyso7ih.instruqt.io
```

----

`Step 8:` Copy the URL you retrieved in the previous step into a web browser. You'll see a web page as shown in the figure below.

![Updated Web Page](../assets/updated-web-output.png)

As you can see, the web page was updated. The container's file system will now be updated automatically, and the web page has the new message you entered in `message.txt`.

Remember, the way SimpleMessage works is that the message to display in its web page is stored in the `message.txt` file. Changing the text in `message.txt` will make the new text display on the SimpleMessage web page.

In this case, you configured `oc rsync` to automatically copy `message.txt` to the SimpleMessage container when the contents of `message.txt` changed. Thus, the website updated automatically.


## Congratulations!

 You just learned how to configure the `oc rsync` command to automatically upload local files to a container when the content of a local file changes.

----

**NEXT:** Copying files to a persistent volume