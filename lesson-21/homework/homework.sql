----------------------------------------------------
-- ProductSales Table
----------------------------------------------------
CREATE TABLE ProductSales (
    SaleID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    SaleDate DATE,
    SaleAmount DECIMAL(10,2),
    Quantity INT,
    CustomerID INT
);

INSERT INTO ProductSales (SaleID, ProductName, SaleDate, SaleAmount, Quantity, CustomerID) VALUES
(1, 'Laptop', '2025-01-01', 1000.00, 1, 101),
(2, 'Mouse',  '2025-01-02', 25.00,   2, 102),
(3, 'Laptop', '2025-01-03', 1100.00, 1, 103),
(4, 'Keyboard','2025-01-04', 45.00,  1, 101),
(5, 'Laptop', '2025-01-05', 950.00,  1, 102),
(6, 'Mouse',  '2025-01-06', 30.00,   3, 103);

----------------------------------------------------
-- 1. Assign a row number to each sale based on the SaleDate
----------------------------------------------------
SELECT 
    SaleID, ProductName, SaleDate, SaleAmount,
    ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;

----------------------------------------------------
-- 2. Rank products based on the total quantity sold (dense rank, no skips)
----------------------------------------------------
SELECT 
    ProductName,
    SUM(Quantity) AS TotalQuantity,
    DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS Rank
FROM ProductSales
GROUP BY ProductName;

----------------------------------------------------
-- 3. Identify the top sale for each customer
----------------------------------------------------
SELECT *
FROM (
    SELECT 
        *, 
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) t
WHERE rn = 1;

----------------------------------------------------
-- 4. Display each sale with the next sale amount
----------------------------------------------------
SELECT 
    SaleID, ProductName, SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSaleAmount
FROM ProductSales;

----------------------------------------------------
-- 5. Display each sale with the previous sale amount
----------------------------------------------------
SELECT 
    SaleID, ProductName, SaleAmount,
    LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSaleAmount
FROM ProductSales;

----------------------------------------------------
-- 6. Sales amounts greater than the previous sale’s amount
----------------------------------------------------
SELECT *
FROM (
    SELECT 
        SaleID, ProductName, SaleAmount,
        LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSale
    FROM ProductSales
) t
WHERE SaleAmount > PrevSale;

----------------------------------------------------
-- 7. Difference in sale amount from previous sale (per product)
----------------------------------------------------
SELECT 
    SaleID, ProductName, SaleAmount,
    SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromPrev
FROM ProductSales;

----------------------------------------------------
-- Employees1 Table
----------------------------------------------------
CREATE TABLE Employees1 (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees1 (EmployeeID, FirstName, LastName, Department, Salary) VALUES
(1, 'John', 'Doe', 'HR', 5000),
(2, 'Jane', 'Smith', 'IT', 6000),
(3, 'Sam', 'Brown', 'Finance', 7000),
(4, 'Nancy', 'White', 'IT', 7500),
(5, 'Tom', 'Clark', 'HR', 4800),
(6, 'Emma', 'Davis', 'Finance', 7200);

----------------------------------------------------
-- 8. List employees earning more than the average salary in their department
----------------------------------------------------
SELECT *
FROM Employees1 e
WHERE Salary > (
    SELECT AVG(Salary) 
    FROM Employees1 
    WHERE Department = e.Department
);

----------------------------------------------------
-- 9. Find the 2nd highest salary in each department
----------------------------------------------------
SELECT *
FROM (
    SELECT 
        *, 
        DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS rnk
    FROM Employees1
) t
WHERE rnk = 2;

----------------------------------------------------
-- 10. Find employees with salaries greater than their department’s average
----------------------------------------------------
SELECT 
    EmployeeID, FirstName, LastName, Department, Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS DeptAvg
FROM Employees1
WHERE Salary > AVG(Salary) OVER (PARTITION BY Department);
