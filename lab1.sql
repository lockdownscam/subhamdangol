#1.	Create a database named dbemp and switch to it.
create database dbemp1;
use dbemp1;
#2.	Create an employee table with appropriate data 
#types and constraints for employee details.
Create table employee (
	EmployeeID varchar(10),
    FirstName varchar(20),
    LastName varchar(20),
    Gender char(1),
    DateofBirth date,
    Designation varchar(20),
    DepartmentName varchar(20),
    ManagerId varchar(10),
    JoinedDate date,
    Salary decimal(10,0)
);
#3.	Insert at least two employee records into the employee table.
Insert into employee(
EmployeeID ,FirstName ,LastName ,Gender ,DateofBirth ,
Designation ,DepartmentName ,ManagerId ,JoinedDate ,Salary 
) values(
'001','Season','Maharjan','M','1996-04-02','Engineer',
'Software engineering','','2022-11-02','5000000000'
),(
'003','Srijana','Maharjan','F','2000-04-02','Manager',
'Software engineering','005','2025-11-02','9000000');
select * from employee;

#4. update the gender of an employee
#EmployeeID is 003
update employee
set Gender = 'M'
where EmployeeID = '003' ;
#5 Display the first name, current date, 
#date of birth, and age of 
#employees who are older than 30 years
select FirstName,
curdate() as CurrentDate,DateofBirth,
timestampdiff(Year,Dateofbirth,CURDATE()) as age
from employee
where
timestampdiff(Year,Dateofbirth,CURDATE()) >20;
#6 Write a query to find the oldest employee
select * from employee
where DateofBirth =
(select Min(DateofBirth) from employee);
#7 Write a query to find the youngest employee
select * from employee
where DateofBirth =
(select max(DateofBirth) from employee);
#8 display maximum salary from department wise
select DepartmentName, max(Salary) as MaxSalary
from employee group by  DepartmentName;
#8 display minimum salary from department wise
select DepartmentName, min(Salary) as MinSalary
from employee group by  DepartmentName;
#10 list the employee who act as managers
select * from employee where
EmployeeID in (select ManagerID from employee);

#update employee set


#delete from employee where  

select * from employee
where FirstName Like 's%';
select * from employee
where FirstName Like '%n';

select orders.orderId,
customer.customerId, orders.ordersdate
from orders, customer
where orders.customerId = customer.customerId;