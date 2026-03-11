create database TechSolutionsDB;
use TechSolutionsDB;
create table department (
DeptID int primary key,
DeptName varchar(50) not null,
Location varchar(100)
);
create table employee(
EmpID int primary key,
FirstName varchar(100),
LastName varchar(100),
Gender VARCHAR(10),
Salary int,
HireDate date,
DeptID int,
FOREIGN KEY (DeptID) REFERENCES Department(DeptID)
);
create table project(
ProjectID int primary key,
ProjectName varchar(100),
StartDate date,
EndDate date,
Budget int
);
create table works_on(
EmpID INT,
ProjectID INT,
HoursWorked INT,
PRIMARY KEY (EmpID, ProjectID),
FOREIGN KEY (EmpID) REFERENCES Employee(EmpID),
FOREIGN KEY (ProjectID) REFERENCES Project(ProjectID)
);
INSERT INTO Department VALUES
(1,'Human Resources','New York'),
(2,'IT','San Francisco'),
(3,'Finance','Chicago'),
(4,'Marketing','Boston'),
(5,'Research','Seattle');

INSERT INTO Employee VALUES
(101,'John','Smith','Male',60000,'2020-03-15',2),
(102,'Emma','Johnson','Female',55000,'2019-06-10',1),
(103,'Michael','Brown','Male',70000,'2021-01-05',2),
(104,'Sophia','Davis','Female',65000,'2018-09-20',3),
(105,'Daniel','Wilson','Male',72000,'2022-04-11',5);

INSERT INTO Project VALUES
(201,'Website Development','2023-01-01','2023-06-30',100000),
(202,'Mobile App','2023-02-15','2023-09-30',150000),
(203,'Database Upgrade','2023-03-10','2023-07-20',80000),
(204,'Marketing Campaign','2023-04-01','2023-08-31',50000),
(205,'AI Research','2023-05-01','2024-01-15',200000);

INSERT INTO Works_On VALUES
(101,201,120),
(102,204,80),
(103,202,150),
(104,203,100),
(105,205,200);

UPDATE Employee
SET Salary = Salary * 1.10
WHERE EmpID = 102;

DELETE FROM Project
WHERE ProjectID = 5;

SELECT * 
FROM Employee
WHERE Salary > 60000;

SELECT FirstName, LastName, Salary
FROM Employee
ORDER BY Salary DESC;

SELECT e.FirstName, e.LastName, d.DeptName
FROM Employee e
JOIN Department d ON e.DeptID = d.DeptID
WHERE d.DeptName = 'IT';

SELECT d.DeptName, COUNT(e.EmpID) AS TotalEmployees
FROM Department d
LEFT JOIN Employee e ON d.DeptID = e.DeptID
GROUP BY d.DeptName;

SELECT*
FROM Employee
WHERE HireDate > '2020-09-01';

SELECT e.FirstName, e.LastName, d.DeptName
FROM Employee e
JOIN Department d ON e.DeptID = d.DeptID;

SELECT e.FirstName, e.LastName, p.ProjectName
FROM Employee e
JOIN Works_On w ON e.EmpID = w.EmpID
JOIN Project p ON w.ProjectID = p.ProjectID;

SELECT e.FirstName, e.LastName, p.ProjectName
FROM Employee e
JOIN Works_On w ON e.EmpID = w.EmpID
JOIN Project p ON w.ProjectID = p.ProjectID;

SELECT p.ProjectName, SUM(w.HoursWorked) AS TotalHours
FROM Project p
JOIN Works_On w ON p.ProjectID = w.ProjectID
GROUP BY p.ProjectName;

SELECT d.DeptName, AVG(e.Salary) AS AverageSalary
FROM Department d
JOIN Employee e ON d.DeptID = e.DeptID
GROUP BY d.DeptName;

SELECT d.DeptName, COUNT(e.EmpID) AS TotalEmployees
FROM Department d
JOIN Employee e ON d.DeptID = e.DeptID
GROUP BY d.DeptName
ORDER BY TotalEmployees DESC
LIMIT 1;

SELECT FirstName, LastName, Salary
FROM Employee
WHERE Salary > (SELECT AVG(Salary) FROM Employee);

CREATE VIEW HighSalaryEmployee AS
SELECT *
FROM Employee
WHERE Salary > 60000;

SELECT * FROM HighSalaryEmployee;

CREATE INDEX idx_employee_lastname
ON Employee (LastName);
