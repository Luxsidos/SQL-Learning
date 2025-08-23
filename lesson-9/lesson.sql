create database class9
go 
use class9

-- INNER JOIN -- JOIN
-- OUTER JOINS -- LEFT JOIN, RIGHT JOIN, FULL JOIN
-- CROSS JOIN -- CROSS JOIN


-- INNER JOIN VS CROSS JOIN

-- Table Relationship
-- One to Many - Many to one
-- Many to Many
-- One to One


-- INNER JOIN

create table t1 (number int)
create table t2 (number int)

insert into t1 values(1),(2),(3),(4)
insert into t2 values(2),(3),(5),(6)


select * from t1
select * from t2

select * from t1 join t2 
on t1.number = t2.number


select * from t1 join t2 
on t1.number > t2.number

select * from t1 join t2 
on t1.number < t2.number

select * from t1 join t2 
on t1.number <> t2.number

-- CROSS JOIN
select * from t1 cross join t2 
order by t1.number

-- ALTERNATIVE
select * from t1, t2 

-- ON vs WHERE vs HAVING

select * from t1 JOIN t2
on t1.number <> t2.number
where t1.number in (2,3,4)




CREATE TABLE Categories (
    CatID INT PRIMARY KEY,
    CatName VARCHAR(50)
);

CREATE TABLE Products (
    ProdID INT PRIMARY KEY,
    ProdName VARCHAR(50),
    CatID INT,
    FOREIGN KEY (CatID) REFERENCES Categories(CatID)
);

INSERT INTO Categories VALUES (1, 'Electronics'), (2, 'Clothes');
INSERT INTO Products VALUES 
(1, 'Phone', 1),
(2, 'TV', 1),
(3, 'Shirt', 2);

select * from Products
select * from Categories

select * from Products as p join Categories as c
on c.CatID = p.CatID


CREATE TABLE Teachers (
    TID INT PRIMARY KEY,
    TName VARCHAR(50)
);

CREATE TABLE Subjects (
    SID INT PRIMARY KEY,
    SName VARCHAR(50),
    TID INT,
    FOREIGN KEY (TID) REFERENCES Teachers(TID)
);

INSERT INTO Teachers VALUES (1, 'Aziz'), (2, 'Madina');
INSERT INTO Subjects VALUES 
(1, 'Math', 1),
(2, 'English', 2),
(3, 'Algebra', 1);

-- Puzzle: Har bir fan va uni o‘qituvchi bilan chiqar

select * from Teachers
select * from Subjects

select S.SName, T.TName from Teachers as T join Subjects as S
on T.TID = S.TID




--

CREATE TABLE Meals (
    MealID INT PRIMARY KEY,
    MealName VARCHAR(50)
);

CREATE TABLE Days (
    DayID INT PRIMARY KEY,
    DayName VARCHAR(50)
);

INSERT INTO Meals VALUES (1, 'Plov'), (2, 'Lagman');
INSERT INTO Days VALUES (1, 'Monday'), (2, 'Tuesday');

-- Puzzle: CROSS JOIN qilib, har bir taom qaysi kuni yeyilishi mumkinligini ko‘rsatila

select * from Meals
select * from Days

select MealName, DayName from Meals cross join Days

create table students (studentID int, StudentName varchar(20))
create table courses (CourseID int, CourseName varchar(20))
create table enrollments (studentID int, courseID int)
insert into students values (1, 'Alice'), (2, 'Bob'), (3, 'Charlie')
insert into courses values (101, 'Math'), (102, 'Science'), (103, 'English')
insert into Enrollments values (1, 101), (1, 102), (2, 101), (3, 102)

select * from students
select * from courses
select * from enrollments

select * from students as s
join enrollments as e on  s.studentID = e.studentID
join courses as c on c.CourseID = e.courseID

