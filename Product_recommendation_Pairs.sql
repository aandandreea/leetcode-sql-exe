/* 3521. Find Product Recommendation Pairs

Table: ProductPurchases

+-------------+------+
| Column Name | Type | 
+-------------+------+
| user_id     | int  |
| product_id  | int  |
| quantity    | int  |
+-------------+------+
(user_id, product_id) is the unique key for this table.
Each row represents a purchase of a product by a user in a specific quantity.
Table: ProductInfo

+-------------+---------+
| Column Name | Type    | 
+-------------+---------+
| product_id  | int     |
| category    | varchar |
| price       | decimal |
+-------------+---------+
product_id is the primary key for this table.
Each row assigns a category and price to a product.
Amazon wants to implement the Customers who bought this also bought... feature based on co-purchase patterns. Write a solution to :

Identify distinct product pairs frequently purchased together by the same customers (where product1_id < product2_id)
For each product pair, determine how many customers purchased both products
A product pair is considered for recommendation if at least 3 different customers have purchased both products.

Return the result table ordered by customer_count in descending order, and in case of a tie, by product1_id in ascending order, and then by product2_id in ascending order.*/

with cte as (
    select distinct p.product_id as product1_id,t.product_id as product2_id,count(p.user_id) as customer_count
from ProductPurchases p
 join ProductPurchases t
on p.user_id=t.user_id
where p.product_id<t.product_id
group by p.product_id,t.product_id
having count(distinct p.user_id)>=3
order by p.product_id,t.product_id ),
cte2 as ( 
    select product1_id,product2_id,inf.category as product1_category,info.category as product2_category,cte.customer_count
from cte
join ProductInfo inf
on cte.product1_id=inf.product_id 
join ProductInfo info 
on cte.product2_id=info.product_id
)
select *
from cte2
order by customer_count desc, product1_id, product2_id;
