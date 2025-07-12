/*1327. List the Products Ordered in a Period


Table: Products

+------------------+---------+
| Column Name      | Type    |
+------------------+---------+
| product_id       | int     |
| product_name     | varchar |
| product_category | varchar |
+------------------+---------+
product_id is the primary key (column with unique values) for this table.
This table contains data about the company's products.
 

Table: Orders

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| order_date    | date    |
| unit          | int     |
+---------------+---------+
This table may have duplicate rows.
product_id is a foreign key (reference column) to the Products table.
unit is the number of products ordered in order_date.
 

Write a solution to get the names of products that have at least 100 units ordered in February 2020 and their amount.

Return the result table in any order.

 */

with cte as (
select o.product_id,sum(o.unit) as unit
from orders o
where o.order_date between '2020-02-01' and '2020-02-29'
group by product_id
having sum(o.unit)>=100 )
select p.product_name,cte.unit
from products p
inner join cte
on p.product_id=cte.product_id

--- or
with Feb as (
    select product_id,unit
    from orders
    where order_date between '2020-02-01' and '2020-02-29'
),
FebOrder as (
    select product_id,sum(unit) as unit
    from Feb
    group by product_id
    having sum(unit)>=100
)
select product_name,FebOrder.unit
from FebOrder
inner join products p
on p.product_id=FebOrder.product_id
