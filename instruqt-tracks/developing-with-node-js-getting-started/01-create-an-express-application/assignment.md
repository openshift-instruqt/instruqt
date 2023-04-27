---
slug: create-an-express-application
id: 5kqsejqxs4qv
type: challenge
title: Create an Express Application
teaser: A short description of the challenge.
notes:
- type: text
  contents: |-
    ## Goal

    This track provides an introduction to cloud-native development with Node.js by walking you through how to extend an Express.js-based application to leverage cloud capabilities.

    Target Audience: This track is aimed at developers who are familiar with Node.js but want to gain a base understanding of some of the key concepts of cloud-native development with Node.js.

    ## Concepts

    In this self-paced track you will:

    * Create an Express.js application
    * Add logging and health checks
    * Deploy your application to Openshift
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
timelimit: 800
---
In this step, you will create a basic Express.js application that responds with “Hello, World!”

Express.js is a popular web server framework for Node.js.  To learn more about Express.js, you can check out their [official documentation here](https://expressjs.com/)

# Creating a basic project using Node.js

`Step 1:` Run the following command in the **Terminal 1** window to the left to go to the working directory for the Node.js application you're going to create. (The directory was created as part of the tracks setup process.)

```
cd /root/projects/nodejs/nodeserver && pwd
```

You'll get the following output.

```
/root/projects/nodejs/nodeserver
```

----


`Step 2:` Run the following command in the **Terminal 1** window to initialize your application with `npm init`

```
npm init -y
```

`npm init` is a built in command for the npm cli that allows a user to quickly scaffold a new Node.js application.  Using the `-y` flag will accept the sensible defaults.  To learn more about this command, see the [official npm documentation](https://docs.npmjs.com/cli/v8/commands/npm-init).

`Step 3:` Run the following command in the **Terminal 1** window to install the Express.js node module

```
npm install express
```


----

It is important to add effective logging to your Node.js applications to facilitate observability, that is to help you understand what is happening in your application. The [NodeShift Reference Architecture for Node.js](https://github.com/nodeshift/nodejs-reference-architecture/blob/main/docs/operations/logging.md) recommends using Pino, a JSON-based logger.

`Step 4:` Run the following command in the **Terminal 1** window to install the pino node module

   ```
   npm install pino
   ```

----

`Step 5:`  Click the **Visual Editor** tab in the horizontal menu bar over the terminal window to the left. You'll see the code editor that is part of the interactive learning environment.

Now, let’s start creating our server.

`Step 6:` Create a file named **server.js** in the root of your application by clicking the **New File** icon.

`Step 6a`: Add the code below to produce an Express.js server that responds on the "/" route with "Hello, World!".

   ```js
   const express = require('express');
   const pino = require('pino')();
   const PORT = process.env.PORT || 8080;

   const app = express();

   app.get('/', (req, res) => {
      res.send('Hello, World!');
   });

   app.listen(PORT, () => {
      pino.info(`Server listening on port ${PORT}`);
   });
   ```

----


`Step 7:` Run the following command in the **Terminal 1** window to start the application.

```
npm start
```

Once the application is started, you should see a similar output in your console:

```
> nodeserver@1.0.0 start
> node server.js

{"level":30,"time":1680621308027,"pid":268394,"hostname":"crc-rwwzd-master-0","msg":"Server listening on port 8080"}
```


`Step 8:` Run the following command in the **Terminal 2** window that appears:

```
curl -w "\n" localhost:8080/
```

You'll get the following output:

```
Hello, World!
```

You can stop your server by entering CTRL + C in the **Terminal 1** window.

----

**NEXT:** Adding Health Checks to the application
