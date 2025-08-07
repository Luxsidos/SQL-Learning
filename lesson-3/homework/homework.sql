-- 1
-- bulk insert is importing table from code commands
-- it includes which place we need to insert this table
-- and we will give the path of file
-- and we can make conditions by with keyword
-- inside of with keywork we can do firstrow starts which line
-- fieldterminator for spliting each column
-- rowterminator for spliting each row
-- tablock Applies a bulk update lock (BU) on the table.
bulk insert F38_class3.dbo.employees2
from 'C:\Users\ACER\Desktop\employees_.csv'
with (
	Firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n',
	tablock
)

-- 2
--CSV (Comma-Separated Values)
--Common text format where fields are separated by commas.
--Easily imported using BULK INSERT, bcp, or SSMS Import Wizard.

--TXT (Plain Text Files)
--Text files with custom delimiters (like tab \t, pipe |, etc.).
--Often used with BULK INSERT with specified FIELDTERMINATOR.

--XLS/XLSX (Excel Files)
--Excel spreadsheet formats.
--Imported using SQL Server Import and Export Wizard or via OPENROWSET.

--XML (eXtensible Markup Language)
--Structured format ideal for hierarchical data.
--Can be imported using OPENXML, xml data type, or BULK INSERT with SINGLE_BLOB.

-- 3
create table Products 
(
	ProductID int primary key,
	ProductName varchar(50),
	Price decimal(10,2)
)

-- 4
insert into Products values 
(1, 'Fridge', 500),
(2, 'Phone', 800),
(3, 'Laptop', 1000),
(4, 'Headphone', 100)

-- 5
-- NULL and NOT NULL constraints
-- if you make your table's column's constraint with NULL
-- or just don't put constraint it will be default NULL
-- NULL means this column's value can be NULL value which is nothing
-- NOT NULL is else case, I mean this column must be value in itself type

-- 6
alter table Products
add constraint UQ_Productname unique(ProductName)

-- 7
-- Tips for writing good SQL comments:
--Use -- for single-line comments.

--Use /* ... */ for multi-line comments.

-- 8
alter table Products
add CategoryID int

-- 9
create table Categories 
(
	CategoryID int primary key,
	CategoryName varchar(50)
)

-- 10
-- IDENTITY constraint can do automatically incerementing value
-- everytime inserting value to table this column will increase value
-- value increasing depend to provided condition
-- for example IDENTITY(100, 4) means start from 100 and increase 4 in each time
-- that means first argument for starting value, second step for each increment

-- 11
--BULK INSERT Products
--FROM 'C:\Data\products.txt'
--WITH (
--    FIELDTERMINATOR = ',',     -- Columns are separated by commas
--    ROWTERMINATOR = '\n',      -- Rows are separated by new lines
--    FIRSTROW = 1,              -- Start from the first row (can skip headers if needed)
--    TABLOCK                   -- Optional: improves performance
--);

-- 12
alter table Products
add constraint fk_category_id Foreign key(CategoryID)
references Categories(CategoryID)

-- 13
-- PRIMARY KEY is includes only unique values which is not been NULL
-- primary key will be only on column from table and it means primary controlling table for this table
-- primary key can connect from other table's foreign key, and primary key included table
-- can't be deleted untill connected tables deleted

-- UNIQUE KEY is just includes unique values 
-- even null includes but only one time

-- 14
alter table Products
add constraint check_price CHECK(Price > 0)

-- 15
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;

-- 16
SELECT 
    ProductID,
    ProductName,
    ISNULL(Price, 0) AS Price,
    Stock
FROM Products

-- 17
--A FOREIGN KEY in SQL Server links one table to another. 
--It makes sure the value in one column (like CategoryID in Products)
--must exist in another table (like Categories).

-- 18
create table Customers (
    CustomerID int primary key,
    Name varchar(100),
    Age int check (Age >= 18)
);

-- 19
create table JustTable (IdentityColumn int Identity(100, 10));

-- 20
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID) 
)

-- 21
--ISNULL is for two values only.
--COALESCE works with multiple options.

-- 22
create table Employees (
    EmpID int primary key,
    Name varchar(100),
    Email varchar(100) unique
)

-- 23
alter table orders
add constraint fk_customerid
foreign key (CustomerId) 
references Customers(CustomerId)
on delete cascade
on update cascade;