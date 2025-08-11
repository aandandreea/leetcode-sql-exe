/* 3497. Analyze Subscription Conversion 

Table: UserActivity

+------------------+---------+
| Column Name      | Type    | 
+------------------+---------+
| user_id          | int     |
| activity_date    | date    |
| activity_type    | varchar |
| activity_duration| int     |
+------------------+---------+
(user_id, activity_date, activity_type) is the unique key for this table.
activity_type is one of ('free_trial', 'paid', 'cancelled').
activity_duration is the number of minutes the user spent on the platform that day.
Each row represents a user's activity on a specific date.
A subscription service wants to analyze user behavior patterns. The company offers a 7-day free trial, after which users can subscribe to a paid plan or cancel. Write a solution to:

Find users who converted from free trial to paid subscription
Calculate each user's average daily activity duration during their free trial period (rounded to 2 decimal places)
Calculate each user's average daily activity duration during their paid subscription period (rounded to 2 decimal places)
Return the result table ordered by user_id in ascending order.*/

with cte1 as (
   select user_id,round(avg(case when activity_type='free_trial' then activity_duration else null end ),2) as trial_avg_duration
    from UserActivity 
    where activity_type in ('free_trial','paid')
    group by user_id 
    having count(distinct activity_type)=2
),
cte2 as ( 
select user_id,round(avg(case when activity_type='paid' then activity_duration else null end ),2) as paid_avg_duration
    from UserActivity
    where activity_type in ('free_trial','paid') 
    group by user_id
    having count(distinct activity_type)=2
) select cte1.user_id,trial_avg_duration,paid_avg_duration
from cte1
inner join cte2
on cte1.user_id=cte2.user_id
order by cte1.user_id
