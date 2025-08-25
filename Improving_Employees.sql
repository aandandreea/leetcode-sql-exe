/* 
3580. Find Consistently Improving Employees

Table: employees

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| employee_id | int     |
| name        | varchar |
+-------------+---------+
employee_id is the unique identifier for this table.
Each row contains information about an employee.
Table: performance_reviews

+-------------+------+
| Column Name | Type |
+-------------+------+
| review_id   | int  |
| employee_id | int  |
| review_date | date |
| rating      | int  |
+-------------+------+
review_id is the unique identifier for this table.
Each row represents a performance review for an employee. The rating is on a scale of 1-5 where 5 is excellent and 1 is poor.
Write a solution to find employees who have consistently improved their performance over their last three reviews.

An employee must have at least 3 review to be considered
The employee's last 3 reviews must show strictly increasing ratings (each review better than the previous)
Use the most recent 3 reviews based on review_date for each employee
Calculate the improvement score as the difference between the latest rating and the earliest rating among the last 3 reviews
Return the result table ordered by improvement score in descending order, then by name in ascending order.*/

with last_three_reviews as (
    select 
        employee_id,
        rating,
        review_date,
        row_number() over (
            partition by employee_id
            order by review_date desc
        ) as rn
    from performance_reviews
),
filtered as (
    select *
    from last_three_reviews
    where rn <= 3
),
ordered as (
    select 
        employee_id,
        rating,
        review_date,
        row_number() over (partition by employee_id order by review_date) as ord
    from filtered
),
lagged as (
    select
        employee_id,
        rating,
        ord,
        lag(rating) over (partition by employee_id order by ord) as prev_rating
    from ordered
),
improvement_check as (
    select
        employee_id,
        sum(case when rating > prev_rating then 1 else 0 end) as increases,
        max(rating) filter (where ord = 3) as earliest_rating,
        max(rating) filter (where ord = 1) as latest_rating
    from lagged
    group by employee_id
)
select 
    e.employee_id,
    e.name,
    (latest_rating - earliest_rating) as improvement_score
from improvement_check ic
join employees e on e.employee_id = ic.employee_id
where increases = 2
order by improvement_score desc, e.name asc;
