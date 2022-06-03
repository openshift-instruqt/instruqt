---
slug: 02-logging-in-via-the-command-line
id: y4jp6qtqrped
type: challenge
title: Topic 2 - Logging in via the Command Line
notes:
- type: text
  contents: Logging in via the Command Line
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 150
---
In this topic you will learn how to log into OpenShift from a terminal using the `oc login` command.

# Logging into OpenShift from the command line

`Step 1:` Run the following command to log into OpenShift using the `-u` option to declare the username, and `-p` to declare the user's password:

```
oc login -u developer -p developer
```

You will see output similar to the following:

```
Login successful.

You don't have any projects. You can try to create a new project, by running

    oc new-project <projectname>
```

# Working with Projects

`Step 2:` Run the following command to enter the project namespace `myproject`. Remember you created the project `myproject` in the previous topic using the web console:

```
oc project myproject
```

You'll get output similar to the following:

```
Already on project "myproject" on server "https://api.crc.testing:6443".
```

----

`Step 3:` Run the following to list all of the projects you currently have access to:

```
oc get projects
```

You get output similar to the following:

```
NAME        DISPLAY NAME   STATUS
myproject   myproject      Active
```
----

`Step 4:` Run the following command to verify the current logged in user:

```
oc whoami
```

You get the following output, which reports the name of the currently logged in user. In this case, the user is `developer`:

```
developer
```

----

`Step 5:` Run the following command to verify the server you are logged into:

```
oc whoami --show-server
```
You get output similar to the following:

```
https://api.crc.testing:6443
```

In the case where an external authentication service is used as the identity provider, the login steps are a bit different.

When you log in at the command line using `oc login` without providing the username (`-u`) and password (`-p`) options, you will get an error similar to the following. The response directs you to an authentication server:

```
You must obtain an API token by visiting https://oauth-openshift.crc-gh9wd-master-0.crc.d9avlfzludvk.instruqt.io/oauth/token/request
```

Once you get your API token, you receive a user's login credentials from the authentication server according to that server's authentication process.

Then, once you get the login information from the authentication server, return to the terminal window and execute `oc login` using those authentication credentials.

# Congratulations!

 You've just learned how to log into OpenShift from the command line.

----

**NEXT:** Collaborating with other users
