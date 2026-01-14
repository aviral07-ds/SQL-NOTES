create database lotus;
use lotus;
create table products(pid int primary key,pname varchar(50),price decimal(10,2));
create table users(uid int primary key,uname varchar(50),city varchar(40));

create table orders(oid int primary key,userid int,pid int,foreign key (userid) references users(uid));
desc orders;

# add foreign key to an existing structure
# alter table tablename add foreign key(columnname) 
# references parenttablename(primarykeycolumn);

alter table orders add foreign key(pid) references products(pid);

# alter table tablename drop foreign key foreign key name;
# alter table tablename drop key nonunique key name;

alter table orders drop foreign key orders_ibfk_1;
desc orders;
alter table orders drop key userid;

alter table orders drop foreign key orders_ibfk_2;
alter table orders drop key pid;
desc orders;

alter table orders add foreign key(userid) references users(uid);

insert into users(uid,uname,city)
values(1,"A","X"),(2,"B","X"),(3,"C","Y"),(4,"D","X"),(5,"E","X");

insert into orders(oid,userid,pid)
values(101,1,201);

select * from orders;

insert into orders(oid,userid,pid)
values(102,10,202);
# above query throw error because userid 10
# does not exist in parent table

insert into orders(oid,userid,pid)
values(102,2,202),(103,1,202),(104,3,201),(105,2,203);

delete from users where uid=5;
select * from users;

delete from users where uid=1;
# above query throw error because 
# uid 1 also exist in child table with columnname userid.

alter table orders drop foreign key orders_ibfk_1;
alter table orders drop key userid;

alter table orders add foreign key(userid) references users(uid) on delete set null;

delete from users where uid=1;
select * from users;
select * from orders;

delete from orders where oid=105;

update users set uid=40 where uid=4;
select * from users;

# below query will throw an error.
update users set uid=20 where uid=2;

#fixing the error
alter table orders drop foreign key orders_ibfk_1;
alter table orders drop key userid;

alter table orders add foreign key(userid) references users(uid) on update cascade;
update users set uid=20 where uid=2;
select * from users;
select * from orders;

alter table orders drop foreign key orders_ibfk_1;
alter table orders drop key userid;
alter table orders add foreign key(userid) references users(uid) on delete cascade;
delete from users where uid=20;
select * from users;
select * from orders;

update orders set userid=30 where oid=104;

# PRACTICE 
create database croma;
use croma;

create table department(Did int primary key,Dname varchar(40));
create table employees(empid int primary key,empname varchar(50),Deptid int, foreign key(Deptid) references department(Did));

insert into department
values(1,"HR"),(2,"Sales"),(3,"DA"),(4,"Marketing");

select * from department;

insert into employees
values(101,"A",1),(102,"B",2),(103,"C",1),(104,"D",3),(105,"E",3);
select * from employees;

alter table employees drop foreign key employees_ibfk_1;
alter table employees drop key Deptid;

alter table employees add foreign key(Deptid) references department(Did)
on delete set null on update cascade;

delete from department 
where Did=1;

delete from department
where Did=4;

update department
set Did=20 where Did=2;

select * from department;
select * from employees;

USE croma;

alter table employees drop primary key;
desc employees;

# check
# below query will throw an error because of foreign key constraint
alter table department drop primary key;

# fixing the error
alter table employees drop foreign key employees_ibfk_1;
alter table employees drop key Deptid;
alter table department drop primary key;
desc department;

# task
create table user(uid int primary key , uname varchar(50));
create table address(userid int ,add_line_1 varchar(100) ,add_line_2 varchar(100) ,city varchar(30) not null,state varchar(30) not null,country varchar(20) not null,pincode varchar(20)
,foreign key(userid) references user(uid) on delete set null on update cascade); 

desc address; 
desc user;
