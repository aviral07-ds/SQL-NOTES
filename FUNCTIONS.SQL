# Control flow functions

# "CASE WHEN"
# question 1:-
# wasq to fetch customername and thier ordercount?
# on the basis of ordercount create 1 custom column
# name customer_type conditions are if ordercount is 1
# then 1 time customer,if orderc is 2 then repeated customer
# if oc is 3 then frequent customer
# if ordercount>=4 then loyal customer?

with cte as
(select customername,count(ordernumber)as ordercount from 
customers inner join orders using(customernumber)
group by customername)
select *,
case ordercount
when 1 then "one time customer"
when 2 then "repeated customer"
when 3 then "frequent customer"
else "loyal customer"
end as customer_type from cte;

# question 2:-
# wasq to fetch customername and their tov on the basis of tov
# create one custom column customer_type conditions are
# if tov<10k then silver customer
# if tov btw 10k and  100k then gold customer
# if tov>100k then platinum customer?

with cte as
(select customername,sum(quantityordered*priceeach)as tov from
customers inner join orders using(customernumber) inner join
orderdetails using(ordernumber) 
group by customername),
cte1 as(
select *,
case
when tov<10000 then "silver customer"
when tov between 10000 and 100000 then "gold customer"
else "platinum customer"
end as customer_type from cte )
select customer_type,count(*) as cust_count from cte1
group by customer_type;

# question 3;-
# wasq to fetch total sales of each employee on the basis of ts
# create 1 custom column employee_type
# condtions apne hisab se

with cte as
(select sum(quantityordered*priceeach)as totalsales,concat(firstname," ",lastname)as empname
from employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
inner join orders using(customernumber) inner join orderdetails using (ordernumber)
group by empname),
cte1 as
(select *,
case
when totalsales between 300000 and 500000 then "beginner employee"
when totalsales between 500000 and 1000000 then " intermediate employee"
else "experienced employee"
end as employee_type from cte)
select employee_type, count(employee_type)as count_customer from cte1
group by employee_type;

# question 4:-
# wasq to fetch total order value of each productline on the basis of totalov
# create 1 custom column productline_type conditions are:
# 1.highest selling productline 2.avg selling productline
# 3. lowest selling productline

with cte as
(select sum(quantityordered*priceeach)as tov,productline from
orderdetails inner join products using(productcode)
group by productline),
cte1 as(
select *,
case 
when tov between 100000 and 1000000 then "lowest selling productline"
when tov between 1000000 and 2000000 then "average selling productline"
else "highest selling productline"
end as productline_type from cte)
select productline_type,count(*)as count_pltype
from cte1 group by productline_type;

# pivotting of the table

# question 5:-
# wasq to fetch ordercount of each status 
# in a single row?
select
sum(case when status="shipped" then 1 else 0 end) as "shipped",
sum(case when status="resolved" then 1 else 0 end) as "resolved count",
sum(case when status="cancelled" then 1 else 0 end) as"cancelled count",
sum(case when status="on hold" then 1 else 0 end )as "on hold count",
sum(case when status="disputed" then 1 else 0 end) as "disputed count",
sum(case when status="in process" then 1 else 0 end) as "in process",
count(*)as ordercount from orders;

# question 6:-
# wasq to fetch number of products count of each productline in a single row?

select
sum(case when productline="classic cars" then 1 else 0 end) as "cars count",
sum(case when productline="motorcycles" then 1 else 0 end) as "motorcycle count",
sum(case when productline="planes" then 1 else 0 end) as"planes count",
sum(case when productline="ships" then 1 else 0 end )as "ships count",
sum(case when productline="trains" then 1 else 0 end) as "trains count",
sum(case when productline="trucks and buses" then 1 else 0 end) as "T&B Count",
sum(case when productline="vintage cars" then 1 else 0 end) as "vintage cars count",
count(*)as productcount from products;

# question 7:-
# wasq to fetch customernumber,customername,city,state,country
# sort the customers by state if state is not null or
# sort the country in case state is null?
select customernumber,customername,city,state,country from customers
order by 
case when state is not null then country else state end ;


# "if(condition,true,false"
# nested if

# question 1:-
# wasq to fetch customername and thier ordercount?
# on the basis of ordercount create 1 custom column
# name customer_type conditions are if ordercount is 1
# then 1 time customer,if orderc is 2 then repeated customer
# if oc is 3 then frequent customer
# if ordercount>=4 then loyal customer?

with cte as
(select customername,count(ordernumber)as ordercount from 
customers inner join orders using(customernumber)
group by customername),
cte1 as(
select *,
if(ordercount=1,"one time customer",
  if(ordercount=2,"repeated customer",
    if(ordercount=3,"frequent customer","loyal customer")))
  as customer_type  from cte )
  select customer_type,count(*)as cust_count
  from cte1 group by customer_type;
  
# question 2:-
# wasq to fetch customername and their tov on the basis of tov
# create one custom column customer_type conditions are
# if tov<10k then silver customer
# if tov btw 10k and  100k then gold customer
# if tov>100k then platinum customer?

with cte as
(select customername,sum(quantityordered*priceeach)as tov from
customers inner join orders using(customernumber) inner join orderdetails using(ordernumber)
group by customername),
cte1 as(
select *,
if(tov<10000,"silver customer",
 if(tov between 10000 and 100000,"gold customer","platinum customer"))
 as customer_type from cte)
 select customer_type,count(*)as cust_count
 from cte1 group by customer_type;

# question 3;-
# wasq to fetch total sales of each employee on the basis of ts
# create 1 custom column employee_type
# condtions apne hisab se?

with cte as(
select sum(quantityordered*priceeach)as totalsales,concat(firstname," ",lastname)as empname from
employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
inner join orders using(customernumber) inner join orderdetails using (ordernumber)
group by empname),
cte1 as(
select *,
if(totalsales between 300000 and 500000,"beginner employee",
  if(totalsales between 500000 and 1000000,"intermediate employee","experienced employee"))
  as employee_type from cte)
select employee_type,count(*)as ecount from cte1
group by employee_type;

# question 4:-
# wasq to fetch total order value of each productline on the basis of totalov
# create 1 custom column productline_type conditions are:
# 1.highest selling productline 2.avg selling productline
# 3. lowest selling productline?

with cte as(
select sum(quantityordered*priceeach)as tov,productline from
products inner join orderdetails using(productcode)
group by productline),
cte1 as(
select *,
if(tov between 100000 and 1000000,"lowest selling productline",
 if(tov between 1000000 and 2000000,"average selling productline","highest selling productline"))
 as productline_type from cte)
 select productline_type,count(*)as linecount
 from cte1 group by productline_type;

# question 5:-
# wasq to fetch ordercount of each status 
# in a single row?

select
sum(if(status="shipped",1,0))as "shipped count",
sum(if(status="on hold",1,0))as "on hold count",
sum(if(status="in process",1,0))as "ip count",
sum(if(status="disputed",1,0))as "disputed count",
sum(if(status="cancelled",1,0))as "cancelled count",
sum(if(status="resolved",1,0))as "resolved count",
count(*)as ordercount from orders;

# question 6:-
# wasq to fetch number of products count of each productline in a single row?

select
sum(if(productline="classic cars",1,0))as "cc count",
sum(if(productline="vintage cars",1,0))as "vc count",
sum(if(productline="motorcycles",1,0))as "motorcycle count",
sum(if(productline="T&B",1,0))as "T&B Count",
sum(if(productline="planes",1,0))as "planes count",
sum(if(productline="trains",1,0))as "trains count",
sum(if(productline="ships",1,0))as "ships count",
count(*)as productcount from products;

# question 7:-
# wasq to fetch customernumber,customername,city,state,country
# sort the customers by state if state is not null or
# sort the country in case state is null?
select customernumber,customername,city,state,country from customers
order by 
if(state is null,country,state);