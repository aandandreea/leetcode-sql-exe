/* 1341. Movie Rating

Table: Movies

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| title         | varchar |
+---------------+---------+
movie_id is the primary key (column with unique values) for this table.
title is the name of the movie.
 

Table: Users

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| name          | varchar |
+---------------+---------+
user_id is the primary key (column with unique values) for this table.
The column 'name' has unique values.
Table: MovieRating

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| movie_id      | int     |
| user_id       | int     |
| rating        | int     |
| created_at    | date    |
+---------------+---------+
(movie_id, user_id) is the primary key (column with unique values) for this table.
This table contains the rating of a movie by a user in their review.
created_at is the user's review date. 
 

Write a solution to:

Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. In case of a tie, return the lexicographically smaller movie name.*/

(select u.name as results
from users u 
inner join MovieRating m
on u.user_id=m.user_id
group by u.user_id,u.name
order by count(*) desc,u.name asc 
limit 1)
union all
(select title as results
from movies mov
inner join movierating m
on m.movie_id=mov.movie_id
where m.created_at between '2020-02-01' and '2020-02-29'
group by title,m.movie_id
order by avg(m.rating) desc,title asc
limit 1)
