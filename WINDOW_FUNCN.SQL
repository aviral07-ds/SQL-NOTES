CREATE TABLE sales1(
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee,fiscal_year)
);

INSERT INTO sales1(sales_employee,fiscal_year,sale)
VALUES('Bob',2016,100),
      ('Bob',2017,150),
      ('Bob',2018,200),
      ('Alice',2016,150),
      ('Alice',2017,100),
      ('Alice',2018,200),
       ('John',2016,200),
      ('John',2017,150),
      ('John',2018,250);

SELECT * FROM sales1;

# wasq to fetch total sales?
select sum(sale) as totalsales from sales1;

# WITH WINDOWS WF
select *,sum(sale) over() as totalsales from sales1;

# wasq to fetch ts by fiscal_year?
select sum(sale) as totalsales,fiscal_year as ts from sales1
group by fiscal_year;

# WITH WINDOWS WF
select *,sum(sale) over(partition by fiscal_year) as totalsales from sales1;

# wasq to fetch ts by sales_employee?
select sum(sale)as totalsales,sales_employee from sales1
group by sales_employee;

# WITH WINDOWS WF
select *,sum(sale) over (partition by sales_employee)as totalsales from sales1;

# wasq to fetch total buyprice ,max buyprice,min bp,avg bp of 
# each productline with WF?

Select productname,productline,buyprice,sum(buyprice) over(partition by productline) as totalbp,
max(buyprice) over(partition by productline) as maxbp,
min(buyprice) over(partition by productline) as minbp,
avg(buyprice) over(partition by productline) as avgbp
from products;

#1. wasq to fetch totalsale,avg sale,max sale,min sale
# of each productline with wf

select concat(firstname," ",lastname)as empname,customername,productline,productname,
sum(quantityordered*priceeach) over (partition by customername)as totalsales,
avg(quantityordered*priceeach) over (partition by customername)as avgsales,
max(quantityordered*priceeach) over (partition by customername)as maxsales,
min(quantityordered*priceeach) over (partition by customername)as minsales
from employees e inner join customers c
on e.employeenumber=c.salesrepemployeenumber
inner join orders using(customernumber) 
inner join orderdetails using(ordernumber)
inner join products using(productcode)
where quantityordered>50;


#3.Compare Each Employee’s Sales With Average Sales of Their Office

WITH cte AS (
  SELECT
    employeeNumber,
    e.officeCode,
    COALESCE(SUM(p.amount), 0) AS employee_total_sales
  FROM employees e
  LEFT JOIN customers c
    ON e.employeeNumber = c.salesRepEmployeeNumber
  LEFT JOIN payments p
    using(customernumber)
  GROUP BY employeeNumber, e.officeCode
)
SELECT
  employeeNumber,
  officeCode,
  employee_total_sales,
  AVG(employee_total_sales) OVER (PARTITION BY officeCode) AS office_avg_sales,
  employee_total_sales - AVG(employee_total_sales) OVER (PARTITION BY officeCode) AS performance_difference
FROM cte
ORDER BY officeCode, performance_difference DESC, employee_total_sales DESC;

# wasq to fetch ordernumber of each country of each year?
select customername,country,year(orderdate),ordernumber,
count(ordernumber) over(partition by country,year(orderdate)) as ordercount
from orders inner join customers
using(customernumber);

# RANK WINDOW FUNCTION

# wasq to give sequential number to products table?

select *,row_number() over() as r_no from products;

select row_number() over() as r_no,p.* from products p;

select row_number() over(order by buyprice desc) as r_no,p.* from products p;

# wasq to give sequential no to each productline in products table?

select row_number() over(partition by productline) as r_no,p.*
from products p;

# wasq to fetch top buy price products of each productline?

with cte as
( select productline,productname,buyprice,row_number()
over (partition by productline order by buyprice desc) as r_no
from products)
select * from cte where r_no=1;

select *,
row_number() over(partition by fiscal_year order by sale desc) as r_no,
rank() over(partition by fiscal_year order by sale desc) as rno,
dense_rank() over(partition by fiscal_year order by sale desc) as rn
from sales1;

# wasq to fetch highest ordervalue customer of each country?
with cte as
(select sum(quantityordered*priceeach)as ordervalue,
dense_rank() over(partition by country order by sum(quantityordered*priceeach) desc) as highestov,
customername,country from
customers c inner join orders o using(customernumber)
inner join orderdetails od using(ordernumber)
group by o.ordernumber,od.quantityordered)
select * from cte where highestov=1;

# wasq to fetch least selling product of each productline?
with cte as
(select sum(quantityordered) as sells,
dense_rank() over(partition by productline order by sum(quantityordered) asc)as leastselling,
productline,productname from 
products inner join orderdetails using(productcode)
group by productline,productname)
select * from cte where leastselling=1;


# wasq to fetch 2nd and 3rd highest quantityordered product of each productline?
with cte as
(select sum(quantityordered)as quantityordered,
dense_rank() over(partition by productline order by sum(quantityordered) desc) as hop,
productline,productname from
products inner join orderdetails using(productcode)
group by productline,productname)
select * from cte where hop=2 or hop=3;

# wasq to fetch 3rd highest ordercount customer of each year?

with cte as( 
select count(ordernumber) as ordercount,year(orderdate) as year,
dense_rank() over(partition by year(orderdate) order by count(ordernumber) desc)as hoc,
customername from 
customers inner join orders using (customernumber)
group by customername,year)
select * from cte where hoc=3;

# wasq to fetch least ordercount customers of each year of each country?
with cte as (
select count(ordernumber) as ordercount,year(orderdate) as year,country,
dense_rank() over(partition by country,year(orderdate) order by count(ordernumber) asc) as loc,
customername from 
customers inner join orders using (customernumber)
group by customername,year,country)
select * from cte where loc=1;

# wasq to fetch 2nd highest employee(acc to totalsales of each year)?
with cte as (
select sum(quantityordered*priceeach) as totalsales,year(orderdate) as year,
dense_rank() over(partition by year(orderdate) order by sum(quantityordered*priceeach) desc) as emp,
concat(firstname," ",lastname) as empname from
employees e inner join customers c
on e.employeenumber=c.salesrepemployeenumber
inner join orders using(customernumber)
inner join orderdetails using(ordernumber)
group by empname,year)
select * from cte where emp=2;

# wasq to fetch ordernumber,productcode and their order value
# only fetch thew record whose ordervalue btw 2000 and 3000
# and sort the data by ov in desc?

select ordernumber,productcode,(quantityordered*priceeach) as ov
from orderdetails inner join products using(productcode)
where (quantityordered*priceeach) between 2000 and 3000
order by ov desc;

# wasq to fetch top 2 manager name by no of employee they manage?
# with the help of dense_rank?
with cte as(
select concat(m.firstname," ",m.lastname)as manager,
count(e.reportsto) as countemp,
dense_rank() over(order by count(e.reportsto) desc) as dn
from employees m inner join employees e
on m.employeenumber=e.reportsto
group by 1)
select * from cte where dn<=2;

# wasq to fetch customername and their tov of each quarter of each country
#(fetch 2nd and 3rd highest )

with cte as(
select customername,sum(quantityordered*priceeach)as tov,country,quarter(orderdate),
dense_rank() over(partition by country,quarter(orderdate) order by sum(quantityordered*priceeach) desc)as dn
from customers inner join orders using(customernumber)
inner join orderdetails using(ordernumber)
group by customername,country,quarter(orderdate))
select * from cte where dn in(2,3);

# percent_rank
# always lies between o and 1
# formula==> rank-1/total row-1

# wasq to find percentile rank of every productline
# by total sales and also round off percent rank upto 2 decimal places

select productline,sum(quantityordered*priceeach)as totalsales,
round(percent_rank() over(order by sum(quantityordered*priceeach) asc),2) as pn
from products inner join orderdetails using(productcode)
group by 1;

# wasq to find percentile rank of employees by totalsales of each orderyear

select concat(firstname," ",lastname)as empname,sum(quantityordered*priceeach)as totalsales,year(orderdate)as orderyear,
round(percent_rank() over(partition by year(orderdate) order by sum(quantityordered*priceeach) asc),2) as pn
from employees inner join customers 
on employeenumber=salesrepemployeenumber
inner join orders using(customernumber)
inner join orderdetails using(ordernumber)
group by 1,3;

# wasq to fetch country=usa by ts each year

with cte as(
select customername,sum(quantityordered*priceeach)as totalsales,year(orderdate) as orderyear,country,
round(percent_rank() over(partition by year(orderdate) order by sum(quantityordered*priceeach) asc),2) as pn
from customers inner join orders using(customernumber)
inner join orderdetails using(ordernumber)
where country="usa"
group by 1,3,4)
select * from cte where pn>=0.50;
;

# wasq to fetch total sales diff btw current year and previous year
# of each productline of each year?
with cte as(
select productline,year(orderdate),sum(quantityordered*priceeach)as cts,
lag(sum(quantityordered*priceeach),1,0) over(partition by productline order by year(orderdate) asc)as pts
from products inner join orderdetails using(productcode) inner join orders using(ordernumber)
group by 1,2)
select *, 
cts-pts as salesdiff
from cte;

# wasq to fetch for each customerorder find the orderamount
# along with the previous orderamount(ov)?
select customername,(quantityordered*priceeach)as currentorderamt,year(orderdate),
lag((quantityordered*priceeach),1,0) over(partition by customername order by year(orderdate) asc)as prevorderamt
from customers inner join orders using(customernumber)
inner join orderdetails using(ordernumber);

# for each payments display the payment amount and the prev amount
# made by that customer?
select customername,amount,paymentdate,
lag(amount,1,0) over(partition by customername order by paymentdate asc)as prevamount
from customers inner join payments using(customernumber);

# for each order show the daydifference btw current orderdate
# and the previous order date of the same customer?
select orderdate as currentod,customername,ordernumber,
lag(orderdate,1,0) over(partition by customername order by orderdate) as prevorderdate,
datediff(orderdate,lag(orderdate,1,0) over(partition by customername order by orderdate)) as daydiffernce
from customers inner join orders using(customernumber);

#Retrieve all employees and the customers they manage
#but also include employees who manage no customers.
#Additionally, show the number of orders placed by each
#managed customer.

select concat(firstname," ",lastname) as empname,customername,count(ordernumber)as no_of_order
from employees left join customers 
on employeenumber=salesrepemployeenumber
inner join orders using(customernumber)
group by 1,2;

#Find customers who have never placed an order and also
#show their assigned sales representative (if any)

select customername,concat(firstname," ",lastname) as salesrep from
employees e inner join customers c
on employeenumber=salesrepemployeenumber
left join orders o using(customernumber)
where o.customernumber is null;

#List all products and the orders they appear but also
#include products that have never been ordered
select productname,ordernumber from
products left join orderdetails using(productcode);


#4 Using a SELF JOIN on the employees table, display each
#employee and the name of their direct manager.
select concat(m.firstname," ",m.lastname) as managername,
concat(e.firstname," ",e.lastname) as employee
from employees m inner join employees e
on m.employeenumber=e.reportsto;

#Identify employees who have the same manager and
#group them together using GROUP_CONCAT.


# For each customer, calculate the total order value and
#return only customers whose total value is greater than
#the average order value of all customers.
with cte as (
select customername,sum(quantityordered*priceeach)as tov,avg(quantityordered*priceeach)as avgtov
from customers inner join orders using(customernumber)
inner join orderdetails using(ordernumber)
group by 1)
select * from cte
where tov>avgtov;

#Find all product lines where the total revenue exceeds
#100,000 and at least 10 different products are sold .
select productline,sum(quantityordered*priceeach) as totalrevenue,count(distinct productname) as unique1
from products inner join orderdetails using(productcode)
group  by 1
having totalrevenue>100000 and count(distinct productname)>10;

#For each order, show a comma-separated list of product
#codes (GROUP_CONCAT) and order them by quantity
#ordered (highest first).
select ordernumber,group_concat(productcode order by quantityordered desc)
from products inner join orderdetails using(productcode)
group by ordernumber;

#9. Show each employee and a comma-separated list of all
#the distinct product lines their customers have
#purchased.
select concat(firstname," ",lastname)as empname,
group_concat( distinct productline)as productlines
from employees inner join customers
on employeenumber=salesrepemployeenumber
inner join orders using(customernumber)
inner join orderdetails using(ordernumber)
inner join products using(productcode)
group by 1;

#Extract the country code (first 3 letters) from each
#customer’s phone number, and group customers by
#country code, showing total orders placed.


# Display all customer names reversed and show the
#first 3 characters of each name.
Select
customerName,
reverse(customername) as reversed_name,
left(customerName, 3) as first_3_chars
from customers;