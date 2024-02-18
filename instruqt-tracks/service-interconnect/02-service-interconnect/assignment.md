---
slug: service-interconnect
id: qzaqgmxpwd7d
type: challenge
title: Connecting the services spread across OpenShift and RHEL VM
notes:
- type: text
  contents: |2

    In this lab you will discover how to build a service network to connect disparate services across different environments using [Red Hat Service Interconnect](https://developers.redhat.com/products/service-interconnect/overview).

    ## What is Red Hat Service Interconnect?
    [Red Hat Service Interconnect](https://developers.redhat.com/products/service-interconnect/overview) enables application and service connectivity across different environments through layer 7 addressing and routing. Using a simple command line interface, interconnections are created in a matter of minutes, avoiding extensive networking planning, and overhead. All interconnections between environments use mutual TLS(**mTLS**) to keep your organization’s infrastructure and data protected. Red Hat Service Interconnect is based on the open source [Skupper](https://skupper.io/index.html) project.

    ## Lab Scenario
    In this lab we will go through the example of a patient portal application
    **It contains three services:**

    - A web frontend service running on Kubernetes in the public cloud. It uses the PostgreSQL database and the payment-processing service.
    - A PostgreSQL database running on Kubernetes in a private data center.
    - A payment-processing service running on Kubernetes in a private data center.

     The challenge for us is now to enable the patient portal frontend to connect to the database and payment processor. For obvious reasons, we **do not want to expose the database and payment processor** over the public internet, so a private, secure link needs to be setup between the OpenShift instance on the public cloud and the data centre.

    This can be accomplished with a VPN between the public cloud and the private data center. However, a **VPN can be hard to set up**, and **requires deep networking expertise**. Developers also need to request the network admins and go through a time taking approval process for the VPNs to be setup. **Red Hat Service Interconnect on the other hand creates a dedicated layer 7 service network and is a lot easier to set up**. It allows application Developers to establish secure interconnection with other services and applications in different environments without relying on network specialists. With Service Interconnect developers can now create secure virtual application networks without the cumbersome overhead, complexity and delays of traditional connectivity solutions.

    ## Lab architecture
    ![Architecute-router.png](..\assets\Architecute-router.png)
    > **Note:**
    > Red Hat Service Interconnect is not limited to service networks between instances of OpenShift, but can equally well be leveraged to connect deployments running on premise (deployed on OpenShift or Kubernetes, on virtual machines or on bare metal) with services running in the cloud.


    In the next screen, you will be guided through setting up a service network between all these services across different environments to make the patient portal functional.

    Let's get started!
tabs:
- title: Terminal-OpenShift
  type: terminal
  hostname: crc
- title: Terminal-RHEL
  type: terminal
  hostname: rhel
- title: Patient Portal
  type: website
  url: https://patient-portal-frontend-public.crc-97g8f-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 1800
---


#  Pre Installed
Below is a list of things that we have already configured. Make sure you have everything in your environment before you proceed
- **Red Hat Service Interconnect CLI** - Service Interconnect comes with an easy to use command line interface  that allow users to easily
and safely configure and manage their interconnections. Using a simple command line, interconnections
are easily created avoiding extensive networking planning without compromising your organization's infrastructure and data.
- **AnOpenShift Cluster** - This will run the front end of the patient portal application
- **A RHEL machine** - This will run our database and payment processor used to process the bill payments of the patients
- **Terminal-OpenShift** - This tab is a terminal that is already remotely logged in to OpenShift cluster![OpenShift-Terminal.png](..\assets\Screenshot%202023-08-22%20at%205.47.14%20PM.png)
- **Terminal-RHEL** - This tab is a terminal that is already logged into to a RHEL VM ![RHEL-terminal.png](..\assets\Screenshot%202023-08-22%20at%205.54.47%20PM.png)
-  **Patient Portal** - Tab to accesss the patient portal frontend website ![pp-tab.png](..\assets\pp-tab.png)
-

# Install the Frontend in the Public OpenShift Cluster
We are already remotely logged into the Public OpenShift cluster from the **Terminal-OpenShift** tab.

- Make sure your are on the**Terminal-OpenShift** tab: ![OpenShift-Terminal.png](..\assets\Screenshot%202023-08-22%20at%205.47.14%20PM.png)
-  Login to the **public** project by copy pasting the command below in to the **Terminal-OpenShift** CLI.
	```
	oc project public
	```

- Install the frontend app by copy pasting the commands below in to the **Terminal-OpenShift** CLI.
	```
	oc apply -f https://raw.githubusercontent.com/rpscodes/Patient-Portal-Deployment/main/patient-portal-frontend-deploy.yaml
	```
> **Note**
> *You might see some warnings about Pod Security violations in the console output. These can safely be ignored.*
- Wait for a minute and check if the frontend pods are running on the Public OpenShift Cluster
	```
	oc get pods
	```
- You should see an output similar to the one below:
	```,nocopy
	NAME                                      READY   STATUS    RESTARTS   AGE
	patient-portal-frontend-78f45d5fd-xtlhh   1/1     Running   0          10s
	```

- Now that the front end is up and running. Navigate to the patient portal frontend by clicking on the patient portal tab
![pp-tab.png](..\assets\pp-tab.png)

- **Note:** You might see a **Your connection is not private** message on the browser as we are using a self-signed certificate.  You can ignore such errors during this excercise.  Click on **Advanced** and then click on the **"proceed to"** link as shown in the image below if you see this warning
![front-end-security1.png](..\assets\front-end-security1.png)
![front-end-security2.png](..\assets\front-end-security2.png)

- You should be able to see the front end of the patient portal without any patient names or doctor names as we have not established the connection with the database
![frontend-empty.png](..\assets\frontend-empty.png)

# Install the Database and Payment Process on the RHEL VM
The Database contains a list of patients and doctors, that will show on the patient portal front end page once we make the connections.

The payment processor is a service that process the bill payments made by patients.

We are already remotely logged into the RHEL machine from the **Terminal-RHEL** machine.

- Switch to the **Terminal-RHEL**  tab before you do this section  ![RHEL-terminal.png](..\assets\Screenshot%202023-08-22%20at%205.54.47%20PM.png)

- Switch from **root** to **user1** that we already created
	```
	su - user1
	```

- Execute the following commands from the **Terminal-RHEL** tab to deploy database and payment processor
	```
	podman run --name portal-database --detach --rm -p 5432:5432 quay.io/redhatintegration/patient-portal-database:devnation
	podman run --name portal-payments --hostname processed-at-datacentre --detach --rm -p 8080:8080 quay.io/redhatintegration/patient-portal-payment-processor:devnation
	```

- Wait for a minute and then check if the database and payment processor pods are running on the RHEL machine
	```
	podman ps
	```
- You should see an output similar to the one below:
	```,nocopy
	CONTAINER ID  IMAGE                                                                 COMMAND         CREATED         STATUS         PORTS                   NAMES
	93959f202b94  quay.io/redhatintegration/patient-portal-database:devnation           run-postgresql  15 minutes ago  Up 15 minutes  0.0.0.0:5432->5432/tcp  portal-database
	53d34837779e  quay.io/redhatintegration/patient-portal-payment-processor:devnation                  14 minutes ago  Up 14 minutes  0.0.0.0:8080->8080/tcp  portal-payments
	```


This brings us to the end of installation section.

In the next section we will use **[Red Hat Service Interconnect](https://developers.redhat.com/products/service-interconnect/overview)** to connect all these service to make the patient portal work.


# The Challenge
As indicated in the image below you are now done installing the patient portal frontend in the OpenShift Cluster and the database and payment processor in the RHEL machine. Both these environments(OpenShift and RHEL) are not connected.
![Arch-no-skup.png](..\assets\Screenshot%202023-08-22%20at%2010.52.56%20PM.png)

The challenge for us is now to enable the patient portal application to connect to the database and payment processor. For obvious reasons, we do not want to expose the database and payment processor over the public internet, so a private, secure link needs to be setup between the OpenShift instance and the RHEL Machine in the datacentre. This can be accomplished with a VPN between the public cloud and the data center. However a **VPN can be hard to set up**, and **requires deep networking expertise**. Developers also need to request the network admins and go through a time taking approval process for the VPNs to be setup. **Red Hat Service Interconnect on the other hand creates a dedicated layer 7 service network and is a lot easier to set up**. It allows application Developers to establish secure interconnection with other services and applications in different environments without relying on network specialists. With Service Interconnect developers can now create secure virtual application networks without the cumbersome overhead, complexity and delays of traditional connectivity solutions.




# Connect the the Frontend in the OpenShift Cluster to the Database and Payment Processor deployed in the RHEL Datacentre
## **Intialize Red Hat Service Interconnect in the Public OpenShift Cluster**

This process will install Service Interconnect in the **public** namespace in the OpenShift cluster.
We are already remotely logged into the OpenShift cluster from the **Terminal-OpenShift** machine.

- Make sure you are on the **Terminal-OpenShift** tab  ![OpenShift-Terminal.png](..\assets\Screenshot%202023-08-22%20at%205.47.14%20PM.png)

- To initialize Service Interconnect in the OpenShift namespace namespace you will need to issue the following command in the **Terminal-OpenShift**  window:
	```
	skupper init --enable-console --enable-flow-collector --console-auth unsecured
	```
> **Note**
> *You might see some warnings about Pod Security violations in the console output. These can safely be ignored.*
- Output
	```,nocopy
	Skupper is now installed in namespace 'public'.  Use 'skupper status' to get more information.
	```


- Now switch to the **Terminal-RHEL** tab ![RHEL-terminal.png](..\assets\Screenshot%202023-08-22%20at%205.54.47%20PM.png)

- In order to create the connection Service Interconnect must also be intialized in the RHEL machine where deployed the database and payment processor. Issue the following commands in the **Terminal-RHEL** tab:
	```
	export SKUPPER_PLATFORM=podman
	skupper init --ingress none
	```

- Output
	```,nocopy
	Skupper is now installed for user 'user1'.  Use 'skupper status' to get more information.
	```



## **Linking the OpenShift cluster and RHEL VM using Red Hat Service Interconnect**
Creating a link between Service Interconnect enabled namespace and the services on the RHEL machine requires a secret token that allows permission to create the link. The token carries the link details required for  connection. We will generate the token in the OpenShift cluster and use it in the RHEL machine to create a link. All inter-site traffic is protected by mutual TLS**(mTLS)** using a private, dedicated certificate authority (CA). A claim token is not a certificate, but is securely exchanged for a certificate during the linking process. By implementing appropriate restrictions (for example, creating a single-use claim token), you can avoid the accidental exposure of certificates.


- Switch to **Terminal-OpenShift** tab  ![OpenShift-Terminal.png](..\assets\Screenshot%202023-08-22%20at%205.47.14%20PM.png)

- Generate the token in the **Terminal-OpenShift** tab
	```
	skupper token create ~/secret.token
	```
- View the token
	```
	cat secret.token
	```
- Output
	```,nocopy
	apiVersion: v1
	data:
		ca.crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURMVENDQWhXZ0F3SUJBZ0lSQUtDa1V6bW1Bc24vbHFrVHpwT3ZQUjR3RFFZSktvWklodmNOQVFFTEJRQXcKR2pFWU1CWUdBMVVFQXhNUGMydDFjSEJsY2kxemFYUmxMV05oTUI0WERUSXpNRFV4TXpBME5UVXdOMW9YRFRJNApNRFV4TVRBME5UVXdOMW93R2pFWU1CWUdBMVVFQXhNUGMydDFjSEJsY2kxemFYUmxMV05oTUlJQklqQU5CZ2txCmhraUc5dzBCQVFFRkFBT0NBUThBTUlJQkNnS0NBUUVBekJPZkFDVDdJVVdNSjQ4eEo3SHdPdkllYnNiSG8vU2YKQkdxeUdUSnUwbzlqSnBYS3ZydGkxcWVpZmpTV1hnczVLbHlMWDdjNkc1b1lPVWpsb1pqUzhQYXJ2WDcyUEhUTQoyQU93ZiszOWxWaTlsK1l4UHpxZEtZcXNLSWRFeE5FK2pEYzgvdGtnT1AwY2plOHpzMHdYK2RITi9nOFU1K0xMCmQwSE1TTWF0VHdwdTFtdGhtbk5tc2xTUWcrWVpONUh5Q0k2R3hUV3pGVDhlaHMzRGlLYzZrdTF2bHlDQ0VIa1EKazg4ZW5BWkZMbEpzYjZKTXIyaDBJSG5nZ0h5TFY4OEQ5bzlpblMwckFpODc0UWVYNFhkWnplY2dGYWVBVTJDdgpHQ1QzYWVXQXRyZ3FvaFc2ZmU2Ykx1WEhmMkxza2hXbk5uTU5mN3Y2UUxpSk16S0t0d2p1dndJREFRQUJvMjR3CmJEQU9CZ05WSFE4QkFmOEVCQU1DQXFRd0hRWURWUjBsQkJZd0ZBWUlLd1lCQlFVSEF3RUdDQ3NHQVFVRkJ3TUMKTUE4R0ExVWRFd0VCL3dRRk1BTUJBZjh3SFFZRFZSME9CQllFRk5rcitRVHMyZGNGZXlrZjFKOGpaV0hNN2RFaApNQXNHQTFVZEVRUUVNQUtDQURBTkJna3Foa2lHOXcwQkFRc0ZBQU9DQVFFQW5zWGl3eE9XaWx3UnlWMENXaE5QCk9wd0IxNDNHTHJRaEc2OHkvbGNTZThyMDc2dHQ0Nm42SlZlS1A3RklvemZwd01hTW0zSjFrd0ltQjhpVVVBZjgKbnhHZnRjOEVXaG45YlN6MVdUU0s1eitCUEp6NWpTRDhEb2pGNXpkUjNPejhBNDdCbVNwcS9SVkZIaE9nS2lpRApZdTRLbDd2Mm5hQ3JTNHFWZzRxNVlBWFAyaWc1R05NM1F6dWtIWHlON3ZucXlXZVlwVnAzU2NOdzhpd2RUUmVrCnN2cDhPcE0va0ZyMTlFSVBteWpPVzl2cHpPcWs5R0tkQjZZcUhWdkUraEdoSlQranFzcWxoMVhyNXpGVE5WWFAKY0F5YWY0TFRlTndWUVRZOXpSR3lBbXZYTzN4cThPcTJQNnFTNFhhSS94UFpGUUNFTGE3K2tZS25tSWdRcnF5awpLQT09Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
		password: M3MzWTExYzVldWlvZzkxeE5MYThWNVFr
	kind: Secret
	metadata:
		annotations:
			skupper.io/generated-by: 76c142fb-7fa0-4218-8427-021c0ce29fb0
			skupper.io/site-version: 1.3.0
			skupper.io/url: https://claims-public.crc-rwwzd-master-0.crc.gcpjpffoqwu0.instruqt.io:443/ba863cd9-f14a-11ed-ad52-42010a050005
		creationTimestamp: null
		labels:
			skupper.io/type: token-claim
		name: ba863cd9-f14a-11ed-ad52-42010a050005
	```
> **Warning**
> Do not copy the token from here. Copy the token from the terminal as indicated in the subsequent steps

- Select the full token from the **Terminal-OpenShift** and carefully copy the token without missing any characters out. You can paste the token in any text editor or revisit this tab to copy this token for later steps. This is a very important step and any missing characters in the token will lead to failed connections
![copy-token.png](..\assets\copy-token.png)

- Now switch to **Terminal-RHEL**  ![RHEL-terminal.png](..\assets\Screenshot%202023-08-22%20at%205.54.47%20PM.png)

- Create on a new file for the secret on the **Terminal-RHEL** by issuing the below command
	```
	vim secret.token
	```

- Paste the token that you copied in this file and press the **esc** followed by **:** followed by **wq** to save the file. Double check to make sure you pasted the complete token. The token should like the one in the image below
![Screenshot -token.png](..\assets\Screenshot%202023-08-22%20at%205.32.32%20PM.png)


- Now that we have successfully saved the token in the private machine. Let's create the connection. Link the private cluster to the public cluster by executing the below command from the **Terminal-RHEL**. This will utilize the token that we just transferred to create the link between the two disparate environments.
	```
	skupper link create secret.token
	```

- Output
	```,nocopy
	Site configured to link to skupper-inter-router-public.crc-rwwzd-master-0.crc.g10vlia9p0s9.instruqt.io:443 (name=link1)
	Check the status of the link using 'skupper link status'.
	```
- Check the status of the link after a few seconds:
	```
	skupper link status
	```
- Output
	```,nocopy
	Links created from this site:

         Link link1 is connected
	```

	Though we have linked the namespace on the OpenShift cluster and the RHEL machine, we have not exposed any services yet. We have to explicitly mention which services we want to expose over the Service network. By default **none** of the services in the namespaces are exposed by Red Hat Service Interconnect.

- You can verify this by going to the browser tab where you have opened the frontend and refreshing it. You will still see that the patient and doctors names are still not retrieved from the database and displayed on the portal
![frontend-empty.png](..\assets\frontend-empty.png)


## **Exposing the services over the network using Red Hat Service Interconnect**
Now let's expose the database service and payment processor over the service network. This will allow the Frontend on the OpenShift cluster to connect to the database as if it was a local service, while in reality the service is a proxy for the real service running on the RHEL machine.

- Switch back to the **Terminal-RHEL** to create the connection
 ![RHEL-terminal.png](..\assets\Screenshot%202023-08-22%20at%205.54.47%20PM.png)

- Expose the database and the payment processor over the network by running the below commands on the **Terminal-RHEL**
	```
	skupper expose host host.containers.internal --address database --port 5432
	skupper expose host host.containers.internal --address payment-processor --port 8080 --protocol http
	```

- Switch back to the **Terminal-OpenShift**
![OpenShift-Terminal.png](..\assets\Screenshot%202023-08-22%20at%205.47.14%20PM.png)

- Create proxy services on the **OpenShift cluster** that will redirect to the services running on the RHEL machine in the datacentre by running the below commands on **Terminal-OpenShift**
	```
	skupper service create database 5432
	skupper service create payment-processor 8080 --protocol http
	```

- You have now established a secure link between the two environments, and exposed the database and payment processor as services on OpensShift cluster. This will allow the Frontend on the Public cluster to connect to the database and payment processor services as if they were a local service, while in reality these services are proxies for the real service running on the RHEL Machine running in the datacentre. ![Arch-router.png](..\assets\Screenshot%202023-08-22%20at%2011.02.35%20PM.png)

> **Note:**
> We are not exposing the database and payment processor service to the internet. Only the services which are part of the service network enabled by Red Hat Service Interconnect can access them

- You can verify this checking the list of svcs in the OpenShift cluster

- Switch to the  **Terminal-OpenShift** tab ![OpenShift-Terminal.png](..\assets\Screenshot%202023-08-22%20at%205.47.14%20PM.png)

- Get a list of services deployed in the public namespace
	 ```
	oc get service
	```
- Output
	```,nocopy
	NAME                      TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)                      AGE
	database                  ClusterIP   10.217.5.186   <none>        5432/TCP                     40s
	patient-portal-frontend   ClusterIP   10.217.5.67    <none>        8080/TCP                     6m19s
	payment-processor         ClusterIP   10.217.5.135   <none>        8080/TCP                     4s
	skupper                   ClusterIP   10.217.4.36    <none>        8010/TCP,8080/TCP,8081/TCP   5m19s
	skupper-router            ClusterIP   10.217.5.192   <none>        55671/TCP,45671/TCP          5m20s
	skupper-router-local      ClusterIP   10.217.4.103   <none>        5671/TCP                     5m20s
	```

	The database service and payment-processor are the proxy services created by exposing the database deployment in the RHEL Datacenter over the service network.


- After a few seconds go back to the browser tab where you have opened the patient portal front end and refresh it. or Click the **Patient-Portal** tab![pp-tab.png](..\assets\pp-tab.png)
- You should now be able to see the the list of patients and doctors that have been retrieved from the database. This shows that we have successfully connected our front end to the database using Red Hat Service Interconnect.
![database-connected.png](..\assets\database-connected.png)

- Click on the Patient **Angela Martin**.
![angela.png](..\assets\angela.png)

- Click the Bills tab to find the unpaid bills and hit the pay button.
![bills-tab.png](..\assets\bills-tab.png)

- Submit the payment
![submit-payment.png](..\assets\submit-payment.png)

- You should be able to see there is now a **Date Paid** and **Processor** value indicating that the payment is successful and was processed at the datacenter. This shows that we have successfully connected our payment-processor to the application using Red Hat Service Interconnect.
![payment-success.png](..\assets\Screenshot%202023-08-22%20at%2011.24.59%20PM.png)


Congratulations! You successfully used Red Hat Service Interconnect to build a secure service network between services running in two different environments (OpenShift and RHEL) and allowed application to connect and communicate over the secure network.
![Layer-7.png](..\assets\Screenshot%202023-08-22%20at%2011.05.14%20PM.png)

Learn more at about [Red Hat Service Interconnect by clicking here](https://developers.redhat.com/products/service-interconnect/overview).










