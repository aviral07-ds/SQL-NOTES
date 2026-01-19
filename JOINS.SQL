create database joins;
use joins;

create table table1(id int);
create table table2(id int);

insert into table1(id)
values(1),(1),(1),(2),(3),(3),(3),(null);
select * from table1;

insert into table2(id)
values (1),(1),(2),(4),(null),(null);
select * from table2;

# cross join
# syntax
# select columnlist/* from tablename1 cross join tablename2;

select * from table1 cross join table2;
select count(*) from table1 cross join table2;

# inner join
# syntax
# select columnlist/* from tablename1 inner join tablename2
# on tablename1.commoncolumnname=tablename2.commoncolumnname;
# sirf "join" bhi likhenege toh by default inner join hi perform hoga
select * from table1 t1 join table2 t2
on t1.id=t2.id;
select * from table1 t1 inner join table2 t2
on t1.id=t2.id;
select count(*) from table1 t1 inner join table2 t2
on t1.id=t2.id;

# note- without common column condition /(on) inner join behaves like cross join
select count(*) from table1 t1 inner join table2 t2;

# left join
# syntax
# select columnlist/* from tablename1 left join tablename2
# on tablename1.commoncolumnname=tablename2.commoncolumnname;

select * from table1 t1 left join table2 t2
on t1.id=t2.id;
select count(*) from table1 t1 left join table2 t2
on t1.id=t2.id;

# right join
# syntax
# select columnlist/* from tablename1 right join tablename2
# on tablename1.commoncolumnname=tablename2.commoncolumnname;

select * from table1 t1 right join table2 t2
on t1.id=t2.id;
select count(*) from table1 t1 right join table2 t2
on t1.id=t2.id;

# natural join
alter table table2 rename column id to eid;
select count(*) from table1 natural join table2; # diff columnname so it will act as a crossjoin
alter table table2 rename column eid to id;
select count(*) from table1 natural join table2; # same columnname so it will act as a inner join

# full join

# left join + right exclusive 
select * from table1 t1 left join table2 t2
on t1.id=t2.id
union all
select * from table1 t1 right join table2 t2
on t1.id=t2.id
where t1.id is null;

# left exclusive + right join 
select * from table1 t1 left join table2 t2
on t1.id=t2.id
where t2.id is null
union all
select * from table1 t1 right join table2 t2
on t1.id=t2.id;

# using dummy db
use dummy;

# cross join
select count(*) from customers cross join orders;

# inner join
# wasq to fetch customer detail who
# have placed any order?
select count(*) from customers c inner join orders o
on c.customernumber=o.customernumber;

# left join
#wasq to fetch who have either placed any order or not?

select count(*) from customers c left join orders o
on c.customernumber=o.customernumber;

# left exclusive
# wasq to fetch customers who not have placed any order?
select count(*) from customers c left join orders o
on c.customernumber=o.customernumber
where o.customernumber is null;

# right join
select count(*) from customers c right join orders o
on c.customernumber=o.customernumber;

# right exclusive
select count(*) from customers c left join orders o
on c.customernumber=o.customernumber
where c.customernumber is null;

# natural join
select count(*) from customers natural join orders ;

# full join
# left join + right exclusive
select count(*) from customers c left join orders o
on c.customernumber=o.customernumber
union all
select count(*) from customers c right join orders o
on c.customernumber=o.customernumber
where o.customernumber is null;

# left exclusive+ right join
select count(*) from customers c left join orders o
on c.customernumber=o.customernumber
where o.customernumber is null
union all
select count(*) from customers c right join orders o
on c.customernumber=o.customernumber;

# wasq to fetch customername and their ordervalue?
 select customername,(quantityordered*priceeach)as ordervalue from customers c inner join orders o 
 on c.customernumber=o.customernumber
 inner join orderdetails od 
 on o.ordernumber=od.ordernumber;

# wasq to fetch productname and their order value?
select productname,(quantityordered * priceeach) as ordervalue from products p inner join orderdetails od
on p.productcode=od.productcode;

# wasq to fetch customername and their respective salesrepname?
select customername,concat(firstname," ",lastname) as salesrepname from  employees e join customers c
on c.salesrepemployeenumber=e.employeenumber;

# wasq to fetch employeesname who does not represent any customer?
select concat(firstname," ",lastname)as empname from employees e left join customers c
on e.employeenumber=c.salesrepemployeenumber
where c.customernumber is null;

# wasq to fetch customername along with their order number and status(only fetch data who have placed any order)?
select customername,ordernumber,status from customers c inner join orders o
on c.customernumber=o.customernumber;

# wasq to fetch customerdetails who have not placed any order?
select * from customers c left join orders o
on c.customernumber=o.customernumber
where o.customernumber is null;

# wasq to fetch customername, paymentdate and amount from the customers and payments table?
select customername,paymentdate,amount from customers c inner join payments p
on c.customernumber=p.customernumber;

# query by using extension
select customernumber,customername,paymentdate,amount from customers c inner join payments p
on c.customernumber=p.customernumber; # it will throw ambiquity error cause it cant fetch common column from two tables

# fixing ambiquity below with on condition
select c.customernumber,customername,paymentdate,amount from customers c inner join payments p
on c.customernumber=p.customernumber; # here we used c.customernumber to avoid ambiqutiy error

# using extension
# can only be perform if dono table ke common column ka name same ho
# idhar ambiquity error nhi aata kyuki ye humesha left table ka common column fetch krta hai
select customernumber,customername,paymentdate,amount from customers c inner join payments p
using (customernumber);

# wasq to fetch orderdate and ordervalue?
select orderdate,(quantityordered*priceeach)as ordervalue from orders o inner  join orderdetails od
on o.ordernumber=od.ordernumber;

# wasq to fetch empfullname,customername ,orderdate,productname from multiple tables?
select concat(firstname," ",lastname) as empfullname,customername,orderdate,productname from
employees e inner join customers c on e.employeenumber=c.salesrepemployeenumber
inner join orders o on c.customernumber=o.customernumber 
inner join orderdetails od on o.ordernumber=od.ordernumber
inner join products p on od.productcode=p.productcode;

# wasq to fetch customername who have salesrepresentative but have not placed any order? (ans:2 records)
select customername,concat(firstname," ",lastname) as salesrepname from employees e inner join customers c
on e.employeenumber=c.salesrepemployeenumber
left join orders o 
on c.customernumber=o.customernumber
where o.customernumber is null;

# wasq to fetch productname that have not been sold?
select productname from products p left join orderdetails od 
on p.productcode=od.productcode
where od.productcode is null;

# wasq to fetch total number of records if we perform full join b/w two table
#1. product and order details
select count(*) from products p left join orderdetails od
on p.productcode=od.productcode
union all
select count(*) from products p right join orderdetails od
on p.productcode=od.productcode
where p.productcode is null;

# wasq to fetch empfullname,customername,and the productname from different tables?
select concat(firstname," ",lastname)as empfullname,customername,productname from employees e inner join customers c
on e.employeenumber=c.salesrepemployeenumber
inner join orders o 
on c.customernumber=o.customernumber
inner join orderdetails od
on o.ordernumber=od.ordernumber
inner join products p
on od.productcode=p.productcode;

# wasq to fetch the name of customer and employees who belongs to same city ?
select customername,concat(firstname," ",lastname) as empname,c.city as sharedcity from customers c inner join employees e
on salesrepemployeenumber=employeenumber
inner join offices o on e.officecode=o.officecode
where c.city=o.city;

# wasq to fetch customers who have placed orders but did not made any payment yet

select customername from customers c inner join orders o using(customernumber)
left join payments using(customernumber)
where payments.customernumber is null;

# wasq to fetch employeenumber.empfullname and customername from customers 
# and emplooyes(only fetch the record who belongs to usa,and order place btw 2003 and 2004
# and sort the data by order date most recent to least recent one?

select  employeenumber,concat(firstname," ",lastname)as empfullname,customername
from employees e inner join customers c 
on e.employeenumber=c.salesrepemployeenumber
inner join orders o using (customernumber)
where c.country="usa"
and o.orderdate between "2003-01-01" and "2004-12-31"
order by orderdate desc;

# SELF JOIN
USE DUMMY;
select * from employees;

# wasq to fetch managername,along with their direct reportee emp name?
select m.employeenumber,
concat(m.firstname," ",m.lastname)as manager,
concat(e.firstname," ",e.lastname)as "direct reportee" from
employees m inner join employees e
on m.employeenumber=e.reportsto;