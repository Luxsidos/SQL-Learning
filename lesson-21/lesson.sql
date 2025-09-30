-- ** aggregate window

-- ranking window function = row_number, rank, dense_rank, ntile
-- valued window function = first_value, last_value, lead, lag

create database class21
go
use class21

-- aggregate window function = sum, max, min, avg, count

Create Table Sales (TransactionID int identity, amount int, TransactionDate date)
Insert Sales values (150, '2020-01-01'), (200, '2020-01-01'), (120, '2020-01-01'), (75, '2020-01-02'), 
          (300, '2020-01-02')

select * from Sales


select sum(amount) from Sales

select *,
	sum(amount) over () as SumAmount
from Sales


select *,
	sum(amount) over (order by transactionID) as SumAmount
from Sales


select *,
	min(amount) over (order by transactionID) as SumAmount
from Sales

select *,
	min(amount) over (partition by transactionID) as SumAmount
from Sales

select *,
	max(amount) over (order by transactionID) as SumAmount
from Sales

select *,
	count(*) over (order by transactionID) as SumAmount
from Sales

select *,
	count(*) over (partition by transactionDate order by transactionID) as SumAmount
from Sales

select *,
	avg(amount) over () as SumAmount
from Sales

select *,
	avg(amount) over (partition by transactionDate order by transactionID) as SumAmount
from Sales

-- farming/scoping

/* Beginning
	n preceding
	current row
	unbounded preceding
   End
	n following
	current row
	unbounded following
*/

select *, sum(amount) over (order by transactionid rows between unbounded preceding and unbounded following)
from sales

select *, sum(amount) over ()
from sales

select *, sum(amount) over (order by transactionid rows between 2 preceding and unbounded following)
from sales
order by transactionID

select *, sum(amount) over (order by transactionid rows between current row and unbounded following)
from sales
order by transactionID

select *, sum(amount) over (order by transactionid rows between 2 preceding and current row)
from sales
order by transactionID

-- puzzles

create table numbers (number int)

insert into numbers values (1),(2),(3),(5),(6),(8),(11),(12)

;with cte_result as
(
select *,
	ROW_NUMBER() over (order by number) as rownum,
	number - ROW_NUMBER() over (order by number) as [group]
	from numbers
)
select *, 
	min(number) over (partition by [group]) as [min],
	max(number) over (partition by [group]) as [max],
	CONCAT(
		min(number) over (partition by [group]),
		'-',
		max(number) over (partition by [group])
	) as result_concat
from cte_result



select *, 
	min(number) over (partition by [group]) as [min],
	max(number) over (partition by [group]) as [max],
	CONCAT(
		min(number) over (partition by [group]),
		'-',
		max(number) over (partition by [group])
	) as result_concat
from
(
select *,
	ROW_NUMBER() over (order by number) as rownum,
	number - ROW_NUMBER() over (order by number) as [group]
	from numbers
) as result_concat

CREATE TABLE daily_sales (
    id INT PRIMARY KEY,
    sale_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO daily_sales (id, sale_date, amount) VALUES
(1, '2024-09-25', 100.00),
(2, '2024-09-25', 300.00),
(3, '2024-09-26', 150.00),
(4, '2024-09-26', 250.00),
(5, '2024-09-27', 200.00),
(6, '2024-09-27', 500.00);


select *,
	avg(amount) over (order by id rows between 2 preceding and current row) as avg_till_3_days
from daily_sales
order by id