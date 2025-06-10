select distinct project_id,
avg(e.experience_years) as average_years
from project p
inner join employee e
on p.employee_id=e.employee_id
group by project_id;
