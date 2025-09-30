create database class17
go
use class17;

CREATE TABLE Employees (
    EmpID INT,
    EmpName VARCHAR(50),
    Salary DECIMAL(10,2),
    Bonus DECIMAL(10,2)
);

INSERT INTO Employees VALUES
(1, 'Ali Valiyev', 1200, 200),
(2, 'Dilnoza Karimova', 1500, 300),
(3, 'Jasur Umarov', 900, 150),
(4, 'Aziza Azizova', 2000, 500);


select 
	PARSENAME(REPLACE(EmpName, ' ', '.'), 2),
	PARSENAME(REPLACE(EmpName, ' ', '.'), 1)
from Employees

select 
	SUBSTRING(EmpName, 0, CHARINDEX(' ', EmpName)),
	SUBSTRING(EmpName, 0, CHARINDEX(' ', EmpName))
	from Employees;

with cte_emp as (
	select *, (Salary + Bonus) as TotalInCome from Employees
)
select 
	EmpName, 
	TotalInCome, 
	concat(EmpName, ' earns ',  TotalInCome, ' USD') as Info
from cte_emp

CREATE TABLE Orders (
    OrderID INT,
    Customer VARCHAR(50),
    OrderDate DATE,
    Amount DECIMAL(10,2)
);

INSERT INTO Orders VALUES
(1, 'Ali', '2025-01-10', 300),
(2, 'Aziza', '2025-02-15', 500),
(3, 'Dilnoza', '2025-02-20', 700),
(4, 'Jasur', '2025-03-05', 200);

select *, DATENAME(WEEKDAY, OrderDate) as DayOnWeek from Orders;

with cte_order as (
	select OrderDate, sum(Amount) as TotalAmount from Orders
	where Year(OrderDate
) = 2025 and month(OrderDate) = 2
group by OrderDate)
select sum(TotalAmount) as totalAmount from cte_order

select sum(Amount) as TotalAmount from Orders
	where Year(OrderDate) = 2025 and month(OrderDate) = 2

drop table Orders

INSERT INTO Orders VALUES
(101, 1, 300),
(102, 1, 200),
(103, 2, 500),
(104, 4, 150);

select * from Orders

select * from Customers



select max(Amount) as maxAmount
from Orders o join Customers c
on o.CustID = c.CustID

select * from Customers c
where c.CustID =
(
	select CustID
	from Orders
	where Amount = (select max(Amount) from Orders)
)

CREATE TABLE Customers (
    CustID INT,
    CustName VARCHAR(50),
    City VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT,
    CustID INT,
    Amount DECIMAL(10,2)
);

INSERT INTO Customers VALUES
(1, 'Ali', 'Tashkent'),
(2, 'Aziza', 'Samarkand'),
(3, 'Dilnoza', 'Bukhara'),
(4, 'Jasur', 'Tashkent');

INSERT INTO Orders VALUES
(101, 1, 300),
(102, 1, 200),
(103, 2, 500),
(104, 4, 150),
(105, 4, 700);

select * from Customers
select * from Orders

select c.CustName, max(o.Amount) as MaxOrder
from Customers c join Orders o
on c.CustID = o.CustID
where Amount > (select avg(Amount) from Orders) 
group by c.CustName


--O‘rtacha buyurtma summasidan yuqori buyurtma
--qilgan mijozlarning eng katta buyurtma summasini toping.


CREATE TABLE Sales (
    SaleID INT,
    Staff VARCHAR(50),
    Quantity INT
);

INSERT INTO Sales VALUES
(1, 'Ali', 10),
(2, 'Ali', 20),
(3, 'Aziza', 15),
(4, 'Dilnoza', 25),
(5, 'Jasur', 30);

select * from Sales

select Staff, sum(Quantity) as totalQuantity
from Sales
group by Staff

;with numbers as (
	select 10 as n
	union all
	select n + 1 from numbers
	where n < 95
)select * from numbers;

drop table orders

CREATE TABLE Orders (
    OrderID INT,
    Customer VARCHAR(50),
    City VARCHAR(50),
    Amount DECIMAL(10,2)
);

INSERT INTO Orders VALUES
(1, 'Ali', 'Tashkent', 300),
(2, 'Ali', 'Tashkent', 200),
(3, 'Aziza', 'Samarkand', 500),
(4, 'Aziza', 'Samarkand', 400),
(5, 'Dilnoza', 'Bukhara', 100),
(6, 'Dilnoza', 'Bukhara', 50),
(7, 'Jasur', 'Tashkent', 700),
(8, 'Jasur', 'Tashkent', 150);


select * from Orders;


with grandOrders as (
	select City, Customer, avg(Amount) as maxAmount
	from Orders
	group by City, Customer
), 
maxOrders as (
select City, max(Amount) as maximum
from Orders
group by City
)
select *
from maxOrders m cross join grandOrders g
where m.City = g.City



