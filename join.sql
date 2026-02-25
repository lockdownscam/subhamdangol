create database COMPANYDB;
use COMPANYDB;
create table DEPARTMENT(
DNAME varchar(20),
DNUMBER int primary key,
MGRSSN varchar(15),
MGRSTARTDATE date
);
create table EMPLOYEE(
FNAME varchar(20),
MINIT char(1),
LNAME varchar(15),
SSN varchar(15) primary key,
BDATE date,
ADDRESS varchar(100),
SEX char(1),
SALARY int,
DNO int,
foreign key(DNO)
references DEPARTMENT(DNUMBER)
);
INSERT INTO DEPARTMENT VALUES
('Human Resources', 1, '123456789', '2022-01-15'),
('Finance', 2, '987654321', '2021-06-01'),
('IT', 3, '456789123', '2023-03-10');
INSERT INTO EMPLOYEE VALUES
('John', 'A', 'Smith', '1001', '1995-03-15', 'New York', 'M', 50000, 1),
('Sarah', 'B', 'Johnson', '1002', '1998-07-22', 'California', 'F', 60000, 2),
('Michael', 'C', 'Brown', '1003', '1992-11-10', 'Texas', 'M', 55000, 3),
('Emily', 'D', 'Davis', '1004', '1996-05-18', 'Florida', 'F', 52000, 1),
('Daniel', 'E', 'Wilson', '1005', '1994-09-30', 'Nevada', 'M', 58000, 2),
('Olivia', 'F', 'Taylor', '1006', '1999-12-12', 'Ohio', 'F', 61000, 3),
('James', 'G', 'Anderson', '1007', '1993-04-25', 'Arizona', 'M', 57000, 1),
('Sophia', 'H', 'Thomas', '1008', '1997-08-14', 'Washington', 'F', 59000, 2);
select*from DEPARTMENT;
select*from EMPLOYEE;
#q1. 10% salary raise for resource department
SELECT E.FNAME, E.LNAME, E.SALARY * 1.1 as increased_salary
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DNO = D.DNUMBER
where D.DNAME = 'Human Resources';
#q2. salary statistics of finance department
#sum, max, min, avg, for department administratic
SELECT
sum(E.SALARY) as Total,
max(E.SALARY)as max,
min(E.SALARY)as min,
avg(E.SALARY) as average
FROM EMPLOYEE E
JOIN DEPARTMENT D ON E.DNO = D.DNUMBER
where D.DNAME = 'Finance';
#q3 employee controlled by department no 1
SELECT E.FNAME, E.LNAME FROM EMPLOYEE E
where exists(select*from EMPLOYEE e
where e.DNO=1 and E.SSN=e.SSN);
#q4 Departments having at least 2 employees
SELECT D.DNAME, COUNT(E.SSN) AS total_employees
FROM DEPARTMENT D
JOIN EMPLOYEE E ON D.DNUMBER = E.DNO
GROUP BY D.DNUMBER, D.DNAME
HAVING COUNT(E.SSN) >= 2;
#q5 employee born in 1990-1995
select*from EMPLOYEE
WHERE year(BDATE) BETWEEN '1990-01-01' AND '1995-12-31';