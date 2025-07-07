/*1321. Restaurant Growth

Table: Customer

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| customer_id   | int     |
| name          | varchar |
| visited_on    | date    |
| amount        | int     |
+---------------+---------+
In SQL,(customer_id, visited_on) is the primary key for this table.
This table contains data about customer transactions in a restaurant.
visited_on is the date on which the customer with ID (customer_id) has visited the restaurant.
amount is the total paid by a customer.
 

You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

Compute the moving average of how much the customer paid in a seven days window (i.e., current day + 6 days before). average_amount should be rounded to two decimal places.

Return the result table ordered by visited_on in ascending order. */

with daily as 
( 
    select visited_on,sum(amount) as amount
    from customer 
    group by visited_on
)
select d1.visited_on,sum(d2.amount) as amount,round(avg(d2.amount),2) as average_amount
from daily d1
inner join daily d2
on d2.visited_on between d1.visited_on - interval '6 days' and d1.visited_on
group by d1.visited_on
having count(d2.visited_on)=7
order by d1.visited_on;
