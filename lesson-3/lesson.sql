create database F38_class3

use F38_class3

-- Importing from Files, Constraints

-- DQL, DML, DDL, TCL, DCL

-- DQL - SELECT
-- DDL - Create, Drop, Alter, Truncate
-- DML - Insert, Update, Delete, Truncate



-- importing files


--create table Emails
--(
--	id int,
--	first_name varchar(50),
--	last_name varchar(50),
--	email varchar(100),
--	gender char(1),
--	degree_status varchar(50),
--)

create table employees 
(
	EmployeeID int,
	FirstName varchar(50),
	LastName varchar(50),
	Email varchar(100),
	Salary int
)

select * from employees_


create table employees2 
(
	EmployeeID int,
	FirstName varchar(50),
	LastName varchar(50),
	Email varchar(100),
	Salary int
)

bulk insert F38_class3.dbo.employees2
from 'C:\Users\ACER\Desktop\employees_.csv'
with (
	Firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n',
	tablock
)

select * from employees2

-- Constraints
-- Primary key
-- Foreign key
-- identity
-- unique
-- null, not null
-- check constraint

create table sample1 
(
	id int primary key, 
	name varchar(50) not null, 
	phoneNumber int unique, 
	age int check(age > 18)
)

insert into sample1 values 
(
	1234, 'Shohrux', 99492, 19
)

select * from sample1

create table Customer
(
	CustID int Primary key Identity(1, 1),
	name varchar(50) not null,
	phone int
)

create table Orders 
(
	OrderID int primary key identity(2, 2),
	itemName varchar(50) not null,
	CustomerID int foreign key references Customer(CustID)
)

insert into customer values 
('John', 211),
('Arthur', 321),
('Winckle', 432)

insert into Orders values
('Apple', 1),
('Banan', 2),
('Kiwi', 2),
('Cherry', 3)