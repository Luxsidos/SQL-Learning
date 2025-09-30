create database class23
go
use class23


-- Puzzle 1
/* 
Write a stored procedure named usp_IncreaseSalary that:
Takes two input parameters:
@empid → Employee ID
@percent → percentage increase
Updates the salary of the given employee by adding the specified percentage.
Returns the updated employee record (EmployeeID, Name, Salary). 
*/

--create statement 

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL
);

-- Insert sample data
INSERT INTO Employees (EmployeeID, Name, Department, Salary) VALUES
(1, 'Alice', 'IT', 6000.00),
(2, 'Bob', 'HR', 4000.00),
(3, 'Charlie', 'Finance', 7500.00),
(4, 'Diana', 'IT', 8200.00),
(5, 'Eve', 'HR', 5000.00);


alter procedure usp_IncreaseSalary @empid int, @percent decimal(10, 2)
as
begin

	update Employees
	set Salary = Salary + (Salary * (@percent / 100))
	where @empid = EmployeeID

	select * from Employees
end;

select * from Employees;

exec usp_IncreaseSalary 1, 50

--Puzzle 2
/*
Find managers with at least five direct reports
*/


--create statement 


CREATE TABLE Employee (id INT, name VARCHAR(255), department VARCHAR(255), managerId INT);
TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES
(101, 'John', 'A', NULL), (102, 'Dan', 'A', 101), (103, 'James', 'A', 101),
(104, 'Amy', 'A', 101), (105, 'Anne', 'A', 101), (106, 'Ron', 'B', 101)

select e.name
from Employee e left join Employee m
on e.id = m.managerId
group by e.name
having count(e.name) >= 5

--expected output

/*
+------+
| name |
+------+
| John |
+------+
*/


--Puzzle 3

/*
 Find Employees with Minimum Salary for each department ID. Show the result in 2 ways
 */


--create statement


drop table Employees

CREATE TABLE employees (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10, 2),
	departmentID int
);

INSERT INTO employees (id, name, salary, departmentID) VALUES
(1, 'Alice', 50000, 1),
(2, 'Bob', 60000, 1),
(3, 'Charlie', 50000, 2),
(4, 'Tom', 32000, 2),
(5, 'Alex', 40000, 3);

select * from employees

-- 1
;with cte_emp as (
	select *, ROW_NUMBER() 
	over (partition by departmentID order by salary) as rn
	from employees
)	
select name, salary from cte_emp
where rn = 1;

-- 2
select * from employees
where id in (
select departmentID
from (select departmentID, min(salary) as salary from employees
group by departmentID) as minSalaries )


--expected output

/*
id	name	salary	departmentID
1	Alice	50000.00	1
4	Tom		32000.00	2
5	Alex	40000.00	3
*/


--Puzzle 4

 /*
 Find the largest single number. If there is no single number, report null.
 */

 --create statement

CREATE TABLE MyNumbers (
    num INT
);

INSERT INTO MyNumbers (num) VALUES
(8),
(8),
(3),
(3),
(1),
(4),
(5),
(6);

select * from MyNumbers;

with cte
as (
select *,
	row_number() over (order by num desc) as rn,
	num - row_number() over (order by num desc) rnc
	from MyNumbers
) 
select num from cte
where rn = rnc

-- expected output

/*
+-----+
| num |
+-----+
| 6   |
+-----+
*/


--Puzzle 5

/*
Using ingredients in my fridge, I want to see which food I can cook
*/

--create statement

-- Create Recipe table
CREATE TABLE Recipe (
    FoodName VARCHAR(20),
    Ingredient_ID INT,
    Ingredient VARCHAR(20)
);

-- Create Fridge table
CREATE TABLE Fridge (
    Ingredient_ID INT,
    IngredientName VARCHAR(20)
);

-- Insert into Recipe
INSERT INTO Recipe VALUES
('HOTDOG', 1, 'SAUSAGE'),
('HOTDOG', 2, 'BREAD'),
('PILOV', 3, 'RICE'),
('PILOV', 4, 'CARROT'),
('PILOV', 5, 'MEAT'),
('PIZZA', 6, 'FLOUR'),
('PIZZA', 7, 'TOMATO'),
('PIZZA', 7, 'CHEESE');

-- Insert into Fridge
INSERT INTO Fridge VALUES
(1, 'SAUSAGE'),
(2, 'BREAD'),
(3, 'RICE'),
(4, 'CARROT'),
(6, 'FLOUR');

--expected output

/*
Foodname
HOTDOG
*/

select * from Recipe
select * from Fridge

select r.FoodName
from Recipe r left join Fridge f
on r.Ingredient_ID = f.Ingredient_ID
group by r.FoodName
having count(r.Ingredient) = COUNT(f.IngredientName)

