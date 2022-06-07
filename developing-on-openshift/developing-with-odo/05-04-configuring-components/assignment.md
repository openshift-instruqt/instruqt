---
slug: 04-configuring-components
id: j2hykcwypvff
type: challenge
title: Topic 4 - Configuring and application's components
notes:
- type: text
  contents: Topic 4 - Configuring and application's components
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Web Console
  type: website
  url: https://console-openshift-console.crc-dzk9v-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 300
---
In this topic you will learn how to configure the `frontend` and `backend` components you installed previously.

----

`Step 1:` Run the following command to navigate to the `frontend` directory:

```
cd /root/frontend
```

----

`Step 2:` Run the following `odo` command to configure the `frontend` component to connect to the `backend`.

```
odo config set --env COMPONENT_BACKEND_PORT=8080,COMPONENT_BACKEND_HOST=backend-app
```

You'll see the following output:

```
 ✓  Environment variables were successfully updated

Run `odo push` command to apply changes to the cluste
```

Executing the `odo config set` command above uses environment variables to inject configuration information about the `backend` into the `frontend`.

----

`Step 3:` Run the following `odo push` command to distribute the configuration changes and restart the `frontend` component.

```
odo push
```

Eventually you'll see output as shown in the following snippet:

```
.
.
Syncing to component frontend
 ✓  Checking file changes for pushing [8ms]
 ✓  Syncing files to the component [559ms]

Executing devfile commands for component frontend
 ✓  Executing install command "npm install" [5s]
 ✓  Executing run command "npm start" [1s]

Pushing devfile component "frontend"
 ✓  Changes successfully pushed to component
```

----

`Step 4:` Click the **Web Console** tab and go to the Topology page in the OpenShift web console.

If the circle surrounding the  `frontend` component is light blue, this means that the component is restarting. If the circle is dark blue, the `frontend` component has started.

----

`Step 5:` Select **View Logs** in the web console as you did previously. Notice that instead of an error message, you will see log output similar to the following that confirms the `frontend` is properly communicating with the `backend` component:

```
Listening on 0.0.0.0, port 8080
Frontend available at URL_PREFIX: /
Proxying "/ws/*" to 'backend-app:8080'
```

# Congratulations!

  You connected to the `frontend` component to the `backend` component

----

**NEXT:** Creating an OpenShift route to expose components to the public
