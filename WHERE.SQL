# WHERE
# WHERE is a clause which is used to filter 
# records on the basis of search condition

# Syntax
# select columnlist from tablename
# where search condition
# order by columnname {asc/desc};

# order of execution
# from--->where----->select---->orderby
# aliasing will not work here because of order of execution

# wasq to fetch employees detail
# whose jobtitle are sales rep,
# and sort the data by officecode in desc?

select * from employees
where jobtitle="sales rep"
order by officecode desc;

# wasq to fetch customernumber,customername,and creditlimit
# who belongs to usa and sort the data by credit limit in desc ?

select customernumber,customername,creditlimit from customers
where country="usa"
order by creditlimit desc;

# not equals to
# <>,!=
select customernumber,customername,creditlimit from customers
where country!="usa"
order by creditlimit desc;

# logical operators
# AND
select employeenumber,firstname,lastname,jobtitle,officecode from employees
where officecode=1 and jobtitle="sales rep";

# OR
select employeenumber,firstname,lastname,jobtitle,officecode from employees
where officecode=1 or jobtitle="sales rep";

# Wasq to fetch the employeenumber,empfullname and officecode
# who belongs to officecode=1,2 and 3
# and sort the data by empfullname in desc
select employeenumber,concat(firstname," ",lastname)as empfullname,officecode from employees
where officecode=1 or officecode=2 or officecode=3
order by empfullname desc;

# wasq to fetch customernumber and customername
# who belongs to usa,japan and france ?
select customernumber,customername from customers
where country="usa" or country="japan" or country="france";



# BETWEEN OPERATOR
# between low and high
# and both low and high values are inclusive

select employeenumber,concat(firstname," ",lastname)as empfullname,officecode from employees
where officecode between 1 and 3
order by empfullname desc;

# not between case
select employeenumber,concat(firstname," ",lastname)as empfullname,officecode from employees
where officecode  not between 1 and 3
order by empfullname desc;

# wasq to fetch ordernumber,orderdate, and status 
# from orders table(only fetch orders who placed in 2003 and 2004?
select ordernumber,orderdate,status from orders
where orderdate between "2003-01-01" and "2004-12-31";

# wasq query with comparison operator
select ordernumber,orderdate,status from orders
where orderdate >= "2003-01-01" and orderdate<= "2004-12-31";

select customername,city,state,creditlimit from customers
where creditlimit>=100000 and creditlimit<=200000;

select customername,city,state,creditlimit from customers
where creditlimit between 100000 and 200000;

# wasq to fetch employees detail who belongs to officecode 1,3 and 5
select * from employees
where officecode in (1,3,5);

# wasq to fetch payment made in 2003(fetch customernumber,checknumber and amount)
select customernumber,checknumber,amount from payments
where paymentdate between "2003-01-01" and "2003-12-31";

# wasq to fetch customers who belongs to usa and have credit limit greater than 150000?
select * from customers
where country="usa" and creditlimit>=150000;

# wasq to fetch prodcutname whose msrp greater than 100?
select productname from products
where msrp>100;

# wasq to fetch employeenumber,empfullname from the employees table
# who belongs to office code 1,2 and 3 and jobtitle are sales rep?
select employeenumber,concat(firstname," ",lastname)as empfullname from employees
where officecode in (1,2,3) and jobtitle="Sales Rep" ;

# IN OPERATOR

# wasq to fetch customername,city,state,
# country from customers table who belong usa,japan, and france?
select customername,city,state,country from customers
where country in ("usa","japan","france");

# IS/ IS NOT

# wasq to fetch employeenumber,empfullname,jobtitle 
# who does not reports to anyone?

select employeenumber,concat(firstname," ",lastname) as empfullname,jobtitle from employees
where reportsto is null;

select customername,customernumber,state,country from customers
where state is not null
order by state asc;

# distinct(returns unique values)
# order of execution
# from---> where---> select--->distinct---->order by

select country from customers;
select distinct country from customers;               # with distinct
select distinct country,customername from customers;  # can't perform in multiple columns 

select status from orders;
select distinct status from orders;                   # with distinct


# LIKE OPERATOR
# pattern matching
# wild card operator 
# 1. %
# 2. _ underscore

select customername from customers
where customername like "a%";

select customername from customers
where customername like "a%.";

select customername from customers
where customername like "%.";

select productname from products
where productname like "%car%";

select firstname,lastname from employees
where firstname like "t_m";

# wasq to fetch customername whose name starts with vowels?
select customername from customers
where customername like "a%"
or customername like "e%"
or customername like "i%"
or customername like "o%"
or customername like "u%";

# wasq to fetch customername whose name ends with vowels?
select customername from customers
where customername like "%a"
or customername like "%e"
or customername like "%i"
or customername like "%o"
or customername like "%u";


# wasq to fetch customername whose name starts with vowels and ends with vowels?
select customername from customers
where (customername like "a%" or customername like "e%" or 
customername like "i%" or customername like "o%" or customername like "u%")
and (customername like "%a" or customername like "%e" or customername like "%i"
or customername like "%o" or customername like "%u");

# wasq to fetch customername whose name do not starts with vowels?
select customername from customers
where customername not like "A%"
and customername not like "E%"
and customername not like "I%"
and customername not like "O%"
and customername not like "U%";

# LIMIT - RETURNS ROW COUNT
# order of execution
# from---> where---> select----> distinct--->orderby----> limit
# wasq to fetch customer details only fetch first 10 records?
select * from customers limit 10;

# wasq to fetch customername,customernumber, and credit limtit from customers
# ( that return top 5 highest credit limit customer) ?
select customername,customernumber,creditlimit from customers
order by creditlimit desc limit 5;

# offset
select customername,customernumber,creditlimit from customers
order by creditlimit desc limit 5 offset 0;

select customername,customernumber,creditlimit from customers
order by creditlimit desc limit 2 offset 1; 

select customername,customernumber,creditlimit from customers
order by creditlimit desc limit 1,2; # same as above query with diff way

select * from customers limit 10 offset 10; #(fetch another 10 records)

# wasq to fetch 2nd highest qty in stock product from prodcuts table?
select productname,quantityinstock from products
order by quantityinstock desc limit 1 offset 1;

# wasq to fetch customername,customernumber,city,state,country and creditlimit
# who belongs to usa, france, japan and have creditlimit more than 50k whose name starts with vowels?

select customername,customernumber,city,state,country,creditlimit from customers
where country in("usa","japan","france") and creditlimit>50000 and (customername like "a%" or customername like "e%"
or customername like "i%" or customername like "o%" or  customername like "u%");

# wasq to fetch ordernumber,orderdate,status from the orders table
# only fetch the orders placed in 2003 and have shipped status , sort
# the data by orderdate in asc?
select ordernumber,orderdate,status from orders
where orderdate between "2003-01-01" and "2003-12-31"
and status="shipped" order by orderdate asc;

# wasq to fetch employeenumber,empname,officecode,jobtitle from employees table 
# only fetch the record whose name starts with consonant and sort the data by firstname in asc
# and then by last name in desc
select employeenumber,concat(firstname," ",lastname) as empname,officecode,jobtitle from employees
where (firstname not like "a%" and firstname not like "e%" and firstname not like "i%" and firstname not like "o%" and firstname not like "u%")
order by firstname asc, lastname desc;