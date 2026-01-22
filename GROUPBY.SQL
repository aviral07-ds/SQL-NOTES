# GROUP BY
# definition
# Group by is a clause which is used to group rows that have the
# same values in one or more specified column into a summary row
# it is typically used with aggregate funcn like 
# (max,min,count,sum,average) to perform calculation on each group
# and returns a single result for each group... 

# order of execution in SQL
# from-->where--->group by--->select--->distinct-->order by--->limit

# exception in MYSQL
# aliasing works in group by also
# order of execution
# from-->where--->select--->distinct--->group by-->order by--->limit
# wasq to fetch customername and their ordercount?
use dummy;
select customername,count(ordernumber)as ordercount from customers c inner join orders o
using(customernumber)
group by customername
order by ordercount desc;

# wasq to fetch customername,and their total ordervalue?
select customername,sum(quantityordered*priceeach) as ordervalue
from customers c inner join orders o using(customernumber)
inner join orderdetails od using(ordernumber)
group by customername;

# wasq to fetch total no of orders by each status 
 select status,count(ordernumber) from orders
 group by status;
 
# wasq to fetch total order value by product line by each order year?
select productline,sum(quantityordered*priceeach) as ordervalue,year(orderdate)as orderyear from orderdetails od inner join orders o using(ordernumber)
inner join products p using(productcode)
group by productline,orderyear;

# wasq to fetch customer count of each country?
select country,count(customernumber) as customercount from customers
group by country;

# wasq to fetch manager name and their direct reportee count?
select concat(m.firstname," ",m.lastname)as managername,count(d.employeenumber)as directreportee_count
from employees m inner join employees d
on m.employeenumber=d.reportsto
group by managername;

# wasq to fetch empfullname and their customer count?
select concat(firstname," ",lastname)as empfullname,count(customernumber)as customercount from employees e inner join customers c
on e.employeenumber=c.salesrepemployeenumber
group by empfullname;

# wasq to fetch empfullname and their total order value?
select concat(firstname," ",lastname)as empfullname,sum(quantityordered*priceeach)as ordervalue from
employees e inner join customers c
on e.employeenumber=c.salesrepemployeenumber
inner join orders o using(customernumber) inner join  orderdetails od using(ordernumber)
group by empfullname;

# wasq to fetch status from orders table?
select status from orders;

# wasq to fetch distinct status from orders table?
select distinct status from orders;

#basic group by clause
select status from orders
group by status ;

# group by with aggregate funcn?
# single column group by

# wasq to fetch no of orders per status?
select status,count(ordernumber) as ordercount from orders
group by 1;

# wasq to fetch total order value by status?
select status,sum(quantityordered*priceeach)as tov from orders inner join orderdetails using(ordernumber)
group by status;

# wasq to fetch tov by ordernumber?
select ordernumber,sum(quantityordered*priceeach)as tov from orderdetails
group by ordernumber;

# wasq to fetch totalsales of each order year?
select year(orderdate)as orderyear,sum(quantityordered*priceeach)as totalsales 
from orders inner join orderdetails using(ordernumber)
group by orderyear;

# wasq to fetch customername and total amount paid(of each year)?
select customername,sum(amount),year(paymentdate)as paymentdate from customers inner join payments using(customernumber) inner join orders using(customernumber)
group by year(paymentdate),customername;

# wasq to fetch productname and their total quantity ordered?
select productname,sum(quantityordered)as tqo from products inner join orderdetails using(productcode)
group by productname;

# wasq to fetch product name and their count?
select productname,count(quantityordered)as pcount from products inner join orderdetails using(productcode)
group by productname;

# wasq to fetch total sales of each employee in the year 2004?
select concat(firstname," ",lastname)as empname,sum(quantityordered*priceeach)as totalsales
from employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
inner join orders using(customernumber) inner join orderdetails using(ordernumber)
where year(orderdate)=2004
group by empname;

# wasq to fetch ordernumber and the no of items sold per order and total sales ?
select ordernumber,sum(quantityordered)as no_items_sold,sum(quantityordered*priceeach)as totalsales
from orderdetails group by ordernumber;

# HAVING

# SYNTAX
# select columnlist from tablename
# where search condition 
# group by columnname
# having grouping condition
# order by col;

# order of execution:
# from-->where-->group by-->having--->select-->distinct--->order by-->limit

# wasq to fetch ordernumber,status and total sales(only fetch the order whose status are shipped
# and the totalsales>10000)?

select ordernumber,status,sum(quantityordered*priceeach)as totalsales 
from orders inner join orderdetails using(ordernumber)
group by ordernumber,status
having status="shipped" and totalsales>10000;

# wasq to fetch all the employees and the customer they manage but also include employees who manages no
# customers additionally show the no of orders placed by each managed customer?

select concat(firstname," ",lastname)as empname,customername,count(distinct ordernumber)as no_of_op from
employees e left join customers c on e.employeenumber=c.salesrepemployeenumber
left join orders using(customernumber)
group by empname,customername;

# wasq to fetch find all the productlines where the totalrevenue exceed 1 lakh and at least
# 10 different product are sold ?

select productline,sum(quantityordered*priceeach) as tv,count(distinct productname) as dpn
from products inner join orderdetails using(productcode)
group by 1
having tv>100000 and dpn>=10;

# wasq to fetch customers who placed more than 4 order?

select customername,count(ordernumber)as no_op from
customers inner join orders using(customernumber)
group by customername
having no_op>4;

# wasq to fetch total order value of each productline of each year?
create table sales
select sum(quantityordered*priceeach)as tov,productline,year(orderdate)as year
from orders inner join orderdetails using(ordernumber) inner join products using(productcode)
group by productline,year;
select * from sales;

# wasq to fetch grand tov from sales table?
select sum(tov) as grandtov from sales;

# wasq to fetch grand tov of each order year?
select sum(tov) as grandtov,year from sales
group by year;

# wasq to fetch gtov of each productline?
select sum(tov)as grandtov,productline from sales
group by productline;

# to fetch super grand total

select productline,sum(tov)as gtov from sales group by productline
union
select supergtov,sum(tov) from sales;

# roll up
# it will fetch the data acc to column written in order

select productline,sum(tov)as gtov from sales
group by productline with rollup;

# wasq to fetch grandtotalordervalue by productline of each orderyear?
select productline,year,sum(tov)
from sales
group by productline,year with rollup;

# wasq to fetch productline,productname and total buyprice(also return the grand total)? 
select productline,productname,sum(buyprice)as totalbp from products
group by 1,2 with rollup;

# wasq to fetch no of customers of each country?
select count(customernumber)as no_of_customers,country from customers
group by country;

# wasq to fetch totalordervalue of each ordernumber of each year(also return the grandtotal)
select sum(quantityordered*priceeach) as tov,ordernumber,year(orderdate) as orderyear
from orders inner join orderdetails using(ordernumber)
group by orderyear ,ordernumber with rollup;

# wasq to fetch total no of customers by each country and filter only those
# countries who have more than 5 customers?
select count(customernumber)as totalcustomers,country from customers
group by country
having totalcustomers>5;

# display totalsales for each employee include with grand total at the end ?
select sum(quantityordered*priceeach)as totalsales,concat(firstname," ",lastname)as empname
from employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
inner join orders using(customernumber) inner join orderdetails using(ordernumber)
group by empname with rollup;


# show the total no of orders placed per country and include roll up total?
select sum(ordernumber)as totalorders,country from customers inner join orders using(customernumber)
group by country with rollup;
 
# display the avg ordervalue per employee based on their customers order and
# list only those with the avg above 2500?
select avg(quantityordered*priceeach)as avgordervalue,concat(firstname," ",lastname)as empname,customername
from employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
inner join orders using(customernumber) inner join orderdetails using(ordernumber)
group by empname,customername
having avgordervalue>2500;

#1. Display the number of customers in each country.
select count(customernumber),country from customers 
group by country;

#2. Show total quantity ordered for each productCode from the
#orderdetails table.
select sum(quantityordered)as total_qo,productcode from orderdetails
group by productcode;

#3. Find the total sales amount (quantityOrdered * priceEach) for
#each orderNumber.
select sum(quantityordered*priceeach)as totalsales,ordernumber from
orderdetails group by ordernumber;

#4. List each employee (salesRepEmployeeNumber) and the
#number of customers they manage.
select concat(firstname," ",lastname)as empname,count(customernumber)
from employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
group by empname;

#5. Show the count of customers in each country, but only include
#countries having more than 5 customers. (GROUP BY + HAVING)
select count(customernumber)as count_c,country from customers
group by country
having count_c>5;

#6.Display productCode and average priceEach, but only include 
# products where average price is greater than 100..
select productcode,avg(priceeach)as pavg from products inner join orderdetails using(productcode)
group by productcode
having pavg>100;
 
#7. Show the total quantity ordered per productCode, but only
#include products ordered more than 500 units.
select sum(quantityordered)as tqo,productcode from products inner join orderdetails 
using(productcode) group by productcode having tqo>500;

#8. Display each country and total sales value generated from
#customers in that country.
select customername,country,sum(quantityordered*priceeach)as totalsales from
customers inner join orders using(customernumber) inner join orderdetails using (ordernumber)
group by customername,country;

#9. Show count of customers grouped by both country and city.
select count(customernumber)as ccount,country,city from customers
group by country,city;

#10. Show the number of orders placed for each productCode
# and include only those products having more than 20 totalorders.
select count(ordernumber)as norder,productcode from 
products inner join orderdetails using(productcode)
group by productcode
having norder>20;

#11. Display total order value grouped by year of orderDate (use YEAR() + GROUP BY).
select sum(quantityordered*priceeach)as tov,year(orderdate)as oyear
from orders inner join orderdetails using(ordernumber)
group by oyear;

#12. Show each employeeNumber and total sales generated
#from their assigned customers (no subqueries allowed →
#requires multi-table join + GROUP BY only).
select employeenumber,sum(quantityordered*priceeach)as totalsales
from employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
inner join orders using(customernumber) inner join orderdetails using(ordernumber)
group by employeenumber;


#13. Show the count of products ordered for each
#orderNumber, but only include orders having more than 10 distinct products.
select count(distinct productcode)as porder,ordernumber
from products inner join orderdetails using(productcode)
group by ordernumber
having porder>10;

#14. Show total sales grouped by country and city, and include
#ROLLUP so output contains: (country, city totals + country totals + grand total).
select sum(quantityordered*priceeach)as totalsales,country,city
from customers inner join orders using(customernumber) inner join orderdetails using(ordernumber)
group by country,city with rollup;

#15. Display total quantity ordered for each productCode with
#ROLLUP (show each product total + final total).
select sum(quantityordered)as tqo,productcode from
products inner join orderdetails using(productcode)
group by productcode with rollup;


#16. Show number of customers grouped by country, city, and
#state, and include ROLLUP for all 3 levels.
select count(customernumber),country,city,state from customers
group by country,city,state with rollup;

#17. Show the number of employees per officeCode, including
# office total and grand total using ROLLUP.


#18. Show total sales per employeeNumber and include
# ROLLUP to show grand total sales for all employees.
select sum(quantityordered*priceeach)as totalsales,employeenumber
from employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
inner join orders using(customernumber) inner join orderdetails using(ordernumber)
group by employeenumber with rollup;

#19. Show total quantity ordered grouped by productCode and
# orderNumber using GROUP BY with ROLLUP (should produce
#product totals and full grand total).
select sum(quantityordered)as tqo,productcode,ordernumber from
products inner join orderdetails using(productcode)
group by productcode,ordernumber with rollup;

#20. Show the number of products ordered per orderNumber
#but include a ROLLUP to show a final summary row for totalrecords.
select count(productcode)as norder,ordernumber from
products inner join orderdetails using (productcode)
group by ordernumber with rollup;

# wasq to fetch avg buy price of each productline?
select avg(buyprice)as avgbp,productline from products
group by productline;

# wasq to fetch total buy price of each productline?
select sum(buyprice)as totalbp,productline from products
group by productline;

# wasq to fetch maximumn,minimum and total order value of each productline?
select max(quantityordered*priceeach)as maxov,min(quantityordered*priceeach)as minov,
sum(quantityordered*priceeach)as totalov,productline from orderdetails inner join products
using(productcode) group by productline;

# group_concat
# aggregate function

# wasq to fetch employee full name and their resp customername
#( fetch customername in a single row as comma seperate value)
select concat(firstname," ",lastname)as empfullname,group_concat(customername separator ',')as customername from
employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
group by empfullname;

# wasq to fetch country and their customername
# fetch customer name in single row as csv
select country,group_concat(customername) from customers
group by country;