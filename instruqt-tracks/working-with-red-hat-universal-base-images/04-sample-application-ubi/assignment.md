---
slug: sample-application-ubi
id: bpa2cltj4wli
type: challenge
title: A sample application using UBI
teaser: Create a sample PHP application using UBI
notes:
- type: text
  contents: |
    ****A sample application using UBI****

    In this track we will be covering how to build and containerize a sample PHP application using a Universal Base Image.
tabs:
- title: php
  type: terminal
  hostname: user
- title: webpage
  type: service
  hostname: user
  path: /
  port: 8080
difficulty: basic
timelimit: 300
---
To start create work folder and inside a PHP website file with "Hello World" in it:


```bash
mkdir php-webpage && cd php-webpage

cat > index.php << EOF
<html>
<body>
<?php print "Hello, world!\n" ?>
</body>
</html>
EOF
```


In the same work folder, create a Containerfile. The Containerfile installs Apache HTTPd and PHP from the Software Collections Library, using the UBI package repositories:

```bash
cat > Containerfile << EOF
FROM registry.access.redhat.com/ubi9/ubi

RUN yum --disableplugin=subscription-manager -y module enable \
  php:8.1\
  && yum --disableplugin=subscription-manager -y install \
  httpd php \
  && yum --disableplugin=subscription-manager clean all

ADD index.php /var/www/html

RUN sed -i 's/Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf \
  && mkdir /run/php-fpm \
  && chgrp -R 0 /var/log/httpd /var/run/httpd /run/php-fpm \
  && chmod -R g=u /var/log/httpd /var/run/httpd /run/php-fpm

EXPOSE 8080

USER 1001

CMD php-fpm & httpd -D FOREGROUND
EOF
```

The --disableplugin=subscription-manager option avoids warning messages when building from a machine that has no active subscription.

Note that we took care of creating a Red Hat OpenShift-friendly container image. That image works without root privileges and under a random userid. This is something everyone should do, regardless of their target container runtime. Unlike the container engine from your desktop OS, and some Kubernetes distributions, Red Hat OpenShift by default refuses to run containers that require elevated privileges.


Enter your work folder and use Podman to build the container image:

```bash
sudo podman build -t php-ubi .
```

This is cool, isn't it? Building a RHEL-based container image from a non-RHEL system, without a RHEL subscription, and without having to fuss with Yum repositories!

Now start a container from your new container image:

```bash
sudo podman run --name hello -p 8080:8080 -d localhost/php-ubi
```

To check if your container is running run the following command:
```bash
podman ps
```

And test your container using curl:

```bash
curl localhost:8080
```


You can also navigate to the **webpage** tab to see the application working properly.