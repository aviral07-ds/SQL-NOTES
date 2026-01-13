# QUESTION 1

create database office;
use office;

# QUESTION 2

create table employees(emp_id int,empname varchar(50),salary decimal(10,2),
city varchar(30),d_o_j date) ;

# QUESTION 3

alter table employees add column mobile varchar(20);

# QUESTION 4

alter table employees drop column city;

# QUESTION 5

alter table employees rename column emp_id to eid;

# QUESTION 6

alter table employees modify column eid tinyint;

# QUESTION 7
# STANDARD METHOD
insert into employees 
values(1,"Aviral",100000,"2028-07-10","+919329209007"),
(2,"Sumantra",100000,"2028-07-11","+919329209008");

# EXTENSION METHOD
insert into employees
set eid=3,empname="Aditya",salary=50000,d_o_j="2028-07-12",mobile="+919329209009";

# QUESTION 8

set sql_safe_updates=0;
update employees set salary=60000
where eid=3;

select * from employees;

# QUESTION 9

start transaction;
delete from employees;
rollback;

delete from employees where eid=1;

# QUESTION 10
select * from employees;

# QUESTION 11
rename table employees to emp;

# QUESTION 12

truncate table emp;
select * from emp;
drop table emp;
drop database office;

# END .....