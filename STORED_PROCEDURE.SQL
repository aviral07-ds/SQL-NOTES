# stored procedure
# def:- is a block of queries/statements to perform 
# specific task in a database
# there are 3 types of parameter:-
# in , out , inout

# syntax
# delimeter $$
# create procedure proc_name(in/out/inout parameter name datatype)
# begin
#      statements.....
# end $$
# delimeter ;

# calling --> call proc_name()


# write a stored procedure to get highest products of each
# procutline of each orderyear now take drank
# as first input parameter and p_productline as 2nd input
# parameter, o_year as a 3rd input?

delimiter $$
create procedure highest_product_1
(in drank int,in p_productline varchar(100),in o_year year)
begin
with cte as(
select productname,productline,year(orderdate) as orderyear,sum(quantityordered*priceeach) as productsales,
dense_rank() over(partition by productLine,year(orderdate) order by sum(quantityordered*priceeach) desc)as d_rn 
from products inner join orderdetails using(productcode) inner join orders using(ordernumber)
group by 1,2,3)
select * from cte 
where d_rn<=drank and productline=p_productline and orderyear=o_year ;
end $$
delimiter ;

call highest_product_1(1,"vintage cars",2004);

# wasp that returns ordercount of each customer
# take cnumber as input and total as out parameter ?
delimiter $$
create procedure cust_order(in cnumber int,out total int)
begin
select count(ordernumber) into total
from customers  inner join orders using(customernumber)
where customernumber=cnumber;
end $$
delimiter ;

call cust_order(103,@total);

select if(@total=2,"repeated customer",
         if(@total=3,"frequent customer","loyal customer"))as customertype;
         
# wasp that returns total quantity ordered and tov
# of each productline take p_productline as input parameter
# and two out  parameter 1. tqty 2.tordervalue
delimiter $$
create procedure productline_detail(in p_productline varchar(100),out tqty int,out tordervalue int)
begin
select sum(quantityordered),sum(quantityordered*priceeach) into tqty,tordervalue
from orderdetails inner join products using(productcode)
where productline=p_productline;
end $$
delimiter ;

call productline_detail("vintage cars",@tqty,@tordervalue);
         
select @tqty,@tordervalue;

# wasp to fetch ordercount and tov of each customernumber
# of each year 

delimiter $$
create procedure order_details1(in cnumber int,in oyear year,out toc int,out tordervalue int)
begin
select count(ordernumber),sum(quantityordered*priceeach) into toc,tordervalue
from customers inner join orders using(customernumber)
inner join orderdetails using(ordernumber)
where customernumber=cnumber and year(orderdate)=oyear;
end $$
delimiter ;

call order_details1(103,2003,@toc,@tordervalue);

select @toc,@tordervalue;