/* 1731. The Number of Employees Which Report to Each Employee

Table: Employees

+-------------+----------+
| Column Name | Type     |
+-------------+----------+
| employee_id | int      |
| name        | varchar  |
| reports_to  | int      |
| age         | int      |
+-------------+----------+
employee_id is the column with unique values for this table.
This table contains information about the employees and the id of the manager they report to. Some employees do not report to anyone (reports_to is null). 
 

For this problem, we will consider a manager an employee who has at least 1 other employee reporting to them.

Write a solution to report the ids and the names of all managers, the number of employees who report directly to them, and the average age of the reports rounded to the nearest integer.

Return the result table ordered by employee_id.*/

select e1.employee_id,e1.name,count(e2.employee_id) as reports_count,round(avg(e2.age)) as average_age
from employees e1
inner join employees e2
on e1.employee_id=e2.reports_to
group by e1.employee_id,e1.name
order by e1.employee_id;
