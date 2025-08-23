create database class10
go
use class10


create table family (id int, name varchar(20), parentID int);

insert into family values
(1, 'Grandfather', null),
(2, 'Father', 1),
(3, 'Uncle', 1),
(4, 'Me', 2),
(5, 'Myson', 4),
(6, 'Cousin', 3),
(7, 'CousinSon', 6);


select * from family

select 
	c.name as child,
	p.name as father, 
	g.name as grandfather 
from family c
left join family p on c.parentID = p.id
left join family g on p.parentID = g.id


-- Products jadvali
create table Products (
    ProductID int,
    ProductName varchar(30)
);

-- Sales jadvali
create table Sales (
    SaleID int,
    ProductID int,
    Quantity int
);

-- Insert
insert into Products values
(1, 'Laptop'),
(2, 'Phone'),
(3, 'Tablet'),
(4, 'Headphones');

insert into Sales values
(1, 1, 5),
(2, 2, 3),
(3, 1, 2);

--Menga barcha mahsulotlarni ko‘rsatila
--ularning nechta sotilganini ham qo‘shib chiqila. 
--Sotilmagan mahsulotlarda Quantity = NULL bo‘lsin.

select * from Products

select * from Sales

select  p.ProductName, sum(s.Quantity) as quantity from Products p
left join Sales s on p.ProductID = s.ProductID
group by p.ProductName


-- Teachers jadvali
create table Teachers (
    TeacherID int,
    TeacherName varchar(30)
);

-- Courses jadvali
create table Courses (
    CourseID int,
    CourseName varchar(30),
    TeacherID int
);

-- Insert
insert into Teachers values
(1, 'Mr. Smith'),
(2, 'Ms. Johnson'),
(3, 'Dr. Brown');

insert into Courses values
(101, 'Math', 1),
(102, 'Science', 2),
(103, 'History', null),
(104, 'Art', 4);

select * from Teachers
select * from Courses

--Barcha kurslarni ularni o‘qitayotgan o‘qituvchilar bilan ko‘rsatila.
--Agar kursga o‘qituvchi biriktirilmagan bo‘lsa yoki 
--o‘qituvchi mavjud bo‘lmasa, NULL chiqsin.

select c.CourseName, t.TeacherName from Teachers t
right join Courses c on t.TeacherID = c.TeacherID


