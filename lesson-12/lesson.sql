create database class12
go 
use class12

create table family_ (id int,name varchar(25),parentid int)
insert into family_ values (1,'Grandfather',NULL),(2,'Father',1),
(3,'Uncle',1),(4,'Me',2),(5,'My Son',4),(6,'Cousin',3),(7,'Cousin son',6)

select f1.name, f2.name as Fathers, f3.name as Grandfathers
from family_ f1 
left join family_ f2
on f2.id = f1.parentid
left join family_ f3
on f3.id = f2.parentid





CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(100),
    manager_id INT,
    salary DECIMAL(10,2)
);

INSERT INTO Employees (emp_id, emp_name, manager_id, salary) VALUES
(1, 'Alice', NULL, 9000),   -- Top-level manager
(2, 'Bob', 1, 8500),        -- Reports to Alice
(3, 'Charlie', 1, 9500),    -- Reports to Alice (earns more than Alice!)
(4, 'Diana', 2, 8000),      -- Reports to Bob
(5, 'Eve', 2, 8600),        -- Reports to Bob (earns more than Bob!)
(6, 'Frank', 3, 9200);      -- Reports to Charlie


--Write a query that uses a CASE statement to categorize customers based on the total order amount from the orders table.
--If the total amount is less than 100 → mark as "Low Spender"
--If the total amount is between 100 and 500 → mark as "Medium Spender"
--Otherwise → mark as "High Spender"
--The result set should show:
--customerid
--total_amount
--spender_category

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customerid INT,
    quantity INT
);

INSERT INTO Orders (order_id, customerid, quantity) VALUES
(1, 101, 1),   -- should get 3%
(2, 102, 2),   -- should get 5%
(3, 103, 3),   -- should get 5%
(4, 104, 5),   -- should get 7%
(5, 105, 10),  -- should get 7%
(6, 106, 1);   -- should get 3%

select *,
	case
		when quantity = 1 
			then '3% skidka'
		when quantity > 1 and quantity < 5 
			then '5% skidka'
		else '7% skidka'
	end as discount
from Orders


select * from Employees
order by salary desc
offset 1 rows fetch next 1 rows only



create table recipe (foodname varchar(20),ingredient_id int,ingredient varchar(20))
create table fridge (ingredient_id int, ingredientname varchar(20))

insert into recipe values 
('HOTDOG',1,'SAUSAGE'),('HOTDOG',2,'BREAD'),
('PILOV',3,'RICE'),('PILOV',4,'CARROT'),('PILOV',5,'MEAT'),
('PIZZA',6,'FLOUR'),('PIZZA',7,'TOMATO'),('PIZZA',8,'CHEESE')

insert into fridge values (1,'SAUSAGE'),(2,'BREAD'),(3,'RICE'),(4,'CARROT'),
(6,'FLOUR')

select * from recipe
select * from fridge

select r.foodname
from recipe r left join fridge f
on r.ingredient_id = f.ingredient_id
group by r.foodname
having count( r.ingredient) = count( f.ingredientname)



select * from Employees

select emp_name, salary, 
cast((salary / (select sum(salary) from Employees) * 100) as decimal(10, 2))
from Employees

