create database class11
go 
use class11

select * 
from Orders o join Customers c
on o.CustomerID = c.CustomerID

-- Students jadvali
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FullName VARCHAR(50),
    Faculty VARCHAR(50),
    GPA DECIMAL(3,2)
);

INSERT INTO Students VALUES
(1, 'Ali Karimov', 'Computer Science', 3.5),
(2, 'Vali Islomov', 'Mathematics', 2.8),
(3, 'Sami Abdullaev', 'Computer Science', 3.9),
(4, 'Nodira Rustamova', 'Physics', 3.2),
(5, 'Dilshod Tursunov', 'Mathematics', 2.5);

-- Exams jadvali
CREATE TABLE Exams (
    ExamID INT PRIMARY KEY,
    StudentID INT,
    Subject VARCHAR(50),
    Score INT,
    ExamDate DATE
);

INSERT INTO Exams VALUES
(101, 1, 'Algorithms', 90, '2025-06-01'),
(102, 1, 'Databases', 85, '2025-06-15'),
(103, 2, 'Algebra', 60, '2025-06-10'),
(104, 3, 'AI', 95, '2025-06-20'),
(105, 3, 'Data Mining', 88, '2025-07-01'),
(106, 4, 'Quantum Mechanics', 70, '2025-06-05');


--Har bir talabaning so‘nggi imtihonini toping. 
--Agar talabaning GPA’si 3.0 dan past bo‘lsa, OUTER APPLY orqali eng past bahosini ham ko‘rsating.
--Buyurtmasi (imtihoni) bo‘lmagan talabalar ham chiqishi shart.


select * from Exams
select * from Students

select  e.Subject as lastSubject
from Students s
outer apply (
	select top 1 Subject, Score from Exams e
	where s.StudentID = e.StudentID
	order by e.ExamDate 
) e

-- Customers jadvali
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FullName VARCHAR(50),
    City VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, 'Ali Karimov', 'Tashkent'),
(2, 'Vali Islomov', 'Samarkand'),
(3, 'Dilnoza Umarova', 'Bukhara');

-- Orders jadvali
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(50),
    Amount DECIMAL(10,2),
    OrderDate DATE
);

INSERT INTO Orders VALUES
(101, 1, 'Laptop', 1200, '2025-07-01'),
(102, 1, 'Mouse', 25, '2025-07-05'),
(103, 1, 'Keyboard', 80, '2025-07-10'),
(104, 2, 'Phone', 800, '2025-07-03'),
(105, 2, 'Tablet', 300, '2025-07-08'),
(106, 3, 'Printer', 200, '2025-07-15');

select * from Customers
select * from Orders

--Eng katta buyurtmasini (Amount bo‘yicha)

--Eng kichik buyurtmasini (Amount bo‘yicha)
--CROSS APPLY yordamida chiqaring.

select * from Orders
select * from Customers

select 
    c.City,
    MaxOrder.product,
    MaxOrder.Amount,
	minOrder.product,
    minOrder.Amount
from Customers c
cross apply (
	select top 1 PRODUCT, amount from Orders o
	where c.CustomerID = o.CustomerID
	order by amount desc
) maxOrder
cross apply (
	select top 1 PRODUCT, amount from Orders o
	where c.CustomerID = o.CustomerID
	order by amount asc
) minOrder