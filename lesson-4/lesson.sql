
select top (3) * from [AdventureWorks2022].Sales.Currency

select  * from [AdventureWorks2022].Sales.Currency


select top (3) * from [AdventureWorks2022].Sales.Currency
order by Name desc

select top (3) * from [AdventureWorks2022].Sales.Currency
order by Name asc


select top 2 percent * from [AdventureWorks2022].Sales.Currency
order by Name asc


select * from [AdventureWorks2022].Sales.Currency
order by Name asc
offset 5 rows


select * from [AdventureWorks2022].Sales.Currency
order by Name asc
offset 5 rows fetch next 15 rows only


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50)
);

INSERT INTO Customers (CustomerID, FullName, Country, City)
VALUES
(1, 'Ali Karimov', 'Uzbekistan', 'Tashkent'),
(2, 'John Smith', 'USA', 'New York'),
(3, 'Maria Gomez', 'Spain', 'Madrid'),
(4, 'Sardor Rashidov', 'Uzbekistan', 'Tashkent'),
(5, 'Emma Brown', 'USA', 'Los Angeles'),
(6, 'Olga Ivanova', 'Russia', 'Moscow'),
(7, 'Akmal Qodirov', 'Uzbekistan', 'Samarkand'),
(8, 'Laura Fernandez', 'Spain', 'Barcelona'),
(9, 'James Lee', 'USA', 'New York');


select * from Customers

select distinct country from Customers
select distinct country, city from Customers



CREATE TABLE Contacts (
    ContactID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    MiddleName VARCHAR(50),
    LastName VARCHAR(50)
);
INSERT INTO Contacts (ContactID, FirstName, MiddleName, LastName)
VALUES
(1, NULL, NULL, 'Fayzulloyev'),     -- faqat LastName bor
(2, NULL, 'Fayzullo', 'Karimov'),   -- MiddleName mavjud
(3, 'Fayzullo', NULL, 'Sattorov'),  -- FirstName mavjud
(4, NULL, NULL, NULL),              -- hammasi NULL
(5, 'Jamshid', 'Tursun', 'Aliyev'); -- hammasi mavjud

select ContactID, isnull(FirstName, 'nomalum'), MiddleName from Contacts

select ContactID, coalesce(FirstName, MiddleName, LastName, 'Ism yoq') from Contacts



select * from [AdventureWorks2022].Sales.Currency
where name = 'Afghani'


select top 10 * from [AdventureWorks2022].Sales.Customer
where TerritoryID Between 4 and 10

select top 10 * from [AdventureWorks2022].Sales.Customer
where TerritoryID in (4, 8)

select top 10 * from [AdventureWorks2022].Sales.Customer
where not TerritoryID = 1


CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(30),
    Price DECIMAL(10, 2),
    InStock INT
);
INSERT INTO Products (ProductID, ProductName, Category, Price, InStock)
VALUES
(1, 'Olma', 'Meva', 2.50, 100),
(2, 'Banan', 'Meva', 3.00, 50),
(3, 'Sabzi', 'Sabzavot', 1.20, 200),
(4, 'Kartoshka', 'Sabzavot', 1.00, 0),
(5, 'Non', 'Non mahsuloti', 1.50, 30),
(6, 'Shakar', 'Boshqa', 4.00, 15),
(7, 'Tuz', 'Boshqa', 0.80, 60);

-- 1
select * from Products
where price > 2

-- 2
select * from Products
where not InStock = 0

-- 3
select * from Products
where Category = 'Meva'

-- 4
select * from Products
where Price between 1 and 3

-- 5
select * from Products
where ProductName in ('Non', 'Shakar')



select top 10 * from [AdventureWorks2022].Person.CountryRegion
where name like 'a%'

select top 10 * from [AdventureWorks2022].Person.CountryRegion
where name like '_a%'

select top 10 * from [AdventureWorks2022].Person.CountryRegion
where name like '%n'



select top 10 * from [AdventureWorks2022].Person.CountryRegion
where name like '%\%%' escape '\'


select top 10 * from [AdventureWorks2022].Person.CountryRegion
where name like '%\_%' escape '\'



CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FullName VARCHAR(50),
    Age INT
);

INSERT INTO Students (StudentID, FullName, Age)
VALUES
(1, 'Aziz Akmalov', 20),
(2, 'Dilnoza Karimova', 22),
(3, 'Jasur Bektemirov', 25),
(4, 'Malika Toirova', 27),
(5, 'Otabek Sultonov', 30);

CREATE TABLE Lecturers (
    LecturerID INT PRIMARY KEY,
    FullName VARCHAR(50),
    Age INT
);

INSERT INTO Lecturers (LecturerID, FullName, Age)
VALUES
(1, 'Shavkat Yoqubov', 28),
(2, 'Zaynab Ismoilova', 32),
(3, 'Ilhom Rasulov', 35);


select * from Students
where age > any (select age from Lecturers)

select * from Students
where age < all (select age from Lecturers)


