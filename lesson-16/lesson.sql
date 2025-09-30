create database class16
go 
use class16


CREATE TABLE Movie (
    MovieID INT PRIMARY KEY,
    MovieName VARCHAR(50),
    MovieLength INT
);

INSERT INTO Movie VALUES
(1, 'Movie1', 45),
(2, 'Movie2', 76),
(3, 'Movie3', 122),
(4, 'Movie4', 164),
(5, 'Movie5', 204);

select * from Movie
select FilmLength, count(*) as numberOfFilms
from (
	select 
		case	
			when MovieLength < 100  then 'Short'
			when MovieLength < 150  then 'Medium'
			when MovieLength < 200  then 'Long'
			else 'Epic'
		end as FilmLength
		from Movie
) as newLength
group by FilmLength 



--Film uzunligi bo‘yicha har bir kategoriya ichida eng uzun film nomini topish:
select * from Movie
select FilmLength, max(MovieLength) as maxLength, MovieName
from (
	select 
		case	
			when MovieLength < 100  then 'Short'
			when MovieLength < 150  then 'Medium'
			when MovieLength < 200  then 'Long'
			else 'Epic'
		end as FilmLength, MovieLength, MovieName
		from Movie
) as newLength
group by FilmLength, MovieName
order by maxLength desc

-- common table expression (CTE)

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    StaffID INT,
    OrderDate DATE
);

INSERT INTO Orders VALUES
(1, 1, '2016-02-12'),
(2, 1, '2016-06-25'),
(3, 2, '2016-07-01'),
(4, 2, '2006-03-15'),
(5, 3, '2006-05-20'),
(6, 3, '2006-08-10');

select * from Orders;

with cte_orders as (
	select OrderID, StaffID, OrderDate
	from Orders
	where year(OrderDate) = 2016
)
select * from cte_orders;

with cte_orders as (
	select StaffID, OrderID
	from Orders
	where year(OrderDate) = 2006 and month(OrderDate) <= 6
)
select StaffID, count(OrderID) as TotalOrderId from cte_orders
group by StaffID

select * from Orders


CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    StaffID INT,
    Product VARCHAR(50),
    Quantity INT,
    SaleDate DATE
);

INSERT INTO Sales VALUES
(1, 1, 'Laptop', 2, '2020-01-15'),
(2, 1, 'Mouse', 5, '2020-02-20'),
(3, 2, 'Keyboard', 3, '2020-02-25'),
(4, 2, 'Laptop', 1, '2020-03-05'),
(5, 3, 'Monitor', 4, '2020-04-10'),
(6, 3, 'Laptop', 2, '2020-07-18'),
(7, 1, 'Monitor', 1, '2020-08-12'),
(8, 2, 'Mouse', 6, '2020-09-25');


with cte_orders as (
	select StaffID, sum(Quantity) as TotalSale
	from Sales
)
select StaffID, TotalSale from cte_orders
group by StaffID;
select * from Sales;

--Har bir xodim (StaffID) 
-- nechta mahsulot sotganini toping.


with cte_sales as (
	select 
		StaffID, 
		sum(Quantity) as TotalQuantity
	from Sales
	group by StaffID
),
cte_total as (
	select sum(TotalQuantity) as GrandTotal
	from cte_sales
)
select s.StaffID, s.TotalQuantity, cast(100.0 * s.TotalQuantity / t.grandTotal as Decimal(5, 2)) totalPercent  from cte_sales s
cross join cte_total t
order by s.StaffID;

select * from Sales;

-- 3. Recursive CTE
;with numbers as (
	select 1 as n
	union all
	select n + 1 from numbers
	where n < 10
)
select * from numbers


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    ManagerID INT
);

INSERT INTO Employees VALUES
(1, 'CEO', NULL),
(2, 'Manager1', 1),
(3, 'Manager2', 1),
(4, 'Staff1', 2),
(5, 'Staff2', 2),
(6, 'Staff3', 3);

select * from Employees
;with numbers as (
	select 1 as n
	union all
	select n + 1 from numbers
	where n < 10
)
select * from numbers
;

CREATE TABLE Locations (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(50),
    ParentID INT NULL
);

INSERT INTO Locations (LocationID, LocationName, ParentID) VALUES
(1, 'Toshkent', NULL),       -- Asosiy shahar
(2, 'Chilonzor tumani', 1),  -- Toshkent ichida
(3, 'Yunusobod tumani', 1),  -- Toshkent ichida
(4, 'Navro‘z mahallasi', 2), -- Chilonzor ichida
(5, 'Do‘stlik mahallasi', 2),
(6, 'Bog‘ishamol mahallasi', 3);

select * from Locations;

with childLocation as (
	select LocationID, LocationName, ParentID, 0 as level
	from Locations
	where ParentID is null
	union all
	select l.LocationID, l.LocationName, l.ParentID, c.level + 1
	from Locations l 
	inner join childLocation c on l.ParentID = c.LocationID
)
select * from childLocation;

 with organization as (
	select EmployeeID, Name, ManagerID, 0 as level
	from Employees
	where ManagerID is null
	union all
	select e.EmployeeID, e.Name, e.ManagerID, o.level + 1
	from Employees e inner join organization o
	on e.ManagerID = o.EmployeeID
) select * from organization;
