---
slug: 00-application-overview
id: yopmyovcywsq
type: challenge
title: Topic 1 - Project and Application Overview
notes:
- type: text
  contents: |
    ## Goal

    The goal of this lesson is to learn how to use the *OpenShift Do* (`odo`) command line tool to build and deploy applications on OpenShift.

    ## Concepts and techniques you'll cover

    * How the `odo` developer tool abstracts deployment tasks
    * Viewing OpenShift Projects and Applications
    * Using the OpenShift Web Console’s Developer Perspective
    * Working with multi-tiered applications with a web frontend
    * Invoking automatic OpenShift builds for iterative development

    ## When to use `odo`

    `odo` is a developer-centric tool for building and running software on OpenShift. `odo` streamlines common build and deployment tasks to let you focus on your application’s source code. You can use `odo` to reduce the cognitive load and rote steps that are typically involved when working on complex applications built using a mixed stack of component solutions.
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
- title: Visual Editor
  type: code
  hostname: container
  path: /root
difficulty: basic
timelimit: 500
---
The application you will be deploying in this track is a wild west shooter-style game.

Applications are often divided into components based on a logical division of labor. For example, an application might consist of a data storage back-end component that performs the application's primary work and stores the results. The back-end component is paired with a front-end component that publishes the application's web pages. The front end accesses the back end to retrieve data that is displayed to a user.

The application deployed in this tutorial consists of two such components, the back-end component and the front-end component.

![App Architecture](../assets/app-arch.png)

# Understanding the Back-end

The back-end component is a Java Spring Boot application. It performs queries against the Kubernetes and OpenShift REST APIs to retrieve a list of the resource objects that were created when you deployed the application. Then, the application returns to the front-end details about these resource objects.

# Understanding the Front-end

The front-end is the user interface for a wild west style game. The front end is written in Node.js. It displays pop-up images that you can shoot. These pop-up images correspond to the resource objects returned by the back end.

# Congratulations!

You've just covered the basic concepts behind the structure of an OpenShift application.

----

**NEXT:** Creating the initial project