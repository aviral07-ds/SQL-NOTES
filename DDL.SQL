SHOW DATABASES;

USE SAKILA;

SHOW TABLES;

DESC actor;

# DDL
# CREATE DATABASE databasename

create database schooldb1;
use schooldb1;

# CREATE TABLE WITHOUT CONSTRAINT
# CREATE TABLE tablename(colu1name datatype, colu2name datatype, colu3name datatype,
#......colname datatype);

create table student (
sid int,sname varchar(50),city varchar(50),
fees decimal(10,2),d_o_b date,mobile varchar(20) 
);

desc student;

# rename structure or table
# rename table tableoldname to tablenewname;

rename table student to stu;

# alter
# add column to an existing structure.
# alter table tablename add column columnname datatype;

alter table stu add column pincode varchar(20);
desc stu;

# remove column from an existing structure
# alter table tablename drop column columnname;

alter table stu drop column pincode;

# rename column to an existing structure
# alter table tablename rename column columnoldname to columnnewname;

alter table stu rename column sid to stu_id;

desc stu;

# change datatype in an existing structure
# alter table tablename modify columnname newdatatype;

alter table stu modify stu_id tinyint;

alter table stu modify sname varchar(60);

alter table stu modify fees  decimal(8,2);