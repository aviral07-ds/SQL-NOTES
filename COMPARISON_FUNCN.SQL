# COMPARISON FUNCTION
# ifnull(value1,value2)-it takes 2 argument only.
# coalesce(value1,value2...valueN)-- it takes n no.of argument.
# both funcn return first non null value.
# use for null substitution.

select ifnull(null,1);
select coalesce(null,1);

select ifnull(null,null,1); #it will throw error
select coalesce(null,null,null,null,1);

select customername,city,state,country from customers;
select customername,city,ifnull(state,"N/A")as state,country from customers;
select customername,city,coalesce(state,"N/A")as state,country from customers;

select customername,city,coalesce(state,country)as state,country from customers;

select customername,city,state,country from customers
order by ifnull(state,country) asc;

# wasq to fetch productname,total no of items sold per order
# and tov of each productline of year 2004?

select productname,sum(quantityordered)as tiso,sum(quantityordered*priceeach)as tov,
productline from products inner join orderdetails using(productcode) inner join 
orders using(ordernumber)
where year(orderdate)=2004
group by productname,productline;