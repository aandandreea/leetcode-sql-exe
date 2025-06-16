/* 626. Exchange Seats
Table: Seat

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| student     | varchar |
+-------------+---------+
id is the primary key (unique value) column for this table.
Each row of this table indicates the name and the ID of a student.
The ID sequence always starts from 1 and increments continuously.
 

Write a solution to swap the seat id of every two consecutive students. If the number of students is odd, the id of the last student is not swapped.

Return the result table ordered by id in ascending order.*/
select s1.id,coalesce(
case
when s1.id % 2 = 1 then s2.student
when s1.id % 2 = 0 then s2.student
end,s1.student) as student
from seat s1
left join seat s2
on (s1.id % 2 = 1 and s2.id = s1.id + 1)
or (s1.id % 2 = 0 and s2.id = s1.id - 1)
order by s1.id;
