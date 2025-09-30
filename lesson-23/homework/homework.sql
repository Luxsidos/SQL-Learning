---------------------------------------------------
-- Puzzle 1: Extract month from dt column and append zero to single digit month
---------------------------------------------------
CREATE TABLE Dates (
    Id INT,
    Dt DATETIME
);
INSERT INTO Dates VALUES
(1,'2018-04-06 11:06:43.020'),
(2,'2017-12-06 11:06:43.020'),
(3,'2016-01-06 11:06:43.020'),
(4,'2015-11-06 11:06:43.020'),
(5,'2014-10-06 11:06:43.020');

SELECT 
    Id,
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthPrefixedWithZero
FROM Dates;


---------------------------------------------------
-- Puzzle 2: Find unique Ids, sum of max values of vals column for each Id and RId
---------------------------------------------------
CREATE TABLE MyTabel (
    Id INT,
    rID INT,
    Vals INT
);
INSERT INTO MyTabel VALUES
(121, 9, 1), (121, 9, 8),
(122, 9, 14), (122, 9, 0), (122, 9, 1),
(123, 9, 1), (123, 9, 2), (123, 9, 10);

SELECT 
    COUNT(DISTINCT Id) AS Distinct_Ids,
    rID,
    SUM(MaxVals) AS TotalOfMaxVals
FROM (
    SELECT Id, rID, MAX(Vals) AS MaxVals
    FROM MyTabel
    GROUP BY Id, rID
) t
GROUP BY rID;


---------------------------------------------------
-- Puzzle 3: Get records with at least 6 characters and maximum 10 characters
---------------------------------------------------
CREATE TABLE TestFixLengths (
    Id INT,
    Vals VARCHAR(100)
);
INSERT INTO TestFixLengths VALUES
(1,'11111111'), (2,'123456'), (2,'1234567'), 
(2,'1234567890'), (5,''), (6,NULL), 
(7,'123456789012345');

SELECT *
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;


---------------------------------------------------
-- Puzzle 4: Find maximum value for each Id and get the Item for that Id
---------------------------------------------------
CREATE TABLE TestMaximum (
    ID INT,
    Item VARCHAR(20),
    Vals INT
);
INSERT INTO TestMaximum VALUES
(1, 'a1',15), (1, 'a2',20), (1, 'a3',90),
(2, 'q1',10), (2, 'q2',40), (2, 'q3',60), (2, 'q4',30),
(3, 'q5',20);

SELECT ID, Item, Vals
FROM TestMaximum t
WHERE Vals = (
    SELECT MAX(Vals) FROM TestMaximum WHERE ID = t.ID
);


---------------------------------------------------
-- Puzzle 5: Find maximum value for each Id and DetailedNumber, then sum per Id
---------------------------------------------------
CREATE TABLE SumOfMax (
    DetailedNumber INT,
    Vals INT,
    Id INT
);
INSERT INTO SumOfMax VALUES
(1,5,101), (1,4,101), (2,6,101), (2,3,101),
(3,3,102), (4,2,102), (4,3,102);

SELECT Id, SUM(MaxVals) AS SumOfMax
FROM (
    SELECT Id, DetailedNumber, MAX(Vals) AS MaxVals
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) t
GROUP BY Id;


---------------------------------------------------
-- Puzzle 6: Difference between a and b, replace zero with blank
---------------------------------------------------
CREATE TABLE TheZeroPuzzle (
    Id INT,
    a INT,
    b INT
);
INSERT INTO TheZeroPuzzle VALUES
(1,10,4), (2,10,10), (3,1, 10000000), (4,15,15);

SELECT 
    Id,
    a,
    b,
    NULLIF(a - b, 0) AS Output
FROM TheZeroPuzzle;


---------------------------------------------------
-- Puzzle 7: Total revenue generated from all sales
---------------------------------------------------
CREATE TABLE Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    Product VARCHAR(50),
    Category VARCHAR(50),
    QuantitySold INT,
    UnitPrice DECIMAL(10,2),
    SaleDate DATE,
    Region VARCHAR(50),
    CustomerID INT
);

INSERT INTO Sales (Product, Category, QuantitySold, UnitPrice, SaleDate, Region, CustomerID)
VALUES
('Laptop', 'Electronics', 10, 800.00, '2024-01-01', 'North', 1),
('Smartphone', 'Electronics', 15, 500.00, '2024-01-02', 'North', 2),
('Tablet', 'Electronics', 8, 300.00, '2024-01-03', 'East', 3),
('Headphones', 'Electronics', 25, 100.00, '2024-01-04', 'West', 4),
('TV', 'Electronics', 5, 1200.00, '2024-01-05', 'South', 5),
('Refrigerator', 'Appliances', 3, 1500.00, '2024-01-06', 'South', 6),
('Microwave', 'Appliances', 7, 200.00, '2024-01-07', 'East', 7),
('Washing Machine', 'Appliances', 4, 1000.00, '2024-01-08', 'North', 8),
('Oven', 'Appliances', 6, 700.00, '2024-01-09', 'West', 9),
('Smartwatch', 'Electronics', 12, 250.00, '2024-01-10', 'East', 10),
('Vacuum Cleaner', 'Appliances', 5, 400.00, '2024-01-11', 'South', 1),
('Gaming Console', 'Electronics', 9, 450.00, '2024-01-12', 'North', 2),
('Monitor', 'Electronics', 14, 300.00, '2024-01-13', 'West', 3),
('Keyboard', 'Electronics', 20, 50.00, '2024-01-14', 'South', 4),
('Mouse', 'Electronics', 30, 25.00, '2024-01-15', 'East', 5),
('Blender', 'Appliances', 10, 150.00, '2024-01-16', 'North', 6),
('Fan', 'Appliances', 12, 75.00, '2024-01-17', 'South', 7),
('Heater', 'Appliances', 8, 120.00, '2024-01-18', 'East', 8),
('Air Conditioner', 'Appliances', 2, 2000.00, '2024-01-19', 'West', 9),
('Camera', 'Electronics', 7, 900.00, '2024-01-20', 'North', 10);

SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue FROM Sales;


---------------------------------------------------
-- Puzzle 8: Average unit price of products
---------------------------------------------------
SELECT AVG(UnitPrice) AS AverageUnitPrice FROM Sales;


---------------------------------------------------
-- Puzzle 9: How many sales transactions were recorded
---------------------------------------------------
SELECT COUNT(*) AS TotalTransactions FROM Sales;


---------------------------------------------------
-- Puzzle 10: Highest number of units sold in a single transaction
---------------------------------------------------
SELECT MAX(QuantitySold) AS MaxUnitsSold FROM Sales;


---------------------------------------------------
-- Puzzle 11: How many products were sold in each category
---------------------------------------------------
SELECT Category, SUM(QuantitySold) AS TotalUnits
FROM Sales
GROUP BY Category;


---------------------------------------------------
-- Puzzle 12: Total revenue for each region
---------------------------------------------------
SELECT Region, SUM(QuantitySold * UnitPrice) AS Revenue
FROM Sales
GROUP BY Region;


---------------------------------------------------
-- Puzzle 13: Which product generated the highest total revenue
---------------------------------------------------
SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;


---------------------------------------------------
-- Puzzle 14: Compute the running total of revenue ordered by sale date
---------------------------------------------------
SELECT 
    SaleDate,
    SUM(QuantitySold * UnitPrice) OVER (ORDER BY SaleDate ROWS UNBOUNDED PRECEDING) AS RunningRevenue
FROM Sales;


---------------------------------------------------
-- Puzzle 15: How much does each category contribute to total sales revenue
---------------------------------------------------
SELECT 
    Category,
    SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
    100.0 * SUM(QuantitySold * UnitPrice) / SUM(SUM(QuantitySold * UnitPrice)) OVER() AS PercentContribution
FROM Sales
GROUP BY Category;


---------------------------------------------------
-- Puzzle 16: Show all sales along with the corresponding customer names
---------------------------------------------------
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Region VARCHAR(50),
    JoinDate DATE
);

INSERT INTO Customers (CustomerName, Region, JoinDate)
VALUES
('John Doe', 'North', '2022-03-01'),
('Jane Smith', 'West', '2023-06-15'),
('Emily Davis', 'East', '2021-11-20'),
('Michael Brown', 'South', '2023-01-10'),
('Sarah Wilson', 'North', '2022-07-25'),
('David Martinez', 'East', '2023-04-30'),
('Laura Johnson', 'West', '2022-09-14'),
('Kevin Anderson', 'South', '2021-12-05'),
('Sophia Moore', 'North', '2023-02-17'),
('Daniel Garcia', 'East', '2022-08-22');

SELECT s.*, c.CustomerName
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;


---------------------------------------------------
-- Puzzle 17: List customers who have not made any purchases
---------------------------------------------------
SELECT c.*
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.CustomerID IS NULL;


---------------------------------------------------
-- Puzzle 18: Compute total revenue generated from each customer
---------------------------------------------------
SELECT c.CustomerName, SUM(s.QuantitySold * s.UnitPrice) AS Revenue
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName;


---------------------------------------------------
-- Puzzle 19: Find the customer who has contributed the most revenue
---------------------------------------------------
SELECT TOP 1 c.CustomerName, SUM(s.QuantitySold * s.UnitPrice) AS Revenue
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerName
ORDER BY Revenue DESC;


---------------------------------------------------
-- Puzzle 20: Calculate the total sales per customer
---------------------------------------------------
SELECT c.CustomerName, COUNT(s.SaleID) AS TotalSales
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerName;


---------------------------------------------------
-- Puzzle 21: List all products that have been sold at least once
---------------------------------------------------
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(50),
    Category VARCHAR(50),
    CostPrice DECIMAL(10,2),
    SellingPrice DECIMAL(10,2)
);

INSERT INTO Products (ProductName, Category, CostPrice, SellingPrice)
VALUES
('Laptop', 'Electronics', 600.00, 800.00),
('Smartphone', 'Electronics', 350.00, 500.00),
('Tablet', 'Electronics', 200.00, 300.00),
('Headphones', 'Electronics', 50.00, 100.00),
('TV', 'Electronics', 900.00, 1200.00),
('Refrigerator', 'Appliances', 1100.00, 1500.00),
('Microwave', 'Appliances', 120.00, 200.00),
('Washing Machine', 'Appliances', 700.00, 1000.00),
('Oven', 'Appliances', 500.00, 700.00),
('Gaming Console', 'Electronics', 320.00, 450.00);

SELECT DISTINCT p.ProductName
FROM Products p
JOIN Sales s ON p.ProductName = s.Product;


---------------------------------------------------
-- Puzzle 22: Find the most expensive product in the Products table
---------------------------------------------------
SELECT TOP 1 *
FROM Products
ORDER BY SellingPrice DESC;


---------------------------------------------------
-- Puzzle 23: Find all products where the selling price is higher than the average selling price in their category
---------------------------------------------------
SELECT p.*
FROM Products p
JOIN (
    SELECT Category, AVG(SellingPrice) AS AvgPrice
    FROM Products
    GROUP BY Category
) x ON p.Category = x.Category
WHERE p.SellingPrice > x.AvgPrice;
