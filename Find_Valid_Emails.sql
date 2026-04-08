/*3436. Find Valid Emails

Table: Users

+-----------------+---------+
| Column Name     | Type    |
+-----------------+---------+
| user_id         | int     |
| email           | varchar |
+-----------------+---------+
(user_id) is the unique key for this table.
Each row contains a user's unique ID and email address.
Write a solution to find all the valid email addresses. A valid email address meets the following criteria:

It contains exactly one @ symbol.
It ends with .com.
The part before the @ symbol contains only alphanumeric characters and underscores.
The part after the @ symbol and before .com contains a domain name that contains only letters.
Return the result table ordered by user_id in ascending order.*/

select user_id,email
from Users
where email REGEXP '^[A-Za-z0-9]+@[a-z]+\\.com$'
group by user_id
order by user_id;
