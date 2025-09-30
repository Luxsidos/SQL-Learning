CREATE DATABASE CLASS18
GO
USE CLASS18;

-- view, temp tables, functions

-- view
CREATE VIEW vw_NAME 
AS 
SELECT 1 ID, 'John' NAME

SELECT * FROM vw_NAME

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    birth_date DATE,
    group_name VARCHAR(20),
    phone_number VARCHAR(15)
);

INSERT INTO Student (student_id, first_name, last_name, birth_date, group_name, phone_number)
VALUES 
(1, 'Ali', 'Karimov', '2002-05-12', 'G1', '+998901234567'),
(2, 'Malika', 'Rustamova', '2003-01-25', 'G1', '+998907654321'),
(3, 'Javlon', 'Toirov', '2001-11-03', 'G2', '+998933456789'),
(4, 'Dilshod', 'Qodirov', '2002-07-19', 'G3', '+998935551122'),
(5, 'Aziza', 'Saidova', '2003-03-30', 'G2', '+998936667788');

ALTER VIEW vw_Fullname
AS
SELECT 
	student_id, 
	CONCAT_WS(' ', first_name, last_name) AS Fullname
FROM Student

-- VIEW, DERIVED, CTE (Command Table Expression)

-- temp tables

-- temporary tables 

-- local table
-- global table

select * from [AdventureWorks2022].[dbo].[Customers]

create table #Customers (
[CustomerID] [int] NOT NULL,
	[FullName] [varchar](50) NULL,
	[Country] [varchar](50) NULL,
	[City] [varchar](50) NULL)

insert into #Customers
select * from [AdventureWorks2022].[dbo].[Customers]

select * into #Customers from [AdventureWorks2022].[dbo].[Customers]

select * into ##Customers from [AdventureWorks2022].[dbo].[Customers]

-- functions

-- string, math, date, aggregate 
-- scalar value functions
-- table valued functions

-- scalar
create function udf_Function_name [(Parameter(s))]
returns scalar
as 
begin 
	select ...
	return [value]
end


-- Table
create function udf_Function_name [(Parameter(s))]
returns table
as 
return(	
	select ... where col_name [(Parameter(s))]
);


create function udf_calculate (@num1 int, @num2 int)
returns int
as
begin
	return @num1 + @num2
end

select *, [dbo].[udf_calculate](3, 5) as calculated_result from Student

create function udf_odd_students (@OddEven varchar(20))
returns table
as
return (
	select * from 
		(select *, iif(student_id % 2 = 1, 'odd', 'even') OddEven
		from Student) a
	where OddEven = @OddEven
)

select * from [udf_odd_students]('Odd');

with numbers
as (
	select 1 n
	union all
	select n + 1 from numbers
	where n < 10
)
select STRING_AGG(n, '') from numbers
