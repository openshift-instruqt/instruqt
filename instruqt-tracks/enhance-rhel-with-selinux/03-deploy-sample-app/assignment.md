---
slug: deploy-sample-app
id: ehrptptf6ius
type: challenge
title: Deploy sample app
notes:
- type: text
  contents: '## Deploy sample Red Hat Developers website with httpd server'
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
Install the httpd server on the RHEL system  using the following command:
```
dnf install httpd -y
```
Enable the httpd server and verify the status to ensure it's running.
```
systemctl start httpd &&  systemctl status httpd
```

Press **q** to exit from status check mode on terminal

Create a new **index.html** file in the following directory for the static website, effectively setting it up as a sample application.

```
 cd /var/www/html/
```
Run the following command to create a index.html file with required content.
```
cat << 'EOF' > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Red Hat Developers</title>
</head>
<body>
    <header>
        <h1>Welcome to Red Hat Developers portal</h1>
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
Visit the `Sample App` tab beside of terminal tab to check the running app trhought httpd server.
> [!NOTE]
> If the Red Hat Developers website is not visible, Kidly refresh the page ↻

Check the labels of the file using the following command.
```
ls -lZ
```
After successful deloyment of web page, click on the **check** button.