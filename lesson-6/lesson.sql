create database f38_class6
go
use f38_class6

create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')



--Ex:
-- 3ga karrali ID lari chiqsin
-- Name B harfi bilan boshlanadiganlar yoki ID si toq bolganlar chiqsin
-- Name 2-harfi r bo'lganlar chiqsin
-- Name uzunligi 5 yoki undan ko'p, name B yoki F bilan boshlanganlar chiqsin

-- 1
Select * from section1
where id%3 = 0

-- 2 
select * from section1
where name like 'B%' or id % 2 = 1

-- 3
select * from section1
where name like '_r%'

-- 4
select * from section1
where name like '[BF]____%'






--If all the columns having zero value then don’t show that row. In this case we have to remove the 5th row while selecting data.
----Create table

CREATE TABLE [dbo].[TestMultipleZero]
(
    [A] [int] NULL,
    [B] [int] NULL,
    [C] [int] NULL,
    [D] [int] NULL
)
GO
 
--Insert Data
INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0)

--If all the columns having zero value then don’t show that row.
--In this case we have to remove the 5th row while selecting data.


select * from TestMultipleZero
where A != 0 or B != 0 or C != 0 or D != 0 




create table section2 (id int, name varchar(20), salary int)
insert into section2 values (1, 'Been', 1000),
              (2, 'Roma', 600),
              (3, 'Steven', 3000),
              (4, 'Paulo',800),
              (5, 'Genryh', 1000),
              (6, 'Bruno', 2500),
              (7, 'Fred', 1500),
              (8, 'Andro', 2000)
              select * from section2


			  
/*

-- Eng kam maosh oladiganlar chiqsin

--Masalan bu tableda oyliklar US dollarda $ da korsatilgan, 
Shunday ekan deylik bugun bayram va Hammani oyligiga 4000 Rubl bonus qo'shilsin

-- Eng ko'p maosh oladiganlarni 2- o'rinda turadiganlar chiqsin
-- Ismini oxirgi harfi unli va 2000 dan pas maosh oladiganlar chiqsin 
*/


-- 1
select * from section2
order by salary

-- 2
select *,  salary + (4000 / 79.7) as with_bonus from section2

-- 3
select * from section2
order by salary desc
offset 1 rows fetch next 1 rows only

-- 4
select * from section2
where name like '%[aeuio]' or salary < 2000



CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);

-- DDL for the VIPCustomers table
CREATE TABLE VIPCustomers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(50)
);

-- Sample data for Customers
INSERT INTO Customers VALUES (1, 'John Doe');
INSERT INTO Customers VALUES (2, 'Jane Smith');
INSERT INTO Customers VALUES (3, 'Bob Johnson');
INSERT INTO Customers VALUES (4, 'Alice Williams');
INSERT INTO Customers VALUES (5, 'Charlie Brown');

-- Sample data for VIPCustomers
INSERT INTO VIPCustomers VALUES (2, 'Jane Smith');
INSERT INTO VIPCustomers VALUES (4, 'Alice Williams');
INSERT INTO VIPCustomers VALUES (6, 'Eve White');


-- 1
select * from Customers
intersect
select * from VIPCustomers

-- 2
select * from VIPCustomers
except
select * from Customers

-- 3
select * from Customers
except
select * from VIPCustomers