use dummy;
# select
select 1+1;
select 10*5;
select now(); # returns current date and time 

select concat("decode"," "," ","bhopal")
as fullname;

# select from
# used to fetch data/records from particular table
#syntax
# select columnlist/*/expression from tablename;

# order of execution
# from-------->select

# wasq(write a sql query) to fetch customername,customernumber from customers table?
select customernumber,customername from customers; 
 
# wasq to fetch empfullname,employeenumber,jobtitle from employees?
select employeenumber,concat(firstname," ",lastname)
as empfullname,jobtitle from employees;

# wasq to fetch ordernumber and their order value from orderdetails?
select ordernumber,productcode,(quantityordered*priceEach)
as ordervalue from orderdetails;

# wasq to fetch customerfullname,city,state,country 
#and the credit limit from customerstable

select concat(contactFirstName," ",contactLastname)as customerfullname,
city,state,country,creditlimit from customers;


# wasq to fetch prodcutname,productline,msrp,buyprice
# from prodcuts table

select productName,productLine,MSRP,buyPrice from products;


# wasq to fetch customernumber,checknumber,amount and
# paymentdate from paymentstable?

select customerNumber,checkNumber,amount,paymentDate from payments;


#wasq to fetch ordernumber,orderdate,shippeddate
#and status from orders table?

select ordernumber,orderdate,shippeddate,status from orders;

#wasq to fetch ordernumber,orderlinenumber,quantityordered 
# and ordervalue from orderdetails table?

select ordernumber,orderlinenumber,quantityordered,(quantityordered*priceeach)
as ordervalue from orderdetails;