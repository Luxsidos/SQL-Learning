--create database class2

--use class2

--select * from sys.databases



--create table student 
--(student_id int, firstname varchar(50), contract_id int IDENTITY(1,1))


--insert into student values (1, 'John'), (2, 'Jack')

--select * from student

--create table family (parentname varchar(50), homenumber int identity (1,1), age int)

--insert into family values ('John', 50), ('Lila', 48), ('Wich', 32)

--select * from family

--select * from INFORMATION_SCHEMA.TABLES
--select * from INFORMATION_SCHEMA.COLUMNS
--select * from sys.schemas


--drop database class2

create database class2

use class2

create table student 
(student_id int, firstname varchar(50), contract_id int IDENTITY(1,1))


insert into student values (1, 'John'), (2, 'Jack')

alter table student add lastname varchar(50)

select * from student

alter table student drop column lastname

delete student 
where firstname = 'Jack'

create table FootballTeam (firstname varchar(50), lastname varchar(50), result int)

insert into FootballTeam values
('Obama', 'Winkle', 8), ('John', 'Wick', 12), ('Will', 'Smith', 7)

select * from FootballTeam

alter table FootballTeam add phonenumber int
