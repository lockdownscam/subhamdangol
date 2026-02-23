CREATE DATABASE dep;
USE dep;
create table dept(
Deptno int  primary key,
Dname varchar(20),
Loc varchar(20)
);
select*from dept;
rename table dept to department;
alter table department
add column PINCODE int not null default 0;
alter table department
change Dname Dept_Name varchar(20);
alter table department
modify Loc char(20);
drop table department;