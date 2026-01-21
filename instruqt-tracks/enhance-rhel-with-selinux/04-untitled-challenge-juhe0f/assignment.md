---
slug: untitled-challenge-juhe0f
id: wulql96otgxg
type: challenge
title: Test SElinux security
notes:
- type: text
  contents: '## Test the SELinux labeling with deployed app'
tabs:
- title: Terminal
  type: terminal
  hostname: rhel
- title: Sample App
  type: service
  hostname: rhel
  path: /
  port: 80
difficulty: ""
---
In this challenge, we will replace index.html and demonstrate SELinux's ability to block unexpected changes from causing system malfunction.

Create a new index.html file and overwrite the existing one with it.
```
cat << 'EOF' > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Red Hat Developers </title>
</head>
<body>
    <header>
        <h1>Welcome to Red Hat Developers portal clone</h1>
        <a href="https://developers.redhat.com">
            <img src="https://github.com/nageshredhat/local-openshift/blob/main/rh-dev.jpg?raw=true" alt="Red Hat Developers Logo" width="250" height="250">
        </a>
    </header>
    <main>
        <p>
            Red Hat Developers is a platform for developers to access resources, tools, and information about Red Hat technologies.
        </p>
        <p>
            Visit the <a href="https://developers.redhat.com">Red Hat Developers</a> website to learn more.
        </p>
    </main>
    <footer>
        <p>&copy; 2023 Red Hat, Inc. All rights reserved.</p>
    </footer>
</body>
</html>
EOF
```

Replace the existing index.html file with a duplicate index.html file using the following **mv** command.
```
mv index.html /var/www/html/
```
Now visit the Sample App console tab again to check the app. This time web page is not visible and a **Forbidden ERROR** is shown.
> [!NOTE]
> Kindly refresh the page ↻. To see the changes.

![image.png](..\assets\image.png)

The issue is caused by the labels attached to the files. The label assigned to the previous index.html differs from the one assigned to the current index.html file.

```
cd /var/www/html/
```
Check the labels of this file. You may notice that the labels of this file are different compared to the last index.html.
```
ls -lZ
```

To fix this issue we need to check with journalctl command as shown below.
```
journalctl -b 0
```
This command will show us the root cause and necessary remediation or solution to fix this issue.

Our issue is related to the index.html, so search it using following command in interactive mode of terminal.
```
/index.html
```
![](https://lh7-us.googleusercontent.com/lmB7PiVivfZkuZ6aH2RjweAbBvDhP7LmQJkAhZgKozJiXlz0ZcBtbArrolq31Y-_V4o4trSN-_xfvRNgHasx1ZlH8qpPUFa9h0xJ0VdQAoiLlcVB7VjLl98nP86byC_RHIcnYq1oFTGo_qD9mWxEcA)
Press **q** to exit from interactive mode in the terminal.

To fix the labels use following comand. (The same command is recommended in the snapshot above.)

```
/sbin/restorecon -v /var/www/html/index.html
```
After fixing the labels with the above command, please visit the `Sample App` tab and refresh it. You will be directed to the Red Hat Developer webpage.

This lab is a good  exercise to showcase how SELinux works with labeling, especially in Enforcing mode.

We are done with activities of SELInux on RHEL machine, so click on the **check** button.