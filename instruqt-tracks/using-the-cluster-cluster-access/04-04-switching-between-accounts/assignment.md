---
slug: 04-switching-between-accounts
id: wyjalyoetyok
type: challenge
title: Topic 4 - Switching Users Between Accounts
notes:
- type: text
  contents: Switching Users Between Accounts
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 501
---
In this topic you'll learn how to use the `oc login` command to move among a variety of OpenShift user accounts

The `oc` command line tool allows you to interact with only one OpenShift cluster at a time.

Thus, it's not possible to open a separate shell on a computer as one local user and work on an OpenShift cluster dedicated to another user. This is because state about the current login session is stored in the home directory of the local user running the `oc` command.

If you do need to work against multiple OpenShift clusters, or even as different users on the same OpenShift cluster, you will need to switch to the login context for a particular user.

In this track you originally logged in from the command line using `oc login` as the `developer` user. The, you in a subsequent topic you logged in as the `user1` user.

At this point you are still logged in and have an active session token for both users, but you are currently operating as the `user1` user.

----

`Step 1:` Run the following command in the terminal window to switch back to the user named `developer`:

```
oc login --username developer
```

You'll get the following output:

```
Logged into "https://api.crc.testing:6443" as "developer" using existing credentials.

You have one project on this server: "myproject"

Using project "myproject".
```

You don't need to provide a password for the user named `developer` because you provided the password during your previous login.

The OpenShift `oc` CLI tool keeps login information stored on the local machine.  The only time you'll be prompted to provide a password or supply a new session token is when the active session had expired.

----

`Step 2:` Run the following command to validate that you are now the `developer`:
```
oc whoami
```

You'll get the following output:

```
developer
```

When you are working against multiple OpenShift clusters, you switch between them by using the `oc login`. You only need to supply the URL for the OpenShift cluster. For example, if you had an account with the [Developer Sandbox for OpenShift](https://developers.redhat.com/developer-sandbox), you could run something similar:

```
oc login --token=<token> --server=https://api.sandbox-m2.ll9k.p1.openshiftapps.com:6443
```

When switching between OpenShift clusters, if you do not explicitly say which user to use, OpenShift will use the last user logged into the cluster. You can still provide `--username` if required.

Switching among users without needing to supply the password or register with a token is possible because the details for each user are saved separately in what is called a context.

Run the following command to view the current context:

```
oc whoami --show-context
```

You'll get the following output:

```
myproject/api-crc-testing:6443/developer
```

----

`Step 3:` Run the following command to list all OpenShift clusters you have logged into:

```
oc config get-clusters
```

You'll get the following output:

```
myproject/api-crc-testing:6443/developer
```

----

`Step 4:` Run the following command to get a list of all contexts that have ever been created:

```
oc config get-contexts
```

You'll get output similar to the following:

```
root@crc-lgph7-master-0 /]# oc config get-contexts
CURRENT   NAME                                         CLUSTER                AUTHINFO                         NAMESPACE
          /api-crc-testing:6443/user1                  api-crc-testing:6443   user1/api-crc-testing:6443
          admin                                        crc                    admin
          myproject/api-crc-testing:6443/developer     api-crc-testing:6443   developer/api-crc-testing:6443   myproject
*         yourproject/api-crc-testing:6443/developer   api-crc-testing:6443   developer/api-crc-testing:6443   yourproject
          yourproject/api-crc-testing:6443/user1       api-crc-testing:6443   user1/api-crc-testing:6443       yourproject
```

As you can see there are a number of contexts in force.

# Congratulations!

 You've just learned how to use the `oc login`  command to switch the user working within an OpenShift cluster and get context information for a single user in general and all contexts in general.

----

This is the final topic in this track.

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
