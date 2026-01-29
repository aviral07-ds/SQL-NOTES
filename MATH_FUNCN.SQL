# MATH FUNCTION
# abs()

select abs(-10);
select abs(10);
select abs(-10.0);

# floor()
select floor(19.9);

# ceil()
select ceil(19.1);

# mod(dividend,divisor)--%
# returns remainder value

select mod(5,2);
select 5%2;
select mod(2,5);
# when the numerator is smaller than denominator
# then the mod of that number is numerator itself


# wasq to fetch ordernumber and the items sold per order
# on the basis of items sold per order create one custom column
# odd or even?

select ordernumber,if(sum(quantityordered)%2=0,'EVEN','ODD')as ispo from
orderdetails
GROUP BY ordernumber;

# wasq to fetch daily sales of each productline
# of 2nd and 3rd quarter of each year
# (fetch year orderdate,dayname,and total sales)

select productline,sum(quantityordered*priceeach)as totalsales,dayname(orderdate)as tday,
year(orderdate) as orderyear from orderdetails
inner join orders using(ordernumber)
inner join products using(productcode)
where quarter(orderdate) in ('2','3')
group by productline,tday,orderyear
order by productline;