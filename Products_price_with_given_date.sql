/*
1164. Product Price at a Given Date
Table: Products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| new_price     | int     |
| change_date   | date    |
+---------------+---------+
(product_id, change_date) is the primary key (combination of columns with unique values) of this table.
Each row of this table indicates that the price of some product was changed to a new price at some date.
Initially, all products have price 10.

Write a solution to find the prices of all products on the date 2019-08-16.

Return the result table in any order.*/
select p.product_id,
coalesce(
    (select new_price from products where product_id = p.product_id AND change_date <= '2019-08-16' order by change_date desc limit 1)
    ,
    10
) as price 
from (select distinct product_id from products) p;
