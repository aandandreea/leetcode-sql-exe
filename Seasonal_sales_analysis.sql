/* 3564. Seasonal Sales Analysis

Table: sales

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| sale_id       | int     |
| product_id    | int     |
| sale_date     | date    |
| quantity      | int     |
| price         | decimal |
+---------------+---------+
sale_id is the unique identifier for this table.
Each row contains information about a product sale including the product_id, date of sale, quantity sold, and price per unit.
Table: products

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| product_id    | int     |
| product_name  | varchar |
| category      | varchar |
+---------------+---------+
product_id is the unique identifier for this table.
Each row contains information about a product including its name and category.
Write a solution to find the most popular product category for each season. The seasons are defined as:

Winter: December, January, February
Spring: March, April, May
Summer: June, July, August
Fall: September, October, November
The popularity of a category is determined by the total quantity sold in that season. If there is a tie, select the category with the highest total revenue (quantity × price).

Return the result table ordered by season in ascending order*/
with season_sales as (
    select 
        case 
            when extract(month from s.sale_date) in (12, 1, 2) then 'Winter'
            when extract(month from s.sale_date) in (3, 4, 5) then 'Spring'
            when extract(month from s.sale_date) in (6, 7, 8) then 'Summer'
            when extract(month from s.sale_date) in (9, 10, 11) then 'Fall'
        end as season,
        p.category,
        sum(s.quantity) as total_quantity,
        sum(s.quantity * s.price) as total_revenue
    from sales s
    join products p on s.product_id = p.product_id
    group by season, p.category
),
ranked as (
    select
        season,
        category,
        total_quantity,
        total_revenue,
        row_number() over (
            partition by season
            order by total_quantity desc, total_revenue desc
        ) as rn
    from season_sales
)
select 
    season,
    category,
    total_quantity,
    total_revenue
from ranked
where rn = 1
order by case season
            when 'Fall' then 1
            when 'Spring' then 2
            when 'Summer' then 3
            when 'Winter' then 4
         end;
