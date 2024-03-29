---
slug: step2
id: nxrvixuqxwf1
type: challenge
title: Leveraging existing k8s Resource Files inside of Ansible
tabs:
- title: Terminal 1
  type: terminal
  hostname: container
- title: Visual Editor
  type: code
  hostname: container
  path: /root/tutorial
difficulty: basic
timelimit: 300
---
Next, we'll use the Ansible k8s module to leverage existing Kubernetes and OpenShift Resource files. Let's take the **[nginx deployment example](https://kubernetes.io/docs/concepts/workloads/controllers/deployment/#creating-a-deployment)**
 from the Kubernetes docs.

 **Note**: *We've modified the resource file slightly as we will be deploying
  on OpenShift.*

Let's begin by using the context of the previously created project:

```
oc project test
```

---

 ###### **a. Copy the nginx deployment definition `nginx-deployment.yml` into `example-role/templates`, adding a .j2 extension**

```
cp /root/tutorial/nginx-deployment.yml /root/tutorial/example-role/templates/nginx-deployment.yml.j2
```

```
cat /root/tutorial/example-role/templates/nginx-deployment.yml.j2
```


```yaml
kind: Deployment
apiVersion: apps/v1
metadata:
  name: nginx-deployment
spec:
  template:
    metadata:
      labels:
        name: nginx
    spec:
      containers:
        - name: nginx
          image: nginx:1.15.4
          ports:
          - containerPort: 80
  replicas: 3
  selector:
    name: nginx
```


 ###### **b. From *Visual Editor* Tab, update tasks file `example-role/tasks/main.yml` to create the nginx deployment using the k8s module**

```yaml
---
- name: set test namespace to {{ state }}
  k8s:
   api_version: v1
   kind: Namespace
   name: test
   state: "{{ state }}"

- name: set nginx deployment to {{ state }}
  k8s:
   state: "{{ state }}"
   definition: "{{ lookup('template', 'nginx-deployment.yml.j2') }}"
   namespace: test
```

You can easily update this file by running the following command:

```
curl -s https://raw.githubusercontent.com/openshift-labs/learn-katacoda/master/ansibleop/ansible-k8s-modules/assets/tasksmain2.yml -o /root/tutorial/example-role/tasks/main.yml
```

---

###### **c. Run the Playbook to deploy nginx onto OpenShift**

Running the Playbook with the command below will read the `state` variable defined in `example-role/defaults/main.yml`

```
cd /root/tutorial/ && \
    ansible-playbook -i myhosts playbook.yml
```

---

###### **d. Examine Playbook results**
You can see the `test` namespace created and the `nginx` deployment created in the new namespace.

```
oc get all -n test
```