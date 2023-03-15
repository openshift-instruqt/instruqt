---
slug: step3
id: 8jt7kdllban0
type: challenge
title: Replica Sets
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
Get a list of all pods in the `myproject` Namespace:

```
oc get pods -n myproject
```

Create a ReplicaSet object manifest file:

```
cd /root && \
cat > replica-set.yaml <<EOF
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: myfirstreplicaset
  namespace: myproject
spec:
  selector:
    matchLabels:
     app: myfirstapp
  replicas: 3
  template:
    metadata:
      labels:
        app: myfirstapp
    spec:
      containers:
        - name: nodejs
          image: openshiftkatacoda/blog-django-py
EOF
```

Create the ReplicaSet:

```
oc apply -f replica-set.yaml
```
Once sgain use the `oc proxy` command to proxy local requests on port 8001 to the Kubernetes API:

```
oc proxy --port=8001
```

From *Terminal 2*, launch this command to select all pods that match `app=myfirstapp`:

```
oc get pods -l app=myfirstapp --show-labels -w
```

Delete the pods and watch new ones spawn:

```
oc delete pod -l app=myfirstapp
```

Imperatively scale the ReplicaSet to 6 replicas:

```
oc scale replicaset myfirstreplicaset --replicas=6
```

Imperatively scale down the ReplicaSet to 3 replicas:

```
oc scale replicaset myfirstreplicaset --replicas=3
```

The `oc scale` command interacts with the `/scale` endpoint:

```
curl -X GET http://localhost:8001/apis/apps/v1/namespaces/myproject/replicasets/myfirstreplicaset/scale
```

Use the `PUT` method against the `/scale` endpoint to change the number of replicas to 5:

```
curl  -X PUT localhost:8001/apis/apps/v1/namespaces/myproject/replicasets/myfirstreplicaset/scale -H "Content-type: application/json" -d '{"kind":"Scale","apiVersion":"autoscaling/v1","metadata":{"name":"myfirstreplicaset","namespace":"myproject"},"spec":{"replicas":5}}'
```

You can also get information regarding the pod by using the `GET` method against the `/status` endpoint

```
curl -X GET http://localhost:8001/apis/apps/v1/namespaces/myproject/replicasets/myfirstreplicaset/status
```

The status endpoint's primary purpose is to allow a controller (with proper RBAC permissions) to send a `PUT` method along with the desired status.
