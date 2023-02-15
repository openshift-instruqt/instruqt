---
slug: 06-exercise-table
id: 6gmaxiueh1wz
type: challenge
title: Topic 6 - Exercising the demonstration application's web page
notes:
- type: text
  contents: Topic 6 - Exercising the demonstration application's web page
tabs:
- title: Terminal 1
  type: terminal
  hostname: crc
- title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/quarkus/panache-reactive
- title: OpenShift Web Console
  type: website
  url: https://console-openshift-console.crc-lgph7-master-0.crc.${_SANDBOX_ID}.instruqt.io
  new_window: true
difficulty: basic
timelimit: 500
---
Now that we have the demonstration application running on OpenShift you'll exercise the web interface.

`Step 1 :` Click on the **OpenShift Web Console** tab in the horizontal menu bar above the console window to the left to access the web console.

----

`Step 2 :` Click the Topology tab on the horizontal menu bar to the left of the web console as shown in the figure below.

![Access Topology](../assets/open-app-in-topology.png)

----

`Step 3 :` Click on the `Open URL` icon on the `people` circular graphic in the Topology view as shown in the figure above. A browser window with the demonstration application's web page will appear as shown in the figure below.

![New Web Page](../assets/new-app-web-page.png)

Notice the total number of records reported at the bottom.

----

`Step 4 :` Type in a single letter, e.g. `G`, in the search box in the demonstration application's web page as shown in the figure below to experience how responsive the application is.

![Application Web Page](../assets/app-web-page.png)

----

`Step 5 :` Type additional letters to narrow the search.

Rather than having all 10k records loaded into the browser at once, DataTable makes a call back to the `/person/datatable` endpoint to fetch only those records that need to be shown. The number of records shown is based on the defined page size, the current page you're looking at, and any search filters in force. In this case a page size of `10` has been defined. Thus, each RESTful call will only return up to 10 records, no matter how many records are in the database.

----

`Step 6 :` Skip around a few pages, try some different searches, and notice that the data is only loaded when needed. The overall performance is very good even for low-bandwidth connections or huge data sets.

# Extra credit
There are [many other features of DataTables](https://datatables.net/manual/server-side) that could be supported on the server side with Quarkus and Panache. For example, when our endpoint is accessed, the set of columns to order on is also passed using the `order` and `columns` arrays, which we do not cover in this scenario. If you have time, try to add additional code to support these incoming parameters and order the resulting records accordingly!

## Congratulations
In this scenario you got a glimpse of the power of reactive Quarkus applications when working with large amounts of data.

You also got to experience Quarkus Live Coding remote development. Remember Live Codign makes it so that local changes are immediately reflected in remote applications.

----

This is the last topic is this track.

There is much more to Quarkus than the concepts and techniques you covered in this topic. Be sure to visit [quarkus.io](https://developers.redhat.com/products/quarkus) to learn even more about the architecture and capabilities of this powerful framework for Java developers.

----

# Open the solution in an IDE in the cloud
Want to continue exploring this solution on your own in the cloud?

You can use the free [Red Hat CodeReady Workspaces](https://developers.redhat.com/products/codeready-workspaces/overview) IDE running on the free [Red Hat Developer Sandbox](http://red.ht/dev-sandbox). [Run here](https://workspaces.openshift.com) to log in or to register if you are a new user. This free service expires after 30 days, but you can always enable a new free 30-day subscription.

Once logged in, [run here](https://workspaces.openshift.com/f?url=https://raw.githubusercontent.com/openshift-katacoda/rhoar-getting-started/solution/quarkus/panache-reactive/devfile.yaml) to open the solution for this project in the cloud IDE. While loading, if it asks you to update or install any plugins, you can say no.