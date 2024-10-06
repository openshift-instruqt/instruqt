---
slug: 05-copying-files-to-a-persistent-volume
id: gdvx7xynkgk3
type: challenge
title: Topic 5 - Copying Files to a Persistent Volume
notes:
- type: text
  contents: Topic 5 - Copying files to a Persistent Volume
tabs:
- id: gsyy7qsr9ior
  title: Terminal 1
  type: terminal
  hostname: crc
difficulty: intermediate
timelimit: 360
---
In this topic you will learn how to use persistent volumes under OpenShift in conjunction with the `oc rsync` command.

A persistent volume is similar to a mounted drive under Linux, in that it has a lifecycle independent of any individual pod that uses the persistent volume. The process for using a persistent volume is that an administrator creates it. Then, a developer creates a persistent volume claim to reserve space on the persistent volume for their application.

Here you will create a create a dummy application using `oc new-app`, and use the `oc set volume` command to create a persistent volume and mount it into the file system 0f the dummy application. Then, you can use use `oc rsync` to copy files into a persistent volume. All you need to do is supply the mounting path to the persistent volume in the container's file system.

----

# Creating the dummy application

`Step 1:` Run the following command to create the dummy application:

```
oc new-app centos/httpd-24-centos7 --name dummy
```

You'll get output similar to the following:

```
--> Found container image 5ae4c76 (8 months old) from Docker Hub for "centos/httpd-24-centos7"

    Apache httpd 2.4
    ----------------
    Apache httpd 2.4 available as container, is a powerful, efficient, and extensible web server. Apache supports a variety of features, manyimplemented as compiled modules which extend the core functionality. These can range from server-side programming language support to authentication schemes. Virtual hosting allows one Apache installation to serve many different Web sites.

    Tags: builder, httpd, httpd24

    * An image stream tag will be created as "dummy:latest" that will track this image

--> Creating resources ...
    imagestream.image.openshift.io "dummy" created
    deployment.apps "dummy" created
    service "dummy" created
--> Success
    Application is not exposed. You can expose services to the outside world by executing one or more of the commands below:
     'oc expose service/dummy'
    Run 'oc status' to view your app.
```

The application you just installed is an Apache HTTPD server. You're using the server a means of keeping a deployment configuration that has a pod that needs to be kept running.

----

`Step 2:` Run the following command to monitor pod's startup and ensure that it deployed:

```
oc rollout status deployment/dummy
```

You'll get output similar to the following:

```
Waiting for deployment "dummy" rollout to finish: 0 of 1 updated replicas are available...
deployment "dummy" successfully rolled out
```

# Creating the persistent volume and the persistent volume claim

Now that you have a running application, next you need create a persistent volume claim against a persistent volume. You'll use the dummy application against the persistent volume claim you're about to create.

You will start by using the `oc set volume` command. This command creates the persistent volume and the associated persistent volume claim automatically.

----

`Step 3:`  Run the following command to create a persistent volume named `tmp-mount`, along with a persistent volume claim named `data`. The Persistent Volume Claim will reserve 1 gigabyte of storage space on the Persistent Volume.

The mount point in the application container's file system will be `/mnt`. (`/mnt` is the conventional directory used in Linux systems for temporarily mounting a volume).

```
oc set volume deployment/dummy --add --name=tmp-mount --claim-name=data --type pvc --claim-size=1G --mount-path /mnt
```

You'll get output similar to the following.

```
deployment.apps/dummy volume updated
```

As mentioned above, running `oc set volume` will create the Persistent Volume and the Persistent Volume Claim. Also, the command will bind the application to the Persistent Volume

----

`Step 4:`  Run the following command to report the progress of the deployment so you'll know when it's complete.

```
oc rollout status deployment/dummy
```

You'll get output similar to the following.

```
deployment "dummy" successfully rolled out
```

`Step 5:` Run the following command to confirm that the persistent volume claim was successful:

```
oc get pvc
```

You'll get output similar to the following:

```
NAME   STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
data   Bound    pv0014   100Gi      RWO,ROX,RWX                   71s
```

# Creating the environment variable `POD`

`Step 6:`  Run the following command to extract the dummy application's pod name  from the OpenShift cluster and store it in the environment variable named `POD`:

```
POD=$(oc get pods --selector deployment=dummy -o custom-columns=NAME:.metadata.name --no-headers) && echo $POD
```

You'll get output similar to the following, but your specific pod name will be different:

```
dummy-5b644f7658-9lp66
```

You can now copy any files into the persistent volume using the `/mnt` directory as the target. Remember: The `/mnt` directory is where you mounted the persistent volume as the target directory.


# Copying a file into the persistent volume

`Step 7:` Run the following command to navigate to the `/opt` directory, create a subdirectory named `persist` and, then navigate into that new subdirectory:


```
cd /opt && mkdir persist && cd persist && pwd
```

You'll see the following output:

```
opt/persist
```

----

`Step 8:`  Run the following command to create a text file with some data in the `/opt/persist` directory

```
echo 'I am some data.' > data.txt
```

----

`Step 9:` Run the following command to verify the contents of the `data.txt` file:

```
cat data.txt
```

You'll see the following output:

```
I am some data.
```

----

`Step 10:`  Run the following `oc rsync` command to copy the file `data.txt` to the application's container's persistent volume:

```
oc rsync ./ $POD:/mnt --exclude=* --include=data.txt --no-perms
```

You'll see the following output:

```
sending incremental file list
data.txt

sent 127 bytes  received 35 bytes  108.00 bytes/sec
total size is 16  speedup is 0.10
```

----

`Step 11:`  Run the following command to validate that the files were transferred by listing the contents of the target directory inside of the container:

```
oc rsh $POD ls -las /mnt
```

You'll see the following output:

```
total 4
0 drwxrwx---. 2 root       root 22 Mar 29 23:44 .
0 dr-xr-xr-x. 1 root       root 61 Mar 29 23:43 ..
4 -rw-r--r--. 1 1000640000 root 16 Mar 29 23:44 data.txt
```
Notice that the file `data.txt` was uploaded to the persistent volume that was mounted into the application's container.

# Unmounting the persistent volume

`Step 12:` Run the following command to unmount the persistent volume and yet keep the dummy application operational:

```
oc set volume deployment/dummy --remove --name=tmp-mount
```

You'll get output similar to the following:

```
deployment.apps/dummy volume updated
```

Unmounting a persistent volume is useful when you want to attach another persistent volume that contains different data. An example use case is when you want to use data from a variety of databases.

----

`Step 13:`  Run the following command to monitor the process once again to confirm that the re-deployment has completed:

```
oc rollout status deployment/dummy
```

You'll get output similar to the following:

```
deployment "dummy" successfully rolled out
```
----

`Step 14:` Run the following command to capture the name of the current pod again:

```
POD=$(oc get pods --selector deployment=dummy -o custom-columns=NAME:.metadata.name --no-headers) && echo $POD
```

You'll get output similar to the following, but your specific pod name will be different:

```
dummy-5b644f7658-9lp66
```

----

`Step 15:` Run the following command to look again at the target directory's content. It should be empty at this point. This is because the persistent volume is no longer mounted in the container's file system:

```
oc rsh $POD ls -las /mnt
```

You'll get the following output:

```
total 0
0 drwxr-xr-x. 2 root root  6 Apr 11  2018 .
0 dr-xr-xr-x. 1 root root 61 Mar 29 20:45 ..
```

The directory will be empty because the persistent volume is no longer mounted, and you are looking at the directory within the local container file system.

# Remounting a volume claim

If you already have an existing persistent volume claim, as you now do, you could mount the existing claimed volume to the dummy application instead.

Remounting the persistent volume claim is different than the process you followed above, in which you created the persistent volume, created a  persistent volume claim using the persistent volume, and then finally mounted it to the application at the same time.

In this case case you will remount an existing persistent volume claim.

----

`Step 16:` Run the following command to remount the persistent volume claim named `data`:

```
oc set volume deployment/dummy --add --name=tmp-mount --claim-name=data --mount-path /mnt
```

You'll get output similar to the following:

```
deployment.apps/dummy volume updated
```
----

`Step 17a:`  Run the following command to capture the name of the current pod again. (Remember: Under OpenShift, every time you redeploy a pod, its name changes):

```
POD=$(oc get pods --selector deployment=dummy -o custom-columns=NAME:.metadata.name --no-headers) && echo $POD
```
You'll get output similar to the following:

```
dummy-5b644f7658-2p57r
```

`Step 17b:` Run the following command to check the contents of the target directory now that the persistent volume claim has been reattached:


```
oc rsh $POD ls -las /mnt
```

You'll get output similar to the following:

```
total 4
0 drwxrwx---. 2 root    root 22 Mar 29 20:44 .
0 dr-xr-xr-x. 1 root    root 61 Mar 29 20:49 ..
4 -rw-r--r--. 1 default root 16 Mar 29 20:44 data.txt
```

The file named `data.txt` that you copied to the persistent Vvolume is now visible.


# Understanding the independence of a persistent volume and a persistent volume claim

The benefit of a persistent volume and a persistent volume claim is that they can live on even after an application has been deleted. Let's take a look.


`Step 18:` Run the following command to delete all of the OpenShift resources that have the label `deployment=dummy`. (You'll implicitly be delete the dummy application):

```
oc delete all --selector deployment=dummy --force
```

You'll get output similar to the following:

```
pod "dummy-5b644f7658-2p57r" deleted
replicaset.apps "dummy-574985dc7f" deleted
replicaset.apps "dummy-5b644f7658" deleted
replicaset.apps "dummy-67cfc5c656" deleted
```

----

`Step 19:` Run the following command to see if the persistent volume claim that was assigned to the dummy application is still available in the cluster:


```
oc get pvc
```

You'll get output similar to the following:

```
NAME   STATUS   VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
data   Bound    pv0023   100Gi      RWO,ROX,RWX                   14m
```

As you can see, although the dummy application was deleted, the persistent volume claim still exists and can later be mounted against your actual application that needs the data.

## Congratulations!

You've just learned how to use the command `oc set volume` to create a persistent volume and a persistent volume claim automatically.

You created a dummy application that uses the Persistent Volume Claim.

You used the `oc rsync` command to copy files from the local machine into the persistent volume in the application's container.

Then, you learned how to use the `oc set volume` command to unmount and remount a persistent volume and a persistent volume claim.

----

This is the final topic is this track.

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
