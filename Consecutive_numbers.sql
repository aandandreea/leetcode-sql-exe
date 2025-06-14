/* 180. Consecutive Numbers

Table: Logs

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| num         | varchar |
+-------------+---------+
In SQL, id is the primary key for this table.
id is an autoincrement column starting from 1.
 

Find all numbers that appear at least three times consecutively.

Return the result table in any order.*/
select distinct num as ConsecutiveNums
from (
  select num,
         lag(num, 1) over (order by id) as prev1,
         lag(num, 2) over (order by id) as prev2
  from logs
) t
where num = prev1 and num = prev2;

-- another solution
select a.num as ConsecutiveNums
from logs a
inner join logs b
on a.id+1=b.id and a.num=b.num
inner join logs c
on b.id+1=c.id and b.num=c.num

