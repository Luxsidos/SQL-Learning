create database class7
go
use class7

CREATE TABLE Products (
    ProductID INT,
    ProductName VARCHAR(50),
    Price DECIMAL(10,2)
);

INSERT INTO Products VALUES
(1, 'Olma', 5.00),
(2, 'Banan', 3.50),
(3, 'Gilos', 8.00),
(4, 'Anor', 6.00);

select min(Price) as cheapest from Products
select * from Products
select max(Price) as expesive from Products

select max(ProductName) as first_item from Products
select max(ProductName) as last_item from Products


CREATE TABLE Employees (
    EmpID INT,
    EmpName VARCHAR(50),
    Department VARCHAR(50)
);

INSERT INTO Employees VALUES
(1, 'Ali', 'IT'),
(2, 'Vali', 'HR'),
(3, 'Gul', 'IT'),
(4, 'Sanjar', NULL),
(5, 'Dilnoza', 'HR');

select count(Department) as count_of_department from Employees

select count(*) as all_count from Employees

select count(*) as all_count from Employees

CREATE TABLE SalesData (
    SaleID INT,
    ProductName VARCHAR(50),
    Quantity INT,
    Price DECIMAL(10,2)
);

INSERT INTO SalesData VALUES
(1, 'Olma', 10, 2.50),
(2, 'Banan', 5, 3.00),
(3, 'Olma', 8, 2.50),
(4, 'Gilos', 4, 5.00);

select avg(Price) as AvgPrice from SalesData

select sum(Quantity) as SumQuantity from SalesData

select * from SalesData


select ProductName, SUM(Quantity) as countOfProduct from SalesData
group by ProductName
having sum(Quantity) > 2

CREATE TABLE WeatherData (
    City VARCHAR(50),
    RecordedDate DATE,
    Temperature DECIMAL(5,2)
);

INSERT INTO WeatherData VALUES
('Toshkent', '2025-01-01', -3.5),
('Toshkent', '2025-07-15', 39.2),
('Samarqand', '2025-01-10', -5.1),
('Samarqand', '2025-06-20', 37.5),
('Buxoro', '2025-02-05', 0.0),
('Buxoro', '2025-08-01', 41.0);

--Butun jadval bo‘yicha eng sovuq va eng issiq haroratni toping.

--Har bir shahar bo‘yicha eng issiq kunni toping.

select * from WeatherData

-- 1
select min(Temperature) as Coldest, max(Temperature) as Hotest from WeatherData

-- 2
select City, max(Temperature) as HotestCountry from WeatherData
group by City


CREATE TABLE LibraryBooks (
    BookID INT,
    Title VARCHAR(100),
    Genre VARCHAR(50)
);

INSERT INTO LibraryBooks VALUES
(1, 'O‘tgan kunlar', 'Roman'),
(2, 'Ikki eshik orasi', 'Roman'),
(3, 'Alkimyogar', 'Falsafa'),
(4, 'Sahrodagi oltin', NULL),
(5, 'Shum bola', 'Qissa'),
(6, 'Yulduzli tunlar', 'Roman'),
(7, 'Qorako‘z Majnun', NULL);

select count(Genre) as count_of_genre from LibraryBooks

select count(*) as count_of_books from LibraryBooks

select count(distinct Genre) as count_of_genre from LibraryBooks

select count(Genre) as count_of_roman_genre from LibraryBooks
where genre = 'Roman'


CREATE TABLE AthleteScores (
    AthleteName VARCHAR(50),
    EventName VARCHAR(50),
    Score INT
);

-- Ma’lumot kiritish
INSERT INTO AthleteScores VALUES
('Jasur', '100m yugurish', 15),
('Jasur', 'Uzoqqa sakrash', 8),
('Dilnoza', '100m yugurish', 17),
('Dilnoza', 'Uzoqqa sakrash', 9),
('Aziz', '100m yugurish', 16),
('Aziz', 'Uzoqqa sakrash', 7);

select * from AthleteScores

-- 1
select AthleteName, SUM(Score) as sum_score from AthleteScores
group by AthleteName

-- 2 
select AthleteName, AVG(Score) as avg_score from AthleteScores
group by AthleteName

-- 3
select EventName, SUM(Score) as sum_score from AthleteScores
group by EventName


CREATE TABLE BankTransactions (
    TransactionID INT,
    CustomerName VARCHAR(50),
    Amount DECIMAL(10,2),
    MonthName VARCHAR(20)
);

-- Ma’lumot kiritish
INSERT INTO BankTransactions VALUES
(1, 'Ali', 200000, 'Yanvar'),
(2, 'Ali', 350000, 'Yanvar'),
(3, 'Vali', 100000, 'Yanvar'),
(4, 'Vali', 150000, 'Yanvar'),
(5, 'Dilnoza', 600000, 'Yanvar');

select * from BankTransactions

select CustomerName, SUM(Amount) as SumCount from BankTransactions
group by CustomerName


select CustomerName, SUM(Amount) as SumCount from BankTransactions
group by CustomerName
having SUM(Amount) > 500000
