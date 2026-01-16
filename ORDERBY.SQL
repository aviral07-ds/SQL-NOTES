# order by is a clause which is used to
# sort the results set

# syntax
# select col1,col2.....coln from tablename
# order by col1[ascn/descn],col2[ascn/descn],
# ....coln[ascn/descn]
# by default----> ASCENDING ORDER

# order of execution
# from-----> select---->order by

# SINGLE COLUMN sorting

#wasq to fetch contactlastname,contactfirstname from the customers table and 
# sort the data by contactlastname in ascn order?

select contactfirstname,contactlastname from customers
order by contactlastname;
 
# wasq to fetch customername,city,state,country and creditlimit from
# the customers table and sort the data by highest to lowest creditlimit
select customername,city,state,country,creditlimit from customers
order by creditlimit desc;

# MULTIPLE COLUMN SORTING...

# wasq to fetch contactlastname,contactfirstname from customers table
# and sort the record by contactlastname in desc then by contactfistname in asc?

select contactlastname,contactfirstname from customers
order by contactlastname desc;

select contactlastname,contactfirstname from customers
order by contactlastname desc,contactfirstname;

# SORTING IN EXPRESSIONS...

# Wasq to fetch to fetch ordernumber and their ordervalue from the orderdetails table
# sort the data by ordervalue in desc?

select ordernumber,(quantityordered*priceeach)as ordervalue from orderdetails
order by ordervalue desc;

# wasq to fetch employeefullname,jobtitle,officecode,from the employees table
# sort the data  first by officecode in asc then by jobtitle in desc and then 
# by employeefullname in alphabetical order? 

select concat(firstname," ",lastname)as employeefullname,jobtitle,officecode from employees
order by officecode,jobtitle desc,employeefullname asc;

# ORDER BY
# NULL

# wasq to fetch employees detail and sort the results set by reports to in asc order?
select * from employees
order by reportsto asc;

# wasq to fetch ordernumber,orderdate,status and sort the data
# by orderdate from most recent to earliest?

select ordernumber,orderdate,status from orders
order by orderdate desc;