/*
1907. Count Salary Categories

Table: Accounts

+-------------+------+
| Column Name | Type |
+-------------+------+
| account_id  | int  |
| income      | int  |
+-------------+------+
account_id is the primary key (column with unique values) for this table.
Each row contains information about the monthly income for one bank account.
 

Write a solution to calculate the number of bank accounts for each salary category. The salary categories are:

"Low Salary": All the salaries strictly less than $20000.
"Average Salary": All the salaries in the inclusive range [$20000, $50000].
"High Salary": All the salaries strictly greater than $50000.
The result table must contain all three categories. If there are no accounts in a category, return 0.

Return the result table in any order. */

with sallary as 
(select *, case 
when income<20000 then 'Low Salary' 
when income between 20000 and 50000 then 'Average Salary' 
when income>50000 then 'High Salary'  end as category
from accounts),
 categories AS (
select 'Low Salary' AS category
union all
select 'Average Salary'
union all
select 'High Salary')
select c.category,coalesce(count(s.category),0) as accounts_count
from categories c
left join sallary s
on c.category=s.category
group by c.category
order by c.category;
