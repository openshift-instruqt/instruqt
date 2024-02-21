---
slug: 03-uploading-files-to-a-container
id: nglthirlo3z4
type: challenge
title: Topic 3 - Uploading Files to a Container
notes:
- type: text
  contents: Topic 3 - Uploading files to a container
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
difficulty: intermediate
timelimit: 360
---
In this topic you will learn how to copy a file from the local machine into the application container. You will copy a new version of the `message.txt` file from the local machine into the application container.

The file, `message.txt`, stores the message that the demonstration application `simplemessage` displays in the application's web page. The new version of `message.txt` will have a new message that will automatically be rendered in the application's web page when the file copy is complete.

----

The first thing you need to is to recreate an instance of the environment variable `POD`. (The interactive learning environment requires that each time a topic is run the need environment variables need to be recreated.)

`Step 1:` Run the following command to extract the `simplemessage` pod name from the OpenShift cluster and store it in the environment variable named `POD`:

```
POD=$(oc get pods --selector deployment=simplemessage -o custom-columns=NAME:.metadata.name --no-headers); echo $POD
```
You'll get output similar to the following. (Your output will be a bit different):

```
simplemessage-7fcb66cfb6-hmdpd
```

The form of the command when copying files from the local machine to the container is:
```
oc rsync ./local/dir <pod-name>:/remote/dir
```
Unlike copying from the container to the local machine, there is no form for copying a single file into a container. In order to copy selected files only, you need to use the `--exclude` and `--include` options to filter what is and isn't to be copied from a specified directory.

Let's examine the process.

----

`Step 2:`  Run the following command to navigate to the `/tmp` directory:

```
cd /tmp
```
----

`Step 3:` Copy the following command into the terminal window to the left to create a new version of `message.txt`:

```
echo 'OpenShift really, really, really rocks!!!!' > message.txt
```

----


`Step 4:` Run the following command to verify that the new version of  `message.txt` was created:

```
cat message.txt
```

You'll get output similar to the following:

```
OpenShift really, really, really rocks!!!!
```

----

`Step 5:` Run the following command to copy the new version of `message.txt` from the local machine into the directory `/opt/app-root/src` of the application's container that has its name stored in the environment variable `POD`:

```
oc rsync . $POD:/opt/app-root/src --exclude=* --include=message.txt --no-perms
```
You'll get output similar to the following.

```
sending incremental file list
message.txt

sent 157 bytes  received 41 bytes  396.00 bytes/sec
total size is 43  speedup is 0.22
```

When copying files to the container, it is required that the directory that files are being copied into exists, and that it is writable to the user or group that the container is being run as. Permissions on directories and files should be set as part of the process of building the image.

In the above command, the `--no-perms` option is also used because the target directory in the container, although writable by the group the container is run as, is owned by a different user than the container is run as. This means that although files can be added to the directory, permissions on existing directories cannot be changed. The `--no-perms` option tells `oc rsync` to not attempt to update permissions to avoid it failing and returning errors.

----


`Step 6:` Run the following command get the URL to the application's web site and store the URL in an environment variable named `APP_ROUTE`:

```
export APP_ROUTE=`oc get route simplemessage -n myproject -o jsonpath='{"http://"}{.spec.host}'` && echo $APP_ROUTE
```
You'll get output similar to the following:

```
http://simplemessage-myproject.crc-lgph7-master-0.crc.ai7oaxyso7ih.instruqt.io
```

The output above is the URL to the SimpleMessage application running in this OpenShift cluster. The URL you create will be different. Remember: The actual structure of the URL is special to the running instance of OpenShift.

----

`Step 7:` Copy the URL from the output above into your web browser's address bar. You will see the new message appear as shown in the figure below.

![Web Output](..\assets\web-output.png)

As you can see, the new message you created in `message.txt` is now displayed in the web page.

This worked because the SimpleMessage application reads the content of the `message.txt` file at runtime to get the particular message to display. You changed the content of `message.txt`. Hence, you changed the message that gets displayed in the SimpleMessage application.

If instead of copying a single file you wanted to copy a complete directory, leave off the ``--include`` and ``--exclude`` options. To copy the complete contents of the current directory to the ``htdocs`` directory in the container, run:

```
oc rsync . $POD:/opt/app-root/src --no-perms
```

The thing to remember about using `oc rsync` is that unless precautions are taken, all files including the hidden files or directories starting with "." in the source directory will be copied to the filesystem in the target container. Therefore, you need to be careful. Use the `--include` or `--exclude` options to limit the set of files or directories that you want to copy.

# Congratulations!

 You've just learned how to use `oc rsync` to copy files from the local machine to a target container.

----

**NEXT:** Synchronizing files with a container
