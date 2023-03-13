---
slug: step2
id: yfv4cyxcuxod
type: challenge
title: Basic Operations with the Kubernetes API
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Terminal 2
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root
difficulty: basic
timelimit: 500
---
Verify the currently available Kubernetes API versions:

```
oc api-versions
```

Use the `--v` flag to set a verbosity level. This will allow you to see the request/responses against the Kubernetes API:

```
oc get pods --v=8
```

Use the `oc proxy` command to proxy local requests on port 8001 to the Kubernetes API:

```
oc proxy --port=8001
```

From *Terminal 2*, send a `GET` request to the Kubernetes API using `curl`:

```
curl -X GET http://localhost:8001
```

We can explore the OpenAPI definition file to see complete API details.

```
curl localhost:8001/openapi/v2
```

Send a `GET` request to list all pods in the environment:

```
curl -X GET http://localhost:8001/api/v1/pods
```

Use `jq` to parse the json response:

```
curl -X GET http://localhost:8001/api/v1/pods | jq .items[].metadata.name
```

We can scope the response by only viewing all pods in a particular namespace:

```
curl -X GET http://localhost:8001/api/v1/namespaces/myproject/pods
```

Get more details on a particular pod within the `myproject` namespace:

```
curl -X GET http://localhost:8001/api/v1/namespaces/myproject/pods/my-two-container-pod
```

Export the manifest associated with `my-two-container-pod` in json format:

```
cd /root && \
  oc get pods my-two-container-pod -o json > podmanifest.json
```

Within the manifest, replace the `1.13` version of alpine with `1.14`:

```
sed -i 's|nginx:1.13-alpine|nginx:1.14-alpine|g' podmanifest.json
```

Update/Replace the current pod manifest with the newly updated manifest:

```
curl -X PUT http://localhost:8001/api/v1/namespaces/myproject/pods/my-two-container-pod -H "Content-type: application/json" -d @podmanifest.json
```

Patch the current pod with a newer container image (`1.15`):

```
curl -X PATCH http://localhost:8001/api/v1/namespaces/myproject/pods/my-two-container-pod -H "Content-type: application/strategic-merge-patch+json" -d '{"spec":{"containers":[{"name": "server","image":"nginx:1.15-alpine"}]}}'
```

Delete the current pod by sending the `DELETE` request method:

```
curl -X DELETE http://localhost:8001/api/v1/namespaces/myproject/pods/my-two-container-pod
```

Verify the pod is in `Terminating` status:

```
oc get pods
```

Verify the pod no longer exists:

```
curl -X GET http://localhost:8001/api/v1/namespaces/myproject/pods/my-two-container-pod
```
