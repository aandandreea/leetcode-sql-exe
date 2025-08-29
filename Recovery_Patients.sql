/* 3586. Find COVID Recovery Patients

Table: patients

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| patient_id  | int     |
| patient_name| varchar |
| age         | int     |
+-------------+---------+
patient_id is the unique identifier for this table.
Each row contains information about a patient.
Table: covid_tests

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| test_id     | int     |
| patient_id  | int     |
| test_date   | date    |
| result      | varchar |
+-------------+---------+
test_id is the unique identifier for this table.
Each row represents a COVID test result. The result can be Positive, Negative, or Inconclusive.
Write a solution to find patients who have recovered from COVID - patients who tested positive but later tested negative.

A patient is considered recovered if they have at least one Positive test followed by at least one Negative test on a later date
Calculate the recovery time in days as the difference between the first positive test and the first negative test after that positive test
Only include patients who have both positive and negative test results
Return the result table ordered by recovery_time in ascending order, then by patient_name in ascending order.*/

with positive_tests as (
    select patient_id, test_date,
           row_number() over (partition by patient_id order by test_date asc) as rn
    from covid_tests
    where result = 'positive'
),
negative_tests as (
    select patient_id, test_date,
           row_number() over (partition by patient_id order by test_date asc) as rank
    from covid_tests
    where result = 'negative'
)
select 
    p.patient_id,
    p.patient_name,
    p.age,
    (n.test_date - pt.test_date) as recovery_time
from patients p
inner join positive_tests pt 
    on p.patient_id = pt.patient_id and pt.rn = 1
inner join negative_tests n 
    on pt.patient_id = n.patient_id and n.rank = 1 
   and n.test_date > pt.test_date
order by n.test_date - pt.test_date, p.patient_name;
