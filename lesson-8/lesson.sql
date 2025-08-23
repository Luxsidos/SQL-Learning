create database class8
go
use class8

Create Table tblProductSales(
 SalesAgent nvarchar(50), SalesCountry nvarchar(50),
 SalesAmount int)
Insert into tblProductSales values('Tom', 'UK', 200)
Insert into tblProductSales values('John', 'US', 180)Insert into tblProductSales values('John', 'UK', 260)
Insert into tblProductSales values('David', 'India', 450)Insert into tblProductSales values('Tom', 'India', 350)
Insert into tblProductSales values('David', 'US', 200)Insert into tblProductSales values('Tom', 'US', 130)
Insert into tblProductSales values('John', 'India', 540)Insert into tblProductSales values('John', 'UK', 120)
Insert into tblProductSales values('David', 'UK', 220)Insert into tblProductSales values('John', 'UK', 420)
Insert into tblProductSales values('David', 'US', 320)Insert into tblProductSales values('Tom', 'US', 340)
Insert into tblProductSales values('Tom', 'UK', 660)Insert into tblProductSales values('John', 'India', 430)
Insert into tblProductSales values('David', 'India', 230)Insert into tblProductSales values('David', 'India', 280)
Insert into tblProductSales values('Tom', 'UK', 480)Insert into tblProductSales values('John', 'US', 360)
Insert into tblProductSales values('David', 'UK', 140)


select salesAgent [India], [UK], [US] from tblProductSales
PIVOT
(
	SUM(SalesAmount) for SalesCountry in (India, UK, US)
) as pivot_table


--select * from NewSales

--select city, amount from NewSales
--unpivot
--(
--	amount for city in (India, UK, US)
--) as unpvt



create table Sales (Product VARCHAR(50),
    Salesperson VARCHAR(50),
    Month VARCHAR(20),
    SalesAmount INT
);

INSERT INTO Sales 
VALUES
('Laptop', 'Alice', 'January', 5000),
('Laptop', 'Alice', 'February', 7000),
('Laptop', 'Bob', 'January', 3000),
('Laptop', 'Bob', 'February', 2000),
('Tablet', 'Alice', 'January', 4000),
('Tablet', 'Alice', 'February', 3000),
('Tablet', 'Bob', 'January', 3500),
('Tablet', 'Bob', 'February', 4500);


select * from Sales
--select salesAgent [India], [UK], [US] from tblProductSales
--PIVOT
--(
--	SUM(SalesAmount) for SalesCountry in (India, UK, US)
--) as pivot_table


select Product, Salesperson, [January], [February] from Sales
pivot
(
	SUM(SalesAmount) for Month in (January, February)
) as pvtable

Create Table Movie (movie_length int, movie_name nvarchar(25))
Insert Movie values (45, 'Movie1'), (50, 'Movie2'), (76, 'Movie3'), (88, 'Movie4'),
          (122, 'Movie5'), (164, 'Movie6'), (142, 'Movie7'), (120, 'Movie8'), 
          (166, 'Movie9'), (204, 'Movie10')


Select * from Movie

-- 1
select *, 
	case 
		when movie_length < 100 then 'Short'
		when movie_length between 100 and 150 then 'Long'
		else 'Epic'
	end
	from Movie

-- 2
select case 
		when movie_length < 100 then 'Short'
		when movie_length between 100 and 150 then 'Long'
		else 'Epic'
	end, 
	count(case 
		when movie_length < 100 then 'Short'
		when movie_length between 100 and 150 then 'Long'
		else 'Epic'
	end)
	from Movie
group by case 
		when movie_length < 100 then 'Short'
		when movie_length between 100 and 150 then 'Long'
		else 'Epic'
	end




CREATE TABLE bonuses (
    id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    month VARCHAR(7), -- Format: YYYY-MM
    bonus_amount INT
);

INSERT INTO bonuses (id, employee_name, month, bonus_amount) VALUES
(1, 'Ali', '2025-01', 200),
(2, 'Ali', '2025-02', 250),
(3, 'Vali', '2025-01', 100),
(4, 'Vali', '2025-02', 150),
(5, 'Guli', '2025-01', 300),
(6, 'Guli', '2025-02', 350),
(7, 'Guli', '2025-03', 400),
(8, 'Nodira', '2025-02', 100),
(9, 'Nodira', '2025-03', 120);

--2. Eng ko‘p oy bonus olgan xodim(lar):

--3. Har oy berilgan bonuslarning o‘rtachasi:


select * from bonuses

-- 1
select month, max(bonus_amount) as bonus_amount from bonuses
group by month

-- 2
select month, avg(bonus_amount) as bonus_amount from bonuses
group by month

select * from bonuses as a
where bonus_amount = (select max(bonus_amount) from bonuses where a.bonus_amount = bonus_amount)


CREATE TABLE Sales1 (    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(50),    Quantity INT,
    Price DECIMAL(10,2));

INSERT INTO Sales1 (SaleID, ProductName, Quantity, Price) VALUES(1, 'Laptop', 2, 800.00),
(2, 'Phone', 3, 500.00),(3, 'Laptop', 1, 800.00),
(4, 'Tablet', 5, 300.00),(5, 'Phone', 2, 500.00);

/*1. Find Total Sales per Product
Scenario:A store tracks sales data. Find the total sales for each product.
*/

select ProductName, SUM(Price * Quantity) as total_amount from Sales1
group by ProductName

select * from Sales1



CREATE TABLE Sales3 (    SaleID INT,
    ProductName VARCHAR(50),    Category VARCHAR(50),
    Quantity INT,    UnitPrice DECIMAL(10,2),
    SaleDate DATE,    Region VARCHAR(50)
);
INSERT INTO Sales3 (SaleID, ProductName, Category, Quantity, UnitPrice, SaleDate, Region) VALUES
(1, 'iPhone 13', 'Electronics', 2, 999.99, '2025-06-01', 'Tashkent'),(2, 'MacBook Pro', 'Electronics', 1, 1999.99, '2025-06-03', 'Samarkand'),
(3, 'Banana', 'Fruits', 10, 0.50, '2025-06-01', 'Tashkent'),(4, 'Orange', 'Fruits', 5, 0.70, '2025-06-02', 'Andijan'),
(5, 'iPhone 13', 'Electronics', 1, 999.99, '2025-06-04', 'Tashkent'),(6, 'Banana', 'Fruits', 20, 0.45, '2025-06-03', 'Bukhara'),
(7, 'MacBook Pro', 'Electronics', 1, 1999.99, '2025-06-06', 'Tashkent'),(8, 'Orange', 'Fruits', 7, 0.65, '2025-06-07', 'Bukhara'),
(9, 'Banana', 'Fruits', 15, 0.48, '2025-06-08', 'Samarkand');
Select * from Sales3
--Har bir regionda o‘rtacha narxi 0.5 dan katta bo‘lgan mevalarni topish kerak

select region, ProductName, avg(UnitPrice) as UnitPrice from Sales3
where Category = 'Fruits'
group by region, ProductName
having avg(UnitPrice) > 0.5 


select region, ProductName, avg(UnitPrice) as UnitPrice from Sales3
group by region, ProductName, Category
having avg(UnitPrice) > 0.5 and Category = 'Fruits'



