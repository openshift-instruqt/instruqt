---
slug: database-setup
id: 6sd44wke013u
type: challenge
title: Topic 2 - Install Microsoft SQL Server on RHEL
tabs:
- title: Terminal 1
  type: terminal
  hostname: rhel
- title: Terminal 2
  type: terminal
  hostname: rhel
difficulty: intermediate
timelimit: 600
---



## Microsoft SQL Server Installation & Setup

To begin with install Microsoft SQL Server on RHEL (locally), here are the steps to do it.




2.1. **Install Microsoft SQL Server**



Download SQL Server Preview Red Hat repository configuration file.



```
sudo curl -o /etc/yum.repos.d/mssql-server.repo https://packages.microsoft.com/config/rhel/8/mssql-server-2019.repo
```




Install Microssoft_sql server.

```
sudo yum install -y mssql-server
```



mssql-conf setup using its full path and follow the prompts to set the SA password and choose your edition.

```
sudo /opt/mssql/bin/mssql-conf setup
```

Select option **2**

Next, Type **yes** to accept the license terms and give the following password(2 Times).

```
123@Redhat
```





Verify whether the Microsoft_sql service is running or not.

```
systemctl status mssql-server
```




SQL Server is now running on your RHEL machine and is ready to use!




2.2. **Installation of Microsoft SQL CLI tool**



The following steps are to install the SQL Server command line tool that is an sqlcmd.



1. Download the Red Hat repository configuration file.

```
sudo curl -o /etc/yum.repos.d/msprod.repo https://packages.microsoft.com/config/rhel/8/prod.repo
```



2.Install mssql-tools with the unixODBC developer package

```
sudo yum install -y mssql-tools unixODBC-devel
```

To accept the license terms kindly type **yes**

3. add /opt/mssql-tools/bin/ to your PATH environment variable, to make sqlcmd or bcp accessible from the bash shell. Modify the PATH environment variable in your ~/.bash_profile file with the following command:

```
echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc
```
```
source ~/.bashrc
```






2.3. **Connect to Database locally**

Run the sqlcmd with parameters for your SQL Server IP/name (-S), username (-U), and password (-P). In this tutorial, you are connecting locally, so the server name is localhost. The user name is sa and the password is the one you provided for the SA account during setup.

```
sqlcmd -S localhost -U sa -P '123@Redhat'
```



Create a new Database

```
CREATE DATABASE TestDB;
```

write a query to return the name of all of the databases on the server.

```
SELECT Name from sys.databases;
```




To execute the above queries write GO

```
GO
```

MicrosoftSQL is successfully installed & TestDB database  creation done. Click on **Next** now.
