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


