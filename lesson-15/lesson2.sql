CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Grade INT,
    ManagerID INT NULL
);

INSERT INTO Students (StudentID, Name, Department, Grade, ManagerID) VALUES
(1, 'Ali', 'Math', 85, NULL),
(2, 'Vali', 'Math', 70, 1),
(3, 'Gulbahor', 'IT', 90, NULL),
(4, 'Dilshod', 'IT', 60, 3),
(5, 'Aziza', 'Biology', 75, NULL),
(6, 'Sardor', 'Biology', 65, 5);


select Name, Department, Grade from Students s
where grade > 
(select avg(Grade) from Students
where s.Department = Department)

select * from Students

select Name, Department, Grade from Students s
where grade =
(select max(Grade) from Students
where s.Department = Department)



CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);

CREATE TABLE Sales (
    SaleID INT PRIMARY KEY,
    ProductID INT,
    Quantity INT,
    SaleDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Products VALUES
(1, 'Laptop', 'Electronics', 1200.00),
(2, 'Mouse', 'Electronics', 25.00),
(3, 'Book A', 'Books', 10.00),
(4, 'Book B', 'Books', 15.00),
(5, 'Shirt', 'Clothes', 30.00);

INSERT INTO Sales VALUES
(101, 1, 2, '2025-01-01'),
(102, 2, 10, '2025-01-05'),
(103, 3, 50, '2025-01-07'),
(104, 4, 20, '2025-01-08'),
(105, 5, 15, '2025-01-09');

select * from Products
select * from Sales

-- O�rtacha sotuv miqdoridan yuqori sotilgan mahsulotlarni toping.

select ProductName, sum(s.Quantity) as totalSold
from Products p join Sales s
on p.ProductID = s.ProductID
group by p.ProductName
having sum(s.Quantity) > (
  select avg(s2.Quantity)
  from Products p2 join Sales s2
  on p2.ProductID = s2.ProductID
)


CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    Product VARCHAR(50)
);

INSERT INTO Customers VALUES
(1, 'Akmal'),
(2, 'Shahnoza'),
(3, 'Jasur');

INSERT INTO Orders VALUES
(101, 1, 'Laptop'),
(102, 1, 'Mouse'),
(103, 3, 'Phone');

select * from Orders
select * from Customers

select CustomerName from Customers c
where exists (
select 1 from Orders o
where o.CustomerID = c.CustomerID
and o.Product = 'Mouse'
) and not exists (
select 1 from Orders o
where o.CustomerID = c.CustomerID
and o.Product != 'Mouse'
)
 
 drop table Orders
 drop table Customers


CREATE TABLE Customers (
  CustomerID INT PRIMARY KEY,
  CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  OrderDate DATE,
  Amount DECIMAL(10,2)
);

CREATE TABLE Payments (
  PaymentID INT PRIMARY KEY,
  OrderID INT,
  PayDate DATE,
  Amount DECIMAL(10,2)
);

-- Customers
INSERT INTO Customers VALUES
(1,'Ali'), (2,'Nodir'), (3,'Madina'), (4,'Sardor');

-- Orders
INSERT INTO Orders VALUES
(101, 1, '2025-02-05', 200.00),  -- Ali
(102, 1, '2025-03-10', 150.00),  -- Ali
(103, 2, '2025-04-01', 300.00),  -- Nodir
(104, 3, '2025-06-15', 100.00);  -- Madina
-- Sardor hech qanday buyurtma qilmagan

-- Payments
INSERT INTO Payments VALUES
(201, 101, '2025-02-06', 200.00), -- Ali order 101 to�lagan
-- Ali order 102 to�lamagan
(202, 103, '2025-04-02', 300.00); -- Nodir order 103 to�lagan
-- Madina order 104 to�lamagan

select * from Orders
select * from Customers
select * from Payments

select *
from Orders o 
full join Customers c
on o.CustomerID = c.CustomerID
full join Payments p
on p.OrderID = o.OrderID

select * from Customers
select * from Orders
select * from Payments


select CustomerName from Customers c
where  exists (
select 1 from Orders o
where o.CustomerID = c.CustomerID
) and not exists (
	select 1 from Orders o2
	where o2.CustomerID = c.CustomerID
	and not exists (select 1 from Payments p
	where p.OrderID = o2.OrderID
	)
)

drop table Students

CREATE TABLE Students (
  StudentID INT PRIMARY KEY,
  StudentName VARCHAR(100)
);

CREATE TABLE Exams (
  ExamID INT PRIMARY KEY,
  ExamName VARCHAR(100)
);

CREATE TABLE Results (
  ResultID INT PRIMARY KEY,
  StudentID INT,
  ExamID INT,
  Score INT
);

-- Students
INSERT INTO Students VALUES
(1,'Ali'), (2,'Dilshod'), (3,'Madina'), (4,'Sardor');

-- Exams
INSERT INTO Exams VALUES
(101,'Math'), (102,'English'), (103,'Physics');

-- Results
INSERT INTO Results VALUES
(1,1,101,85),   -- Ali Math 85
(2,1,102,90),   -- Ali English 90
-- Dilshod faqat Math topshirgan
(3,2,101,70),
-- Madina barcha 3 ta imtihon topshirgan
(4,3,101,95),
(5,3,102,88),
(6,3,103,76);
-- Sardor umuman imtihon topshirmagan

select * from Students
select * from Exams
select * from Results


select * from Students s
where not exists (
	select 1
	from Exams e
	where not exists (
		select 1 from Results r
		where r.StudentID = s.StudentID and e.ExamID = r.ExamID
	)
)
