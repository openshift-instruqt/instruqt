---
slug: 04-add-paging-filtering
id: cnkylmsgqkji
type: challenge
title: Topic 4 - Adding paging and filtering capabilities to the demonstration application's
  RESTful API
teaser: Learn how modify the demonstration application's source code to enable data
  paging and filtering
notes:
- type: text
  contents: Topic 4 - Adding paging and filtering capabilities to the demonstration
    application's RESTful API
tabs:
- id: i5jmsxp6dly1
  title: Terminal 1
  type: terminal
  hostname: crc
- id: xcwmdffhid6l
  title: Visual Editor
  type: code
  hostname: crc
  path: /root/projects/rhoar-getting-started/quarkus/panache
difficulty: basic
timelimit: 300
---
In the previous topic you added custom queries to the `Person` entity bean. Also, you added endpoints that use those queries to the  `PersonResource` class.

In this topic you'll build queries that include filtering, searching, and paging capabilities.

# Showing data in tables

In the previous topic you used the `curl` command to access the application's data. Accessing data via `curl` is useful for testing, but many general purpose applications use web pages to view tables. Typically these web pages have features for searching, sorting, filtering, and paging through data.

Fortunately Quarkus and Panache make it easy to create web pages for your application that provide such capabilities.

In this topic you'll use a popular jQuery-based plugin called [DataTables](https://www.datatables.net/) to display data in a web page. The DataTables plugin has a server-side processing mode where it depends on the server (in this case the Quarkus app) to do searching, filtering, sorting, and paging.

Having searching, filtering, sorting, and paging executed on the server-side is useful for very large datasets that have hundreds of thousands, if not millions of records.

The alternative is to transmit the entire data set of interest to the client browser. Putting all the data on the client is inefficient. Storing data in the client will crash browsers, increased networking usage, and frustrate users.

The best option is to execute data processing on the server and then return only the exact data that needs to be displayed in the client.

# Adding a new RESTful endpoint

The way that the [DataTables plugin](https://www.datatables.net/manual/server-side) works is that the front end calls a RESTfull API endpoint on the back end to retrieve data according to criteria described in a set of query parameters.

The query parameters tell the server how to sort, filter, and search the backend database. Also, query parameters describe the page size of the returned data along with the current page the user is viewing. The DataTable needs the following query parameters in order to fulfill its mission:

* `start` - The index of the starting element in the data set of interest.
* `length` - Total maximum number records to return.
* `search[value]` - The search criteria.
* `draw` - Indicates if the DataTables should do asynchronous processing. Zero (0) indicates synchronous processing. One (1) indicates asynchronous processing. The `draw` value is sent with each request.

----

`Step 1:` Click the **Visual Editor** tab on the horizontal menu bar over the terminal window to the left.

-----

`Step 2:` Navigate to the file `src/main/java/org/acme/person/PersonResource.java` using the Visual Editor's directory tree. Click on the file `PersonResource.java` to open it for editing as shown in the figure below:

![Select Person Resource](../assets/select-personresource.png)

----

`Step 3:` Copy and paste the following code snippet after the comment line `// TODO: add datatable query`:

```java
    @GET
    @Path("/datatable")
    @Produces(MediaType.APPLICATION_JSON)
    public DataTable datatable(
      @QueryParam(value = "draw") int draw,
      @QueryParam(value = "start") int start,
      @QueryParam(value = "length") int length,
      @QueryParam(value = "search[value]") String searchVal

      ) {
        // TODO: Begin result

        // TODO: Filter based on search

        // TODO: Page and return

    }
```

----

`Step 4:` Save the file `PersonResource.java` by clicking the `Disk` icon or pressing the `CTRL+S` keys.

The code snippet above uses JAX-RS `@QueryParam` annotations to specify the incoming parameters that will get used with the RESTful endpoint `GET /person/datatable`.

Next, let's add the code to build out `PersonResource`. An analysis of the build-out will follow.

----

`Step 5a:` Using the Visual Editor, add the following code to the file `PersonResource.java` after the comment line `// TODO: Begin result`:

```java
    DataTable result = new DataTable();
    result.setDraw(draw);
```

`Step 5b:` Using the Visual Editor, add the following code to the file `PersonResource.java` after the comment line `//TODO: Filter based on search`:


```java
    PanacheQuery<Person> filteredPeople;

    if (searchVal != null && !searchVal.isEmpty()) {
        filteredPeople = Person.<Person>find("name like :search",
          Parameters.with("search", "%" + searchVal + "%"));
    } else {
        filteredPeople = Person.findAll();
    }
```

`Step 5c:` Using the Visual Editor, add the following code to the file `PersonResource.java` after the comment line `//TODO: Page and return`:

```java
    int page_number = start / length;
    filteredPeople.page(page_number, length);

    result.setRecordsFiltered(filteredPeople.count());
    result.setData(filteredPeople.list());
    result.setRecordsTotal(Person.count());

    return result;
```

----

`Step 6:` Save the file `PersonResource.java` by clicking the `Disk` icon or pressing the `CTRL+S` keys.

Let's analyze the code.

# Analyzing the build-out of the PersonResource API endpoint

The place to start is by understanding the relationship between Panache and the POJO `DataTable`.

Panache provides a layer of implicit operations over a database to which it is bound. Panache enables declaratively search, filter, sort and page data. You don't have to do the programming, all you need to do is provide the particular values for searching, filtering, sorting, and paging.

Panache has the implicit intelligence to retrieve data from a database according to its configuration settings. The result data is attached to the Panache object automatically.

After the Panache object is populated with data from a database, its values are applied to the POJO `DataTable`.

The `DataTable` POJO has the following fields:

* `draw` - The async processing record id.
* `recordsTotal` - Total records in database.
* `recordsFiltered` - Total records that match filtering criteria.
* `data` - The actual array of records.
* `error` - Error string, if any.

The client-side renderer of the DataTable in the browser expects these fields to be present in the data that gets passed from the server-side application. The client-side DataTable has intelligence built in that knows how to render data according to these fields.

On the server-side, the `PersonResource.java` endpoint handler function transforms the POJO `DataTable` into a JSON object that gets passed back to the client-side DataTable plugin running in the browser. As you just read, the client-side DataTable plugin knows how to render JSON according to the predefined fields that DataTable expects.

The following figure illustrates the Panache/DataTable architecture:

![Panache Architecture](../assets/panache-arch.png)

Let's take a look at the particulars of the code again.

The following code snippet taken from the `PersonResource.java` file above shows the instantiation of a `DataTable` object. Also, the code shows the  DataTable's `draw` field being assigned the value of the `PersonResource`'s variable `draw` via the DataTable's setter method `setDraw()`:

```java
    DataTable result = new DataTable();
    result.setDraw(draw);
```

Since `result.setDraw(draw)` is relevant only to how the client-side DataTable plugin will process data--synchronously or asynchronously-- there is no need to get data from Panache.

These lines of code below create a `PanacheQuery` object variable named `filteredPeople`. At the start `filteredPeople` is `null`.

But, `filteredPeople` becomes operational once it's assigned data by way of `Person.<Person>find(...)`:

```java
      PanacheQuery<Person> filteredPeople;

      if (searchVal != null && !searchVal.isEmpty()) {
          filteredPeople = Person.<Person>find("name like :search",
            Parameters.with("search", "%" + searchVal + "%"));
      } else {
          filteredPeople = Person.findAll();
      }
```

Finally, the DataTable POJO instance variable `result` is fully configured in this code snippet:

```java
    filteredPeople.page(page_number, length);

    result.setRecordsFiltered(filteredPeople.count());
    result.setData(filteredPeople.list());
    result.setRecordsTotal(Person.count());

    return result;
```
Also, as you can see above, the `result` is returned from the endpoint handler. (Internally the `result` POJO is transformed to JSON before the data is returned to the calling browser.)

Admittedly, there's a lot going on. You might want to review the analysis again.

The important thing to understand is that Panache is responsible for getting the data from the database according to search, filter, sort, and paging criteria.

The role of the POJO `DataTable` is to provide the data structure that gets transformed into an array of JSON objects in a schema that the DataTable plugin on the client-side expects.

The job of the client-side DataTable plugin is render the data in the browser in a traversable manner.

# Exercising searching

You've completed the code analysis. Now let's conduct an informal test of the new search endpoint using `curl`.

----

`Step 7:` Run the following command in the **Terminal 1** console to search the database for names that contain the string `yan`:

```
curl -s "$APP_URL/person/datatable?draw=1&start=0&length=10&search\[value\]=yan" | jq
```

You will get a single entity returned since the three-person sample data has only one person with `yan` in the name:

```json
{
  "data": [
    {
      "id": 1,
      "birth": "1974-08-15",
      "eyes": "BLUE",
      "name": "Farid Ulyanov"
    }
  ],
  "draw": 1,
  "recordsFiltered": 1,
  "recordsTotal": 3
}
```

Notice that the URL used in the `curl` command above has `draw`, `start`, and `length` query parameters in addition to the `search` query parameter.

The query parameter values are `draw=1`, `start=0` and `length=10`.

Hence the query will run asynchronously (`draw=1`), starting at the beginning of the total dataset (`start=0`), and the maximum page size will be 10 (`length=10`).

# Congratulations

You have successfully written an endpoint that uses the DataTable plugin in conjunction with Quarkus and Panache. The code you added enabled the demonstration project to page, filter, sort, and search data. Also, you analyzed the inner workings for Panache and the DataTable plugin.

In the next topic you'll add in code that will react to events in the application. Also, you'll add more queries.

----

**NEXT:** Adding a startup task in response to an application event
