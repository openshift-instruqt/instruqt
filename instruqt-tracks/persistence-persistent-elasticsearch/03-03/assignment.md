---
slug: "03"
id: 7hm929sfciw1
type: challenge
title: Deploy app backend & frontend
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Web Console
  type: service
  hostname: crc
  path: /
  port: 30001
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 225
---
- Apply the YAML file to deploy application's backend API

```
oc create -f 3_deploy_backend_api.yaml
```

- In order for the frontend app to reach the backend API, set ``BACKEND_URL`` environment variable as a config map, by executing the following commands

```
echo "env = {BACKEND_URL: 'http://$(oc get route -n e-library -o=jsonpath="{.items[0]['spec.host']}")'}" > env.js
```

```
oc create configmap -n e-library env.js --from-file=env.js
```

- Finally deploy the frontend application

```
oc create -f 4_deploy_frontend_app.yaml
```

At this point our frontend and backend applications are deployed and are configured to use Elasticsearch

- To verify execute the following commands.

```
oc get po,svc,route
```

- Before you move to next step, please make sure all the pods are in ``Running`` state. If they are not, then please allow a few minutes.

```
oc get po,svc,route
```