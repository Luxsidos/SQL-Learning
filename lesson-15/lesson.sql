create database class15
go
use class15

select
	GETDATE(),
	YEAR(GETDATE()),
	MONTH(GETDATE()),
	DAY(GETDATE())

SELECT
	DATEADD(YEAR, 5, GETDATE()),
	DATEADD(MONTH, 2, GETDATE()),
	DATEADD(DAY, 8, GETDATE())

SELECT 
	DATENAME(MONTH, GETDATE()),
	DATENAME(WEEKDAY, GETDATE()),
	DATEPART(WEEKDAY, GETDATE()),
	DATENAME(DAY, GETDATE())

SELECT 
	DATEDIFF(MONTH, '2025-07-01', GETDATE()),
	DATEDIFF(DAY, '2025-07-01', GETDATE())



--DAY(), MONTH(), YEAR()

--Sana bo‘yicha faqat kun, oy yoki yil qismini qaytaradi.

--SELECT 
--    GETDATE() AS BugungiSana,
--    DAY(GETDATE()) AS FaqatKun,
--    MONTH(GETDATE()) AS FaqatOy,
--    YEAR(GETDATE()) AS FaqatYil;


--DATEADD()

--Sanaga qo‘shimcha vaqt qo‘shadi (yil, oy, kun, soat, daqiqa...).

--SELECT 
--    GETDATE() AS Bugun,
--    DATEADD(DAY, 5, GETDATE()) AS [5KunQoshildi],
--    DATEADD(MONTH, 2, GETDATE()) AS [2OyQoshildi],
--    DATEADD(YEAR, -1, GETDATE()) AS [1YilOldin];


--DATEDIFF()

--Ikki sana orasidagi farqni hisoblaydi.


--SELECT 
--    DATEDIFF(DAY, '2025-01-01', GETDATE()) AS KunFarqi,
--    DATEDIFF(MONTH, '2025-01-01', GETDATE()) AS OyFarqi,
--    DATEDIFF(YEAR, '2000-01-01', GETDATE()) AS YilFarqi;



--DATENAME(), DATEPART()

--DATEPART() → Sana qismini raqam shaklida qaytaradi.

--DATENAME() → Sana qismini matn (string) shaklida qaytaradi.


--SELECT 
--    DATEPART(MONTH, GETDATE()) AS OyRaqam,
--    DATENAME(MONTH, GETDATE()) AS OyNomi,
--    DATEPART(WEEKDAY, GETDATE()) AS HaftakunRaqam,
--    DATENAME(WEEKDAY, GETDATE()) AS HaftakunNomi;



--🔹 GETDATE(), GETUTCDATE(), SYSDATETIME(), CURRENT_TIMESTAMP

--GETDATE() → Hozirgi sana/vaqt (server vaqt zonasiga qarab).

--GETUTCDATE() → UTC (London GMT+0) bo‘yicha sana/vaqt.

--SYSDATETIME() → Aniqlik yuqori (nanosecondgacha).

--CURRENT_TIMESTAMP → GETDATE() bilan bir xil.

--SELECT 
--    GETDATE() AS ServerVaqti,
--    GETUTCDATE() AS UTC_Vaqt,
--    SYSDATETIME() AS AniqlikBaland,
--    CURRENT_TIMESTAMP AS Hozir;



--CREATE TABLE Orders (
--    OrderID INT,
--    CustomerName VARCHAR(50),
--    OrderDate DATETIME
--);

--INSERT INTO Orders VALUES
--(1, 'Ali', '2025-01-15'),
--(2, 'Vali', '2025-03-10'),
--(3, 'Hasan', '2025-07-25'),
--(4, 'Husan', GETDATE());  -- hozirgi sana

--select * from Orders

--SELECT 
--    OrderID, CustomerName, OrderDate,
--    YEAR(OrderDate) AS Yil,
--    MONTH(OrderDate) AS Oy,
--    DAY(OrderDate) AS Kun
--FROM Orders;

--SELECT 
--    OrderID, CustomerName, OrderDate,
--    DATEADD(DAY, 7, OrderDate) AS YetkazibBerishSana
--FROM Orders;



--SELECT 
--    OrderID, CustomerName, OrderDate,
--    DATEDIFF(DAY, OrderDate, GETDATE()) AS  OtganKunlar
--FROM Orders;


CREATE TABLE Employees (
    EmpID INT,
    EmpName NVARCHAR(50),
    HireDate DATE,
    BirthDate DATE
);

INSERT INTO Employees VALUES
(1, 'Ali Valiyev', '2020-05-10', '1995-03-15'),
(2, 'Dilshod Karimov', '2018-11-20', '1990-12-05'),
(3, 'Aziza Rustamova', '2022-01-15', '1998-07-30'),
(4, 'Hasan Usmonov', '2015-09-01', '1985-04-10');

SELECT * FROM Employees

SELECT *, YEAR(BirthDate) AS Birthday FROM Employees


SELECT *, YEAR(GETDATE()) - YEAR(HireDate) AS Birthday FROM Employees

SELECT DATEDIFF(DAY, HireDate, '2025-12-31') FROM Employees

SELECT DATEDIFF(DAY, GETDATE(), '2025-12-31')

select *, datename(MONTH, BirthDate) as monthName from Employees

select *, 
	DATEADD(YEAR, 1, HireDate) as nextYear,
	DATEADD(day, 10000, BirthDate) as tenthousandDay
	from Employees




select reverse('hello world')


select reverse ('Hello world'), reverse('bye world')

select trim(' Data Science '), LTRIM(rtrim(' Data Science '))


select left('ChatGPT', 4), right('ChatGPT', 3), substring('ChatGPT', 3, 3)

CREATE TABLE Students (ID INT, FullName VARCHAR(50));
INSERT INTO Students VALUES
(1, 'Ali Valiyev'),
(2, 'Dilshod Karimov'),
(3, 'Aziza Rustamova');


select ID, upper(FullName) as UpperFullName from Students

select CHARINDEX('stan', 'Uzbekistan')

select ABS(-21)

select 
	FLOOR(21.8), 
	CEILING(21.2)

select POWER(3, 3)

select sqrt(144)
select SQUARE(3)


CREATE TABLE Products (
    ProductID INT,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(1, 'Laptop', 1200.50),
(2, 'Mouse', 25.75),
(3, 'Keyboard', 45.00),
(4, 'Monitor', 300.99);

select ProductName, 
	CEILING(Price), 
	FLOOR(Price) 
	from Products

SELECT QUOTENAME(MONTH(GETDATE()))

select ProductName,
	Price,
	Price * .9 AS discounted
	from Products

select datepart