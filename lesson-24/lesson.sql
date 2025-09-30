create database class24
go 
use class24

--Given the following table, return a list of users and 
--their corresponding friend count. Order the result by descending friend count,
--and in the case of a tie, by ascending user ID. Assume 
--that only unique friendships are displayed.

CREATE TABLE Friends (
    user1 INT NOT NULL,
    user2 INT NOT NULL
);

INSERT INTO Friends (user1, user2) VALUES
(1, 2),
(1, 3),
(1, 4),
(2, 3);

--Friends
-------------------
--| user1 | user2 |  
--|---------------|  
--| 1    |   2    |  
--| 1    |   3    |  
--| 1    |   4    |  
--| 2    |   3    |
-------------------

--Expected Output
--------------------
--|user_id | count |
--|--------|-------|
--| 1      | 3     |
--| 2      | 2     |
--| 3      | 2     |
--| 4      | 1     |
--------------------


select * from Friends;

with cte1 as
(
	select user1 as all_user from Friends
	union all
	select user2 as all_user from Friends
) select all_user as user_id, count(all_user) from cte1
group by all_user