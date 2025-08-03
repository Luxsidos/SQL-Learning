
-- 1 

--Data Raw facts like numbers or text with no meaning on their own
--Database system to store and organize data.
--Relational Database type of database that stores data in linked tables.
--Table grid of rows and columns used to store related data.

-- 2
 
--Stores and manages large amounts of data.
--Uses T-SQL for writing queries and procedures.
--Strong security with login controls.
--Backup and restore tools to protect data.
--High availability options like replication and failover.

-- 3
--Windows Authentication uses your Windows login.
--SQL Server Authentication uses a separate username and password


-- 4

create database SchoolDB;

use SchoolDB

-- 5
create table Students (StudentId INT PRIMARY KEY, Name VARCHAR(50), Age INT)

-- 6

--SQL Server is the system,
--SSMS is interface,
--SQL is the language you use to communicate with system.

-- 7

-- DQL – Data Query Language
--Use Fetch data

--Command SELECT

--Example:
SELECT * FROM Students;

--DML – Data Manipulation Language
--Use: Add, change, or remove data
--Commands: INSERT, UPDATE, DELETE

--Examples:
--INSERT INTO Users (Name) VALUES ('Ali');
--UPDATE Users SET Name = 'Ilyas' WHERE ID = 1;
--DELETE FROM Users WHERE ID = 1;

--DDL – Data Definition Language
--Use: Create or change tables
--Commands: CREATE, ALTER, DROP

--Examples:
--ALTER TABLE Users ADD Age INT;
--DROP TABLE Users;

-- DCL – Data Control Language
--Use: Give or remove access
--Commands: GRANT, REVOKE

--Examples:
--GRANT SELECT ON Users TO user123;
--REVOKE SELECT ON Users FROM user123;


--TCL – Transaction Control Language
--Use: Manage transactions
--Commands: COMMIT, ROLLBACK

--Examples:
--BEGIN TRAN;
--UPDATE Accounts SET Balance = Balance - 100 WHERE ID = 1;
--COMMIT;

-- 8
insert into Students values (1, 'Jack', 14);
insert into Students values (2, 'John', 36);
insert into Students values (3, 'Abigail', 34);

