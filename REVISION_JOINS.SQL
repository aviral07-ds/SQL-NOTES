create database joins10;
use joins10;

create table table1(id int);
desc table1;
create table table2(eid int);
desc table2;

insert into table1(id)
values (1),(1),(1),(2),(3),(null),(null),(null);
select * from table1;

insert into table2(eid)
values (1),(1),(2),(4),(null),(null);
select * from table2;

select count(*) from table1 t1 cross join table2 t2;

select count(*) from table1 t1 inner join table2 t2
on t1.id=t2.eid;

select count(*) from table1 t1 left join table2 t2
on t1.id=t2.eid;

select count(*) from table1 t1 left join table2 t2
on t1.id=t2.eid
where t2.eid is null;

select count(*) from table1 t1 right join table2 t2
on t1.id=t2.eid;

select count(*) from table1 t1 right join table2 t2
on t1.id=t2.eid
where t1.id is null;

select count(*) from table1 t1 left join table2 t2
on t1.id=t2.eid
union all
select count(*) from table1 t1 right join table2 t2
on t1.id=t2.eid
where t1.id is null;

select count(*) from table1 t1 natural join table2 t2;