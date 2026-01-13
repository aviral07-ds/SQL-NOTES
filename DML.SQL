# standard insertion method
# single record insertion
# insert into tablename(colname1,colname2,.....colnamwN)
# values (dv1,dv2,....dvN)

insert into stu(stu_id,sname,city,fees,d_o_b,mobile)
values(1,"abc","Bhopal",45000,"2000-10-02","+919329209007");

select * from stu;

# multiple record insertion

insert into stu(stu_id,sname,city,fees,d_o_b,mobile)
values(2,"pqr","Bhopal",45000,"2000-07-14","+919329209008"),
(3,"xyz","Indore",46000,"2000-06-23","+919329209009"),
(4,"def","Bhopal",47000,"2000-07-01","+919329209006");

select * from stu;

# extension method
# insert into tablename
# set colname1= 


insert into stu
set stu_id=5,sname="efg",city="indore",fees=48000,d_o_b="2000-09-10",mobile="+919329209001";

# update
# update tablename set columnname="newdatavalue"
# where primarykeycol1=value;

update stu set sname="decode"
where stu_id=1;

# here we get 1175 error because by default sql_safe_updates=1 par set rehta hai toh hume isko 0 set krna pdega 
# set sql_safe_updates=0; (syntax to fix the error)

set sql_safe_updates=0;

select * from stu;

# delete
# delete from tablename where primarykeycolname1;

delete from stu where stu_id=1;
select * from stu;
rollback;

start transaction;
delete from stu;
rollback;

# truncate 
# truncate table tablename;

truncate table stu;
select * from stu;

# drop table
# drop table tablename;

drop table stu;

# drop database
# drop database databasename;

drop database schooldb1;
