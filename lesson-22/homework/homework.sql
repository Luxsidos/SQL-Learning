-------------------------------------------------
-- Easy Questions
-------------------------------------------------

-- Compute Running Total Sales per Customer
SELECT customer_id, customer_name, order_date, total_amount,
       SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS running_total
FROM sales_data;

-- Count the Number of Orders per Product Category
SELECT product_category, COUNT(*) AS order_count
FROM sales_data
GROUP BY product_category;

-- Find the Maximum Total Amount per Product Category
SELECT product_category, MAX(total_amount) AS max_total
FROM sales_data
GROUP BY product_category;

-- Find the Minimum Price of Products per Product Category
SELECT product_category, MIN(unit_price) AS min_price
FROM sales_data
GROUP BY product_category;

-- Compute the Moving Average of Sales of 3 days (prev day, curr day, next day)
SELECT order_date, total_amount,
       AVG(total_amount) OVER (ORDER BY order_date ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg
FROM sales_data;

-- Find the Total Sales per Region
SELECT region, SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region;

-- Compute the Rank of Customers Based on Their Total Purchase Amount
SELECT customer_id, customer_name,
       SUM(total_amount) AS total_spending,
       RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank_position
FROM sales_data
GROUP BY customer_id, customer_name;

-- Calculate the Difference Between Current and Previous Sale Amount per Customer
SELECT customer_id, customer_name, order_date, total_amount,
       total_amount - LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS diff_from_previous
FROM sales_data;

-- Find the Top 3 Most Expensive Products in Each Category
SELECT product_category, product_name, unit_price
FROM (
    SELECT product_category, product_name, unit_price,
           ROW_NUMBER() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS rn
    FROM sales_data
) t
WHERE rn <= 3;

-- Compute the Cumulative Sum of Sales Per Region by Order Date
SELECT region, order_date, SUM(total_amount) OVER (PARTITION BY region ORDER BY order_date) AS cumulative_sales
FROM sales_data;


-------------------------------------------------
-- Medium Questions
-------------------------------------------------

-- Compute Cumulative Revenue per Product Category
SELECT product_category, order_date, 
       SUM(total_amount) OVER (PARTITION BY product_category ORDER BY order_date) AS cumulative_revenue
FROM sales_data;

-- Sum of Previous Values to Current Value (Sample Input/Output)
CREATE TABLE OneColumn (
    Value SMALLINT
);
INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

SELECT Value,
       SUM(Value) OVER (ORDER BY (SELECT NULL)) AS [Sum of Previous]
FROM OneColumn;

-- Find customers who have purchased items from more than one product_category
SELECT customer_id, customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;

-- Find Customers with Above-Average Spending in Their Region
WITH RegionAvg AS (
    SELECT region, AVG(total_amount) AS avg_spending
    FROM sales_data
    GROUP BY region
)
SELECT s.customer_id, s.customer_name, s.region, SUM(s.total_amount) AS total_spending
FROM sales_data s
JOIN RegionAvg r ON s.region = r.region
GROUP BY s.customer_id, s.customer_name, s.region, r.avg_spending
HAVING SUM(s.total_amount) > r.avg_spending;

-- Rank customers based on their total spending (total_amount) within each region
SELECT region, customer_id, customer_name, SUM(total_amount) AS total_spending,
       RANK() OVER (PARTITION BY region ORDER BY SUM(total_amount) DESC) AS region_rank
FROM sales_data
GROUP BY region, customer_id, customer_name;

-- Calculate the running total (cumulative_sales) of total_amount for each customer_id
SELECT customer_id, customer_name, order_date, total_amount,
       SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS cumulative_sales
FROM sales_data;

-- Calculate the sales growth rate (growth_rate) for each month compared to the previous month
WITH MonthlySales AS (
    SELECT YEAR(order_date) AS year, MONTH(order_date) AS month,
           SUM(total_amount) AS monthly_sales
    FROM sales_data
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT year, month, monthly_sales,
       (monthly_sales - LAG(monthly_sales) OVER (ORDER BY year, month)) * 1.0 /
        LAG(monthly_sales) OVER (ORDER BY year, month) AS growth_rate
FROM MonthlySales;

-- Identify customers whose total_amount is higher than their last order's total_amount
SELECT customer_id, customer_name, order_date, total_amount
FROM (
    SELECT customer_id, customer_name, order_date, total_amount,
           LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_total
    FROM sales_data
) t
WHERE total_amount > ISNULL(prev_total, 0);


-------------------------------------------------
-- Hard Questions
-------------------------------------------------

-- Identify Products that prices are above the average product price
SELECT product_name, unit_price
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data);

-- Puzzle: sum of val1 and val2 for each group, show only in first row of group
CREATE TABLE MyData (
    Id INT, Grp INT, Val1 INT, Val2 INT
);
INSERT INTO MyData VALUES
(1,1,30,29), (2,1,19,0), (3,1,11,45), (4,2,0,0), (5,2,100,17);

SELECT Id, Grp, Val1, Val2,
       CASE WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1
            THEN SUM(Val1+Val2) OVER (PARTITION BY Grp) END AS Tot
FROM MyData;

-- Puzzle: sum up the value of the cost column based on the values of Id. 
-- For Quantity if values are different then add those values.
CREATE TABLE TheSumPuzzle (
    ID INT, Cost INT, Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164), (1234,13,164), (1235,100,130), (1235,100,135), (1236,12,136);

SELECT ID, SUM(Cost) AS Cost, SUM(Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY ID;

-- Puzzle: Find missing seat ranges (gap start, gap end)
CREATE TABLE Seats (SeatNumber INT);
INSERT INTO Seats VALUES 
(7),(13),(14),(15),(27),(28),(29),(30),
(31),(32),(33),(34),(35),(52),(53),(54);

WITH AllNums AS (
    SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
)
, Filtered AS (
    SELECT n
    FROM AllNums
    WHERE n BETWEEN 1 AND (SELECT MAX(SeatNumber) FROM Seats)
      AND n NOT IN (SELECT SeatNumber FROM Seats)
)
SELECT MIN(n) AS GapStart, MAX(n) AS GapEnd
FROM (
    SELECT n, n - ROW_NUMBER() OVER (ORDER BY n) AS grp
    FROM Filtered
) t
GROUP BY grp
ORDER BY GapStart;
