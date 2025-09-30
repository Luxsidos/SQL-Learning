create database class20
go
use class20

create table employee(id int identity,name varchar(100),Salary int,departmentID int)

insert into employee values
('r',301,3),('x',302,3),('y',303,3),('t',302,3),
('a',100,1),('b',101,1),('c',102,1),('d',103,1),
('f',200,2),('j',201,2),('h',202,2),('i',203,2),
('k',300,3),('m',301,3),('n',302,3),('k',303,3)

-- row number

select *, ROW_NUMBER()
over (order by salary desc)
from employee


select *, ROW_NUMBER()
over (order by (select null))
from employee

-- partition by (group by)

select *, ROW_NUMBER()
over (partition by departmentID order by salary)
from employee



;with cte_emp as (
	select *, ROW_NUMBER() 
	over (partition by departmentID order by salary) as rn
	from employee
)	
select * from cte_emp
where rn = 2;

select *, rank() over (order by salary desc) as rnk from employee


;with cte_rank as (
	select *, rank() over (partition by departmentID order by salary desc) as rnk from employee	
) select * from cte_rank
where rnk = 2

;with cte_rank as (
	select *, dense_rank() over (partition by departmentID order by salary desc) as rnk from employee	
) select * from cte_rank
where rnk = 2

CREATE TABLE daily_sales (
    sales_date DATE,
    sales_amount DECIMAL(10, 2)
);


INSERT INTO daily_sales (sales_date, sales_amount)
VALUES 
('2024-09-25', 1000.00),
('2024-09-26', 1500.00),
('2024-09-27', 1200.00),
('2024-09-28', 1800.00),
('2024-09-29', 1300.00);

select * from daily_sales

select *,
	lag(sales_amount) over (order by sales_amount) from daily_sales
select *,
	lag(sales_amount) over (order by sales_date) from daily_sales


select *,
	lag(sales_amount, 2, 0) over ( order by sales_amount) from daily_sales

select *,
	lead(sales_amount) over (order by sales_date) from daily_sales

select *, (sales_amount - lag(sales_amount, 1, 0) over (order by sales_date)) / sales_amount * 100
from daily_sales

select *,
	lead(sales_amount, 2, 0) over (order by sales_date) from daily_sales

select * from employee
select departmentID, 
    lead(salary) over (partition by departmentID order by salary) as [lead] from employee
group by departmentID, Salary

CREATE TABLE ntile_demo (
  v INT NOT NULL
);  
INSERT INTO ntile_demo(v) 
VALUES(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(50),
    Score INT
);

INSERT INTO Students (StudentID, StudentName, Score) VALUES
(1, 'Ali', 95),
(2, 'Madina', 88),
(3, 'Javohir', 76),
(4, 'Dilshod', 92),
(5, 'Zarina', 81),
(6, 'Sardor', 67),
(7, 'Malika', 73),
(8, 'Rustam', 85),
(9, 'Aziza', 90),
(10, 'Bekzod', 60),
(11, 'Shahnoza', 78),
(12, 'Ulugbek', 82),
(13, 'Nigora', 69),
(14, 'Jasur', 74),
(15, 'Komila', 87),
(16, 'Oybek', 55),
(17, 'Diyor', 93),
(18, 'Lola', 71),
(19, 'Timur', 65),
(20, 'Sevinch', 80);

select *, ntile(5) over (order by score desc)
from students

drop table Employees

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(100),
    DepartmentID INT,
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, EmployeeName, DepartmentID, Salary) VALUES
(1, 'Alice', 1, 50000),
(2, 'Bob', 1, 60000),
(3, 'Charlie', 2, 55000),
(4, 'David', 2, 70000),
(5, 'Eve', 1, 65000);

use class20

with cte_emp as (
select distinct *, dense_rank() over (partition by departmentID order by salary  )
from employees
