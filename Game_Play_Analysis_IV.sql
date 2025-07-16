/* 550. Game Play Analysis IV
Solved
Medium

Topics
premium lock icon
Companies
SQL Schema
Pandas Schema
Table: Activity

+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| player_id    | int     |
| device_id    | int     |
| event_date   | date    |
| games_played | int     |
+--------------+---------+
(player_id, event_date) is the primary key (combination of columns with unique values) of this table.
This table shows the activity of players of some games.
Each row is a record of a player who logged in and played a number of games (possibly 0) before logging out on someday using some device.
Write a solution to report the fraction of players that logged in again on the day after the day they first logged in, rounded to 2 decimal places.
In other words, you need to determine the number of players who logged in on the day immediately following their initial login, and divide it by the number of total players.*/
with cte as (
    select player_id,min(event_date) as first_day
    from activity 
    group by player_id
),
 next_day as (
select activity.player_id
from activity 
inner join cte 
on cte.player_id=activity.player_id
where activity.event_date=cte.first_day+INTERVAL '1 day' )
