---
slug: "04"
id: 0dhlu2zujjug
type: challenge
title: Ingest dataset to Elasticsearch
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
- Let's load the text formatted dataset of 100 classic novels from the Gutenberg's collection into our Elasticsearch service.

> Note : Hang Tight ! The data ingestion could take a few minutes.

```
oc exec -it e-library-backend-api -n e-library -- curl -X POST http://localhost:3000/load_data
```

> Here the ingested data is getting stored on Elasticsearch shards which are in-turn using ODF PVC for persistence.

- As soon as the data is ingested, Elasticsearch will index that and make it search-able.
- Grab the frontend URL and open that in your web-browser to search for any random words.
- _URL_ http://frontend-e-library.[[HOST_SUBDOMAIN]]-80-[[KATACODA_HOST]].environments.katacoda.com

```
oc get route frontend -n e-library
```

- Elasticsearch real-time search capabilities, instantly searches a large dataset. Thus making it a popular choice for logging,metrics,full-text search, etc. use cases.

## Final Thoughts

Elasticsearch offers replication at per index level to provide some data resilience. Additional data resilience can be provided by deploying Elasticsearch on top of a reliable storage service layer such as OpenShift Container Storage which offers further resilience capabilities. This additional data resilience can enhance Elasticsearch service availability during broader infrastructure failure scenarios. Because of limited system resources available in this lab environment, we could not demonstrate the enhanced resiliency capabilities of Elasticsearch when deployed on OpenShift Container Storage, but you have got the idea :)

Happy Persistency \o

# What's Next?

Congratulations on completing this lab. Keep learning about OpenShift:

* Visit the [Red Hat Developer learning page](https://developers.redhat.com/learn) for more labs and resources
* [Want to try a free, instant 30-day OpenShift cluster? Get started with the Developer Sandbox for Red Hat OpenShift](https://developers.redhat.com/developer-sandbox)

Don't forget to finish the lab and rate your experience on the next page. Thanks for playing!
