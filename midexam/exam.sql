




-- ##################  SQL Mid Exam ###################### --

--   ################     Ticket 1  ##################  --

-- Question 1
	--If all the columns have zero values, then don’t show that row. 
	--In this case, we have to remove the 5th row while selecting data.

-- DDL and Insert Statement
	CREATE TABLE TestMultipleZero ( A INT NULL, B INT NULL, C INT NULL,  D INT NULL);
	INSERT INTO TestMultipleZero(A,B,C,D) VALUES (0,0,0,1), (0,0,1,0), (0,1,0,0), (1,0,0,0), (0,0,0,0), (1,1,1,0);

-- Expected Output
	--_________________
	--|A	|B	|C	|D|
	--|0	|0	|0	|1|
	--|0	|0	|1	|0|
	--|0	|1	|0	|0|
	--|1	|0	|0	|0|
	--|1	|1	|1	|0|
	
	------ ANSWER ---------
	select * from TestMultipleZero
	where (A+B+C+D) != 0

--#################################################################

-- Question 2
	-- Find those with odd ids:

-- DDL and Insert Statement
	create table section1(id int, name varchar(20))
	insert into section1 values (1, 'Been'),  (2, 'Roma'), (3, 'Steven'), (4, 'Paulo'), (5, 'Genryh'), (6, 'Bruno'), (7, 'Fred'),  (8, 'Andro')

	----- ANSWER ------
	select * from section1
	where id % 2 = 1

-- Expected output
	--_____________
	--|id	|name   |
	--|1	|Been	|
	--|3	|Steven	|
	--|5	|Genryh	|
	--|7	|Fred	|

--##################################################################

-- Question 3
	--Write a query that show all details of product within product categories with an average price greater than 400.

-- DDL and Insert Statement
	CREATE TABLE Products ( ProductID INT PRIMARY KEY, ProductName VARCHAR(100), Price DECIMAL(10, 2), Category VARCHAR(50), StockQuantity INT ); 
	INSERT INTO Products VALUES (1, 'Laptop', 1200.00, 'Electronics', 30),
	(2, 'Smartphone', 800.00, 'Electronics', 50), 
	(3, 'Tablet', 400.00, 'Electronics', 40), 
	(4, 'Monitor', 250.00, 'Electronics', 60),
	(5, 'Keyboard', 50.00, 'Accessories', 100), 
	(6, 'Mouse', 30.00, 'Accessories', 120), 
	(7, 'Chair', 150.00, 'Furniture', 80), 
	(8, 'Desk', 200.00, 'Furniture', 75), 
	(9, 'Pen', 5.00, 'Stationery', 300), 
	(10, 'Notebook', 10.00, 'Stationery', 500), 
	(11, 'Printer', 180.00, 'Electronics', 25), 
	(12, 'Camera', 500.00, 'Electronics', 40),
	(13, 'Flashlight', 25.00, 'Tools', 200), 
	(14, 'Shirt', 30.00, 'Clothing', 150),
	(15, 'Jeans', 45.00, 'Clothing', 120), 
	(16, 'Jacket', 80.00, 'Clothing', 70),
	(17, 'Shoes', 60.00, 'Clothing', 100), 
	(18, 'Book', 15.00, 'Stationery', 250);


-- Expected output
	--________________________________________________________________________
	--|ProductID	|ProductName   |Price		|Category	    |StockQuantity|
	--|1	        |Laptop	       |1200.00		|Electronics	|30			  |
	--|2	        |Smartphone	   |800.00	    |Electronics	|50			  |
	--|3	        |Tablet	       |400.00	    |Electronics	|40			  |
	--|4	        |Monitor	   |250.00	    |Electronics	|60			  |
	--|11	        |Printer	   |180.00	    |Electronics	|25			  |
	--|12	        |Camera	       |500.00	    |Electronics	|40			  |

	--- answer --

	select * from Products
	where  Category = (select Category 
	from Products 
	group by Category
	having AVG(Price) > 400)

	
	
-- ############################################################## 

-- Question 4
	--USING THE Employee TABLE BELOW,
	--WRITE A SQL QUERY TO SHOW RIGHT NEXT EACH EMPLOYEE
	--THEIR MANAGER'S NAME, IF THERE IS NO MANAGER FOR 
	--A GIVEN EMPLOYEE THEN SHOW "No Manager".

-- DDL and Insert Statement
	create table Employee(ID int, Name varchar(50), ManagerID int)

		insert into Employee([ID], [Name], [ManagerID]) values 
	(1,'Great Boss',null),(2,'First Deputy of Boss',1),
	(3,'Second Deputy of Boss',1),(4,'First Deputy Assistant',2),
	(5,'Second Deputy Assistant',3),(6,'First Deputy Assistant shadow',4)
	
	----- answer -----
	select e.Name, iif(b.name is null, 'No Manager', b.name) as ManagerName
	from Employee e left join Employee b
	on b.id = e.ManagerID

-- ################################################################

-- Question 5
	--USING THE OnlineSales and DealerSales TABLES BELOW,
	--WRITE A SQL QUERY TO GET THE OUTPUT BELOW.
	--WHEN FINDING THE TOTAL SALES CONSIDER PRICE NOT THE COST.

-- DDL and Insert Statement
		CREATE TABLE [dbo].[OnlineSales](
		[ProductID] int,
		[Name] varchar(100),
		[Cost] float,
		[Price] float,
		[Quantity] int
	) 

	CREATE TABLE [dbo].[DealerSales](
		[ProductID] int,
		[Name] varchar(100),
		[Cost] float,
		[Price] float,
		[Quantity] int
	) 

	INSERT [dbo].[OnlineSales] ([ProductID], [Name], [Cost], [Price], [Quantity]) VALUES
	(101,'Toyota Camry',20000,30000,20),(102,'Toyota Corolla',15000,23000,23),
	(103,'Toyota RAV4',25000,36000,13),(104,'Toyota GR86',27000,33000,10)

	INSERT [dbo].[DealerSales] ([ProductID], [Name], [Cost], [Price], [Quantity]) VALUES
	(101,'Toyota Camry',20000,30000,17),(102,'Toyota Corolla',15000,23000,31),
	(105,'Toyota Highlander',30000,42000,14),(106,'Toyota Crown',22000,32000,7)

	select * from [dbo].[OnlineSales]
	select * from [dbo].[DealerSales]
	------- ANSWER -------
	
--Expected Output
	--     ----------------------------------------------------------------------------------------------
	--|ProductID  | Name               | Online_Total          | Dealer_Total          | Total_Sales |
	--|-----------|--------------------|-----------------------| ----------------------| ------------|
	--|101        | Toyota Camry       | 600000                | 510000                | 1110000	 |
	--|102        | Toyota Corolla     | 529000                | 713000                | 1242000	 |
	--|103        | Toyota RAV4        | 468000                | 0                     | 468000	     |
	--|104        | Toyota GR86        | 330000                | 0                     | 330000	     |
	--|105        | Toyota Highlander  | 0                     | 588000                | 588000	     |
	--|106        | Toyota Crown       | 0                     | 224000                | 224000	     |
	-- ----------------------------------------------------------------------------------------------
	--- answer
	select 
		coalesce(d.ProductID, o.ProductID) as ProductID,
		coalesce(o.Name, d.Name) as Name,
		coalesce(((o.Price) * o.Quantity), 0) as Online_Total,
		coalesce(((d.Price) * d.Quantity), 0) as Dealer_Total,
		coalesce(((d.Price) * d.Quantity), 0) + coalesce(((o.Price) * o.Quantity), 0) as Total_Sales
	from OnlineSales o full join DealerSales d
	on o.ProductID = d.ProductID
	order by coalesce(d.ProductID, o.ProductID)




	



