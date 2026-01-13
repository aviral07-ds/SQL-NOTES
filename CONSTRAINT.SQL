# table with constraints

create database dd200;
use dd200;

create table emp(empid int primary key,
empname varchar(30) not null,doj date,
city varchar(50) default "bhopal",
age tinyint,mobile varchar(20) unique,check(age>=18));

desc emp;

# remove primary key
# alter table tablename drop primary key;

alter table emp drop primary key;
alter table emp modify empid int;
desc emp;
alter table emp modify empname varchar(30);
alter table emp modify city varchar(50);

# unique 
# alter table tablename drop index/key uniquekeyname;

alter table emp drop key mobile;
desc emp;

# check tabl
# alter table tablename drop constraint checkconstraintname;

alter table emp drop constraint emp_chk_1;

use dd200;
desc emp;

# add primary key
# alter table tablename add primary key(column name);
alter table emp add primary key(empid);

# add not null
# alter table tablename modify columnname datatype not null;
alter table emp modify empname varchar(50) not null;

# add default
# alter table tablename modify columnname datatype default"value";
alter table emp modify city varchar(50) default"bhopal";

# check
# alter table tablename add constraint check(column condition);
alter table emp add constraint check (age>=18);

# unique
# alter table tablename add unique(column name);
alter table emp add unique (mobile);