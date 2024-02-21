---
slug: add-health-checks
id: mm7tleaaxg0z
type: challenge
title: Topic 2 - Add Health Checks to your Application
teaser: Add Health Checks to your Application
notes:
- type: text
  contents: Add Health Checks to your Application
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/nodejs/nodeserver
- title: Terminal 2
  type: terminal
  hostname: crc
difficulty: basic
timelimit: 600
---
Kubernetes, and a number of other cloud deployment technologies, provide "Health Checking" as a system that allows the cloud deployment technology to monitor the deployed application and to take action should the application fail or report itself as "unhealthy".

The simplest form of Health Check is process-level health checking, where Kubernetes checks to see if the application process still exists and restarts the container (and therefore the application process) if it is not. This provides a basic restart capability but does not handle scenarios where the application exists but is unresponsive, or where it would be desirable to restart the application for other reasons.

The next level of Health Check is HTTP-based, where the application exposes a "livenessProbe" URL endpoint that Kubernetes can make requests to determine whether the application is running and responsive. Additionally, the request can be used to drive self-checking capabilities in the application.

Add a Health Check endpoint to your Express.js application using the following steps:

----

`Step 1:` Click the **Visual Editor** tab in the horizontal menu bar over the terminal window to the left. You'll see the code editor that is part of the interactive learning environment.

Register a Liveness endpoint in `server.js` by adding the line below after the `const app = express();` line:

   ```js
   app.get('/live', (req, res) => res.status(200).json({ status: 'ok' }));
   ```

This adds a `/live` endpoint to your application. As no liveness checks are registered, it will return a status code of 200 OK and a JSON payload of `{"status":"ok"}`.

----

`Step 2:` Run the following commands in the **Terminal 1** window to the left to go to the working directory for the Node.js application and then start it

```sh
cd /root/projects/nodejs/nodeserver
```

```sh
npm start
```

----

`Step 3:` Run the following command in the **Terminal 2** window that appears to check that your `livenessProbe` Health Check endpoint is running:

```
curl -w "\n" localhost:8080/live
```

You'll get the following output:

```
{"status":"ok"}
```

You can stop your server by entering CTRL + C in the **Terminal 1** window.

----

For information more information on health/liveness checks, refer to the following:
 - [NodeShift Reference Architecture for Node.js Applications - Health Checks](https://github.com/nodeshift/nodejs-reference-architecture/blob/master/docs/operations/healthchecks.md)
 - [Red Hat Developer Blog on Health Checking](https://developers.redhat.com/blog/2020/11/10/you-probably-need-liveness-and-readiness-probes)


**NEXT:** Deploying your applicaiton to Openshift
