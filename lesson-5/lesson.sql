create database f38_class5

use F38_class5

CREATE TABLE employees_2024 (
    name VARCHAR(50)
);

CREATE TABLE employees_2025 (
    name VARCHAR(50)
);

INSERT INTO employees_2024 VALUES
('John'), ('Alice'), ('Mike');

INSERT INTO employees_2025 VALUES
('Alice'), ('Sara'), ('Tom');


select * from employees_2024
select * from employees_2025

select * from employees_2024
union
select * from employees_2025

select * from employees_2024
union all
select * from employees_2025


-- intersect and except

select * from employees_2024
intersect
select * from employees_2025

select * from employees_2024
except
select * from employees_2025


select * from employees_2025
except
select * from employees_2024


-- 1️⃣ Create first table
CREATE TABLE Employees2024 (
    EmpID INT,
    EmpName VARCHAR(50)
);

-- 2️⃣ Create second table
CREATE TABLE Employees2025 (
    EmpID INT,
    EmpName VARCHAR(50)
);

-- 3️⃣ Insert data into Employees2024
INSERT INTO Employees2024 (EmpID, EmpName) VALUES
(101, 'Michael'),
(102, 'Sara'),
(103, 'Tom'),
(104, 'Linda');

-- 4️⃣ Insert data into Employees2025
INSERT INTO Employees2025 (EmpID, EmpName) VALUES
(103, 'Tom'),
(104, 'Linda'),
(105, 'Robert'),
(106, 'Emma');

select * from Employees2025
select * from Employees2024

select * from Employees2025
intersect
select * from Employees2024

select * from Employees2025


select * from Employees2025
except
select * from Employees2024

CREATE TABLE emp_salary (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    salary INT
);


INSERT INTO emp_salary VALUES
(1, 'John', 20000),
(2, 'Alice', 35000),
(3, 'Mike', 55000),
(4, 'Sara', 65000),
(5, 'Tom', 40000);

-- case and iif
select *,
	case
		when salary > 50000 then 'High'
		when salary > 40000 then 'Medium'
		else 'Low'
	end as SalaryLevel
from emp_salary

select *, IIF(salary > 50000, 'HIGH', IIF(salary > 30000, 'Medium', 'Low')) as SalaryLevel
from emp_salary


CREATE TABLE numbers (
    number INT
);

-- Ma'lumot kiritish
INSERT INTO numbers VALUES
(2),
(3),
(6),
(8),
(9),
(12),
(15);

select *,
	case 
		when (number % 6) = 0 then 'HI BYE'
		when (number % 2) = 0 then 'BYE'
		when (number % 3) = 0 then 'HI'
		else null
	end as NumberSTATUS
	from numbers

use f38_class5

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10, 2)
);
INSERT INTO employees (id, name, department, salary) VALUES
(1, 'John', 'IT', 1500),
(2, 'Bob', 'IT', 1700),
(3, 'Alice', 'HR', 1200),
(4, 'Sam', 'Finance', 2000),
(5, 'Eva', 'Finance', 2100),
(6, 'Mike', 'IT', 1600),
(7, 'Sophia', 'HR', 1300);

select department, avg(salary), count(department) from employees
group by department