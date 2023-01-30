---
slug: quarkus-containerization
id: nibc44rlcujp
type: challenge
title: Topic 4 - Containerise the Quarkus App using Podman
tabs:
- title: Terminal 1
  type: terminal
  hostname: rhel
- title: Terminal 2
  type: terminal
  hostname: rhel
- title: Terminal 3
  type: terminal
  hostname: rhel
- title: Visual Editor
  type: code
  hostname: rhel
  path: /root
difficulty: intermediate
timelimit: 300
---



### 4. Containerize the Quarkus App using Podman


With the help of podman, we will containerize the quarkus application so that it becomes more portable and ready to be deployed on Kubernetes (OpenShift).

Install podman by using following command

```
dnf install podman -y
```

For that, we need to first create an image of it. Before creating a container image, we need to run one maven command which creates all the dependency files we want while creating the image.

```
cd quarkus-crud-mssql/
```

```
./mvnw package
```




This Dockerfile is used to build a container that runs the Quarkus application in JVM mode. You can also build in native,native-micro, and legacy-jar as per your requirement.





Quarkus provide us with multiple Dockerfiles with their location of it:





```
├── mvnw
├── mvnw.cmd
├── pom.xml
├── README.md
├── src
│ ├── main
│ │ ├── docker
│ │ │ ├── Dockerfile.jvm
│ │ │ ├── Dockerfile.legacy-jar
│ │ │ ├── Dockerfile.native
│ │ │ └── Dockerfile.native-micro
```




To build a podman image, you have to run the following command.





### 4.1. building dockerfile

Now build the container image with help of podman



```
podman build -f src/main/docker/Dockerfile.jvm -t quarkus/quarks-crud-app .
```




### 4.2. Run Quarkus container


Now run the container with help of podman run command on port 8080. We are taking the help of the host network for that add --network=host [link](https://www.metricfire.com/blog/what-is-docker-network-host/#:~:text=Docker%20network%20host%2C%20also%20known,(e.g.%2C%20port%2080).).

```
podman run -it -p 8080:8080 --network=host quarkus/quarks-crud-app
```




![](https://lh4.googleusercontent.com/dv4mzf5aGB3bXpI8xVViltR_3YuaL0iCpGBXOpiTYeo7DAI4GpSViF3DJTCMX2GLMBpWdbQRL_ibTq3XZ7R0COuwQ5dn9BJAy3SY21YiY0jyS4aRGboo0UEPBVCDdoJgweHoOfaucRiUwkPSaKQtMRrm0NCbmq45u8mR06VDTk8LWQVfjVmkLRvEgYbD)





As we tested all the API above we have to test it again after containerization like GET. POST, PUT, and DELETE.



GET:
```
http :8080/person
```
POST:
```
http POST :8080/person firstName=Carlos lastName=Santana salutation=Mr
```
PUT:
```
 http PUT :8080/person/1 firstName=Jimi lastName=Hendrix
```
DELETE:
```
http DELETE :8080/person/1
```






### Summary




Using Quarkus dramatically reduces the lines of code you have to write. As you have seen, creating a simple REST CRUD service is just a piece of cake. If you then want to move your app to Kubernetes, it’s just a matter of adding another extension to the build process.



Thanks to the Dev Services, you’re even able to do fast prototyping without worrying to install 3rd party apps like databases.



Minimizing the amount of boilerplate code makes your app easier to maintain – and lets you focus on what you have to do implementing the business case.



This is why I fell in love with Quarkus.