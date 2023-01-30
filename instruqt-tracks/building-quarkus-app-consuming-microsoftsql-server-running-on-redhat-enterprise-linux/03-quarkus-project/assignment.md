---
slug: quarkus-project
id: yp2e1vrhohvf
type: challenge
title: Topic 3 - Qurkus Project Create
tabs:
- title: Terminal 1
  type: terminal
  hostname: rhel
- title: Terminal 2
  type: terminal
  hostname: rhel
- title: Terminal 3
  type: terminal
  hostname: rhel
- title: Visual Editor
  type: code
  hostname: rhel
  path: /root
difficulty: intermediate
timelimit: 1000
---



## 3. Qurkus Project Create.




**### 3.1. CRUD Application Flow Diagram**







![](https://lh4.googleusercontent.com/lykH3lMhYXpRefLwQMuIL-7-jOczBQNr69os-C_fFO7NeWMgM2xH5fJfHr4MBgIT49OY6Ys2gNbRL_JjUiurCyNr1zvh5dhco2dGBSdlSl1-tcplrRNYl8F25ZUTGXXU3wJBt5P_TPjkZYoRWRdj4bU5vdcr3jx3eVLTMhwJAKRAnVV9xOTXrS3oYco_)





**## 3.2. Quarkus App API Connectivity with Database**



You can find the source code with instructions used in this blog post in this [GitHub](https://github.com/redhat-developer-demos/quarkus-crud-mssql) repository.



Following is a snapshot of quarkus project directory.



![](https://lh6.googleusercontent.com/qKkrJaXHP3KTWL3z9Y2FMfUSCN9TAhq-Sx51sVaZdNe1U_z9-4OGErIqGoqo2UMjkp11_e4wy7f7NYlRbDIWZDwDai6-3lyLJG6Dgl_biA99z5pTNZcUdqjR0h-Zo2yjmk64vtSNwqL7A0Ut9jQ9tMvz_cLZtfKWs41gh5uVg1VqphzZzN8jTybInVVM)






**### 3.3. Run the application**



Clone the following Git repository in the **Terminal 1** window to create the CRUD quarkus project.

Install the git first

```
yum install git -y
```

```
git clone https://github.com/redhat-developer-demos/quarkus-crud-mssql.git
```



To run quarkus application you have to first check out on application folder which is a quarkus-crud-app


```
cd quarkus-crud-mssql
```

After this, you have to run a command with help of quarkus CLI

```
quarkus dev
```

![](https://lh5.googleusercontent.com/FngStSZxP8kiqNz5gUM10eTDYwFjOqXRD17GSQN07UjysAJhOlbzL6-lyEXmoeF4swnWYJ4UvE2jhyiahaEPw4lf0FgqV-GjBvWOrhFw4D04pGwk0ZnrugQsyKBZAMHZ2criS0pjDh5ipz4_9LXS3HAWHucuxTfsFQPtxLwdE7lYr39MNuIcWXZsEufh)



When the webpage successfully arrives on the browser we need to check if the API’ are working or not.



Let's install http cli

```
sudo pip3 install httpie
```



### List a new person
Open Terminal 3

```
http :8080/person
```




![](https://lh5.googleusercontent.com/C9pQPqMO3rx1WH5oTMfBpkQO2gUDPovX66r5FWoQple4EgSoEMo-QE03I3y36wvMdvvQlk_43J-Izo37YeB_KUVlj9jjLNvWOurtOpL8bWexMijjeZOKrbdjTLGS0wynlUVZjCiDxe1GjtLGB0Yg878rLCdQfldmoZ2dsZAcSF6AwpeA8wM0R_8f5F4J)





### Create a new person

```
http POST :8080/person firstName=Carlos lastName=Santana salutation=Mr
```

![](https://lh4.googleusercontent.com/tGIyb5psKftQSsZfvNuNwfAf71nyEzKVJCYBZiQj0GZRNGEoo4s0n3YSUb1YXFdC4t3CLy9WkatIKkD3odYOlLvpeB65eNKCFAWPeK98K5362gP5oZZ0msq65kx_QcnBEvG2U-qHVlDAXo9Qhzk6JsEZ4H0lsL9uzbfMgADyVOJGSfjMc4y90OHbt-ms)






### Updating an existing person

```
http PUT :8080/person/1 firstName=Jimi lastName=Hendrix
```

![](https://lh6.googleusercontent.com/58MTUpe5nnYOVuPQDyXX7Qq--y_9sf9OJ6OFknUzSfUrXG88XqnnsY1Mwc4awy7FosuGAB9deodQnmAn_n48Z4U5WsFXo0Hk1R-AF4PSZyCo26ir_Fwz0r5VFJMUF7uCvXdTdD8NmPvRzTqQXc8hoZozMlNBygsSAHGnQC-hCN_02cEG8J-suTjahO3Z)












### Deleting an existing person

```
http DELETE :8080/person/1
```




![](https://lh5.googleusercontent.com/GoieZ_esZkVBDnc22SR0uR_kJ_Kbsx6nE90xENZ4LTmvp2aegzT096N78evYVWsKoqv9VQ-lZZyg3hufOpMajHQGmoe_ULB4d05jebdajHLahjlXWnNSAagjTBOOVEMPK6RyQStogjybaLAlEoloEz4Z1gb6ZQvrcQHeqcWZiNF2giKkfEJ9E7jBO2d4)





Now with help of API we created, deleted & updated the database. To check all changes are reflected in the database we have to cross-verify. For that Please follow the below steps.





First, we need to login into the Microsoft SQL database. For that, we need to use sqlcmd. please run the following command:

```
sqlcmd -S localhost -U sa -P '123@Redhat'
```




Now select the sample database which we created earlier.

```
USE TestDB
```

```
GO
```




List the data from our collection for that run the following command to list all data.

```
SELECT * FROM Person
```
```
GO
```










After running the above command you will get the following result in your terminal.



![](https://lh4.googleusercontent.com/A0mHeUoCYV5HgfPfb0Bt4Oi73zY5Z4ao-ihr1bFqNwm_F7GxDT5hn6PE1-1sIJ_WzkR_7TKsmpLCaOtHD-HOHjfXO1wcU9_OSN_1O6CCNBtbuf6VOxA2RXXn1xtBIdC-25YNX8dd1kSgJ3Y_P-xI-rgWwa1UMrT6M1aBS8wtrl_kdxzPIOatk105IonA)