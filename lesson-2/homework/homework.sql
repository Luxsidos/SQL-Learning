
-- 1
create table Employees (EmpID int, Name VARCHAR(50), Salary Decimal(10, 2));

-- 2
insert into Employees values 
(1, 'John', 1200.50),
(2, 'Arthur', 1400.20),
(3, 'Micah', 1240.10);

-- 3
update Employees 
set Salary = 7000
where EmpID = 1

-- 4
delete Employees
where EmpID = 2

-- 5
--DELETE
--Removes specific rows (use WHERE).
--Can be rolled back.
--Table stays.

--DELETE FROM Users WHERE Age < 18;

--TRUNCATE
--Removes all rows (no WHERE).
--Faster, usually can’t rollback.
--Table stays.

--TRUNCATE TABLE Users;

--DROP
--Deletes the whole table (structure + data).
--Cannot rollback.

--DROP TABLE Users;


-- 6
alter table Employees alter column Name Varchar(100)

-- 7
alter table Employees add Department Varchar(50)

-- 8
alter table Employees alter column Salary FLOAT

-- 9
create table Departments (DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50))

-- 10
TRUNCATE TABLE Employees

-- 11
INSERT INTO Departments (DepartmentID, DepartmentName)
Select 1, 'HR' union all
select 2, 'Finance' union all
select 3, 'IT' union all
select 4, 'Marketing' union all
select 5, 'call center';

-- 12
update Employees 
set Department = 'Management'
where Salary > 5000

-- 13
Truncate table Employees

-- 14
alter table Employees
drop column Department

-- 15
exec sp_rename 'Employees', 'StaffMembers';

-- 16
drop table Departments

-- 17
create table Products
(	
	ProductID int primary key,
	ProductName Varchar(50),
	Category Varchar(50),
	Price Decimal(10, 2),
)

-- 18
alter table products
add constraint ch_price_positive check (price > 0)

-- 19
Alter table Products
add StockQuantity int constraint DF_StockQuantity_Default DEFAULT 50;

-- 20
exec sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

-- 21
insert into Products values
(1, 'ASUS', 'Laptop', 1200.00, 2),
(2, 'iPhone 14', 'Phone', 700.00, 4),
(3, 'Playstation 5', 'Console', 400.00, 1),
(4, 'Apple TV', 'TV', 2000.00, 2),
(5, 'Lenovo', 'Laptop', 700.00, 5);

-- 22
select * into Products_Backup from Products

-- 23
exec sp_rename 'Products', 'Inventory';

-- 24
ALTER TABLE Inventory
DROP CONSTRAINT ch_price_positive;

alter table Inventory 
alter column Price FLOAT

ALTER TABLE Inventory
ADD CONSTRAINT ch_price_positive CHECK (Price > 0);

-- 25
alter table Inventory
add ProductCode int identity(1000, 5) 