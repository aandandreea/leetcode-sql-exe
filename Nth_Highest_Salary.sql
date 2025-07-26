/* 177. Nth Highest Salary

Table: Employee

+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
 

Write a solution to find the nth highest distinct salary from the Employee table. If there are less than n distinct salaries, return null.*/
CREATE OR REPLACE FUNCTION NthHighestSalary(N INT) RETURNS TABLE (Salary int) AS $$
BEGIN
  RETURN QUERY ( 
   with cte as (select dense_rank() over ( order by s.salary desc ) as rank,s.salary
from (
   select distinct e.salary from employee e ) as s )
   select cte.salary
  from cte
  where rank=n
      
 );
END;
$$ LANGUAGE plpgsql;
