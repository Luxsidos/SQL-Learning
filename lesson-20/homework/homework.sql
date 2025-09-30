---------------------------------------------------
-- 1. Find customers who purchased at least one item in March 2024 using EXISTS
---------------------------------------------------
CREATE TABLE #Sales (
    SaleID INT PRIMARY KEY IDENTITY(1,1),
    CustomerName VARCHAR(100),
    Product VARCHAR(100),
    Quantity INT,
    Price DECIMAL(10,2),
    SaleDate DATE
);

INSERT INTO #Sales (CustomerName, Product, Quantity, Price, SaleDate) VALUES
('Alice', 'Laptop', 1, 1200.00, '2024-01-15'),
('Bob', 'Smartphone', 2, 800.00, '2024-02-10'),
('Charlie', 'Tablet', 1, 500.00, '2024-02-20'),
('David', 'Laptop', 1, 1300.00, '2024-03-05'),
('Eve', 'Smartphone', 3, 750.00, '2024-03-12'),
('Frank', 'Headphones', 2, 100.00, '2024-04-08'),
('Grace', 'Smartwatch', 1, 300.00, '2024-04-25'),
('Hannah', 'Tablet', 2, 480.00, '2024-05-05'),
('Isaac', 'Laptop', 1, 1250.00, '2024-05-15'),
('Jack', 'Smartphone', 1, 820.00, '2024-06-01');

SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1 FROM #Sales s2
    WHERE s2.CustomerName = s1.CustomerName
      AND MONTH(s2.SaleDate) = 3
      AND YEAR(s2.SaleDate) = 2024
);

---------------------------------------------------
-- 2. Find the product with the highest total sales revenue using a subquery
---------------------------------------------------
SELECT TOP 1 Product, SUM(Quantity * Price) AS TotalRevenue
FROM #Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;

---------------------------------------------------
-- 3. Find the second highest sale amount using a subquery
---------------------------------------------------
SELECT MAX(SaleAmount) AS SecondHighest
FROM (
    SELECT Quantity * Price AS SaleAmount
    FROM #Sales
) t
WHERE SaleAmount < (SELECT MAX(Quantity * Price) FROM #Sales);

---------------------------------------------------
-- 4. Find the total quantity of products sold per month using a subquery
---------------------------------------------------
SELECT MONTH(SaleDate) AS SaleMonth, SUM(Quantity) AS TotalQuantity
FROM #Sales
GROUP BY MONTH(SaleDate);

---------------------------------------------------
-- 5. Find customers who bought same products as another customer using EXISTS
---------------------------------------------------
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1 FROM #Sales s2
    WHERE s1.Product = s2.Product
      AND s1.CustomerName <> s2.CustomerName
);

---------------------------------------------------
-- 6. Return how many fruits does each person have in individual fruit level
---------------------------------------------------
CREATE TABLE Fruits(Name VARCHAR(50), Fruit VARCHAR(50));

INSERT INTO Fruits VALUES 
('Francesko', 'Apple'), ('Francesko', 'Apple'), ('Francesko', 'Apple'),
('Francesko', 'Orange'), ('Francesko', 'Banana'), ('Francesko', 'Orange'),
('Li', 'Apple'), ('Li', 'Orange'), ('Li', 'Apple'), ('Li', 'Banana'),
('Mario', 'Apple'), ('Mario', 'Apple'), ('Mario', 'Apple'),
('Mario', 'Banana'), ('Mario', 'Banana'), ('Mario', 'Orange');

SELECT Name,
       SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
       SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
       SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;

---------------------------------------------------
-- 7. Return older people in the family with younger ones
---------------------------------------------------
CREATE TABLE Family(ParentId INT, ChildID INT);
INSERT INTO Family VALUES (1, 2), (2, 3), (3, 4);

WITH CTE AS (
    SELECT ParentId, ChildID FROM Family
    UNION ALL
    SELECT f.ParentId, c.ChildID
    FROM Family f
    JOIN CTE c ON f.ChildID = c.ParentId
)
SELECT * FROM CTE;

---------------------------------------------------
-- 8. For every customer that had a delivery to California, show their orders delivered to Texas
---------------------------------------------------
CREATE TABLE #Orders (
    CustomerID INT,
    OrderID INT,
    DeliveryState VARCHAR(100) NOT NULL,
    Amount MONEY NOT NULL,
    PRIMARY KEY (CustomerID, OrderID)
);

INSERT INTO #Orders VALUES
(1001,1,'CA',340),(1001,2,'TX',950),(1001,3,'TX',670),
(1001,4,'TX',860),(2002,5,'WA',320),(3003,6,'CA',650),
(3003,7,'CA',830),(4004,8,'TX',120);

SELECT o.*
FROM #Orders o
WHERE o.DeliveryState = 'TX'
  AND EXISTS (
    SELECT 1 FROM #Orders o2
    WHERE o2.CustomerID = o.CustomerID
      AND o2.DeliveryState = 'CA'
);

---------------------------------------------------
-- 9. Insert the names of residents if they are missing
---------------------------------------------------
CREATE TABLE #residents(resid INT IDENTITY, fullname VARCHAR(50), address VARCHAR(100));

INSERT INTO #residents VALUES 
('Dragan', 'city=Bratislava country=Slovakia name=Dragan age=45'),
('Diogo', 'city=Lisboa country=Portugal age=26'),
('Celine', 'city=Marseille country=France name=Celine age=21'),
('Theo', 'city=Milan country=Italy age=28'),
('Rajabboy', 'city=Tashkent country=Uzbekistan age=22');

UPDATE r
SET fullname = SUBSTRING(r.address, CHARINDEX('name=', r.address) + 5, 
               CHARINDEX(' age=', r.address) - CHARINDEX('name=', r.address) - 5)
FROM #residents r
WHERE fullname NOT LIKE '%[A-Za-z]%';

---------------------------------------------------
-- 10. Return the route to reach from Tashkent to Khorezm including cheapest and most expensive routes
---------------------------------------------------
CREATE TABLE #Routes (
    RouteID INT NOT NULL,
    DepartureCity VARCHAR(30) NOT NULL,
    ArrivalCity VARCHAR(30) NOT NULL,
    Cost MONEY NOT NULL,
    PRIMARY KEY (DepartureCity, ArrivalCity)
);

INSERT INTO #Routes VALUES
(1,'Tashkent','Samarkand',100),
(2,'Samarkand','Bukhoro',200),
(3,'Bukhoro','Khorezm',300),
(4,'Samarkand','Khorezm',400),
(5,'Tashkent','Jizzakh',100),
(6,'Jizzakh','Samarkand',50);

WITH Paths AS (
    SELECT DepartureCity, ArrivalCity, CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(MAX)) AS Route, Cost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    UNION ALL
    SELECT p.DepartureCity, r.ArrivalCity, p.Route + ' - ' + r.ArrivalCity, p.Cost + r.Cost
    FROM Paths p
    JOIN #Routes r ON p.ArrivalCity = r.DepartureCity
)
SELECT Route, Cost
FROM Paths
WHERE ArrivalCity = 'Khorezm';

---------------------------------------------------
-- 11. Rank products based on their order of insertion
---------------------------------------------------
CREATE TABLE #RankingPuzzle(ID INT, Vals VARCHAR(10));
INSERT INTO #RankingPuzzle VALUES
(1,'Product'),(2,'a'),(3,'a'),(4,'a'),(5,'a'),
(6,'Product'),(7,'b'),(8,'b'),
(9,'Product'),(10,'c');

SELECT ID, Vals,
       ROW_NUMBER() OVER (ORDER BY ID) AS RowNum
FROM #RankingPuzzle;

---------------------------------------------------
-- 12. Find employees whose sales were higher than the average sales in their department
---------------------------------------------------
CREATE TABLE #EmployeeSales (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeName VARCHAR(100),
    Department VARCHAR(50),
    SalesAmount DECIMAL(10,2),
    SalesMonth INT,
    SalesYear INT
);

INSERT INTO #EmployeeSales (EmployeeName, Department, SalesAmount, SalesMonth, SalesYear) VALUES
('Alice', 'Electronics', 5000, 1, 2024),
('Bob', 'Electronics', 7000, 1, 2024),
('Charlie', 'Furniture', 3000, 1, 2024),
('David', 'Furniture', 4500, 1, 2024),
('Eve', 'Clothing', 6000, 1, 2024),
('Frank', 'Electronics', 8000, 2, 2024),
('Grace', 'Furniture', 3200, 2, 2024),
('Hannah', 'Clothing', 7200, 2, 2024),
('Isaac', 'Electronics', 9100, 3, 2024),
('Jack', 'Furniture', 5300, 3, 2024),
('Kevin', 'Clothing', 6800, 3, 2024),
('Laura', 'Electronics', 6500, 4, 2024),
('Mia', 'Furniture', 4000, 4, 2024),
('Nathan', 'Clothing', 7800, 4, 2024);

SELECT *
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
      AND SalesMonth = e.SalesMonth
      AND SalesYear = e.SalesYear
);

---------------------------------------------------
-- 13. Find employees who had the highest sales in any given month using EXISTS
---------------------------------------------------
SELECT DISTINCT e1.EmployeeName, e1.SalesMonth, e1.SalesYear
FROM #EmployeeSales e1
WHERE EXISTS (
    SELECT 1 FROM #EmployeeSales e2
    WHERE e1.Department = e2.Department
      AND e1.SalesMonth = e2.SalesMonth
      AND e1.SalesYear = e2.SalesYear
      AND e1.SalesAmount = (
          SELECT MAX(SalesAmount)
          FROM #EmployeeSales e3
          WHERE e3.Department = e1.Department
            AND e3.SalesMonth = e1.SalesMonth
            AND e3.SalesYear = e1.SalesYear
      )
);

---------------------------------------------------
-- 14. Find employees who made sales in every month using NOT EXISTS
---------------------------------------------------
SELECT e.EmployeeName
FROM #EmployeeSales e
GROUP BY e.EmployeeName
HAVING COUNT(DISTINCT e.SalesMonth) = (
    SELECT COUNT(DISTINCT SalesMonth) FROM #EmployeeSales
);

---------------------------------------------------
-- 15. Retrieve the names of products that are more expensive than the average price of all products
---------------------------------------------------
SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

---------------------------------------------------
-- 16. Find the products that have a stock count lower than the highest stock count
---------------------------------------------------
SELECT Name
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);

---------------------------------------------------
-- 17. Get the names of products that belong to the same category as 'Laptop'
---------------------------------------------------
SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');

---------------------------------------------------
-- 18. Retrieve products whose price is greater than the lowest price in the Electronics category
---------------------------------------------------
SELECT Name
FROM Products
WHERE Price > (
    SELECT MIN(Price) FROM Products WHERE Category = 'Electronics'
);

---------------------------------------------------
-- 19. Find the products that have a higher price than the average price of their respective category
---------------------------------------------------
SELECT p.Name, p.Category, p.Price
FROM Products p
WHERE p.Price > (
    SELECT AVG(Price) FROM Products WHERE Category = p.Category
);

---------------------------------------------------
-- 20. Find the products that have been ordered at least once
---------------------------------------------------
SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;

---------------------------------------------------
-- 21. Retrieve the names of products that have been ordered more than the average quantity ordered
---------------------------------------------------
SELECT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (SELECT AVG(Quantity) FROM Orders);

---------------------------------------------------
-- 22. Find the products that have never been ordered
---------------------------------------------------
SELECT p.Name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1 FROM Orders o WHERE o.ProductID = p.ProductID
);

---------------------------------------------------
-- 23. Retrieve the product with the highest total quantity ordered
---------------------------------------------------
SELECT TOP 1 p.Name, SUM(o.Quantity) AS TotalQty
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
ORDER BY TotalQty DESC;
