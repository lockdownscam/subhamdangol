create database BankDB;
use BankDB;
create table accounts (
account_id int primary key,
account_holder varchar(100),
balance decimal(10,2)
);
insert into accounts value
(1,'Ram',50000),
(2,'Sita',30000),
(3,'Hari',20000);
#write a transaction that tranfer rs5000 from ram acc to shyam
start transaction;
update accounts
set balance = balance - 5000
where account_id = 1;

update accounts
set balance = balance + 5000
where account_id = 2;
commit;
select * from accounts;


#rollback
start transaction;
update accounts
set balance = balance - 10000
where account_id = 2;

update accounts
set balance = balance + 10000
where account_id = 3;
rollback;

#use of savepoint while updating acc balance
start transaction;
update accounts
set balance = balance - 5000
where account_id = 1;

update accounts
set balance = balance - 2000
where account_id = 1;
savepoint sp1;
update accounts set balance = balance + 2000
where account_id = 2;
rollback to sp1;
commit;


#triggers
create table employees (
emp_id int primary key,
name varchar (100),
salary decimal(10,2)
);

create table salary_log(
log_id int auto_increment primary key,
emp_id int,
old_salary decimal(10,2),
new_salary decimal(10,2),
update_at timestamp default current_timestamp
);
#create a before insert trigger on emp that prevents inserting emp whose sal is less than 10000
delimiter $$
create trigger check_salary
before insert on employees 
for each row
begin
if new.salary < 10000 then
signal sqlstate '45000'
set message_text = "salary must be atleast 10000";
end if;
end$$
delimiter $$;


create trigger log_salary_update
after update on employees
for each row
begin
insert into salary_log(emp_id,old_salary,new_salary)
values (old.emp_id,old.salary,new.salary);
end$$
delimiter $$;

#store procedure
#create a stored procedure that retrieves all records from the employees table

delimiter $$
create procedure getemployees()
begin
select* from employees;
end$$
delimiter $$;
call getemployee();

delimiter $$
create procedure addEmployee(
IN p_id int,
In p_name varchar(100),
In p_salary decimal(10,2)
)
begin
insert into employees values(p_id,p_name,p_salary);
end$$
delimiter $$;
call addEmployee (5,'Shyam',20000);
delimiter $$;

CREATE PROCEDURE update_salary (
    IN empID INT,
    IN newSalary DECIMAL(10,2)
)
BEGIN
    -- Update the salary of the given employee
    UPDATE employees
    SET salary = newSalary
    WHERE emp_id = empID;
END$$

DELIMITER $$ ;

DELIMITER $$
create procedure transferMoney(
in from_account int, in to_account int,
in amount decimal)
begin
start transaction;
update accounts
set balance = balance - amount
 WHERE account_id = from_account;
UPDATE Account
        SET balance = balance + amount
        WHERE account_id = to_account;

        COMMIT;
    
END$$

DELIMITER ;
call transferMoney (1,2,50000);


