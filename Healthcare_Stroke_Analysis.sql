create database Project3;

select * from General_Details_table;

select * from Risk_Factors_Table;

--data cleaning 
--check nulls

select * from Risk_Factors_Table
where bmi is null;

--count nulls

select count(*) 
from Risk_Factors_Table
where bmi is null;

select avg(bmi) as avg 
from Risk_Factors_Table;

SELECT DISTINCT
PERCENTILE_CONT(0.5)
WITHIN GROUP (ORDER BY bmi)
OVER () AS MedianBMI
FROM Risk_Factors_Table;

UPDATE Risk_Factors_Table
SET bmi =
(
    SELECT AVG(bmi)
    FROM Risk_Factors_Table
)
WHERE bmi IS NULL;

--join table

select *
from General_Details_table as g
join Risk_Factors_Table as r
on g.id=r.Patient_id;

--total patients

select count(*) as total_patients
from General_Details_table;

--total stroke cases

select count(*) 
from Risk_Factors_Table
where stroke=1;

--stroke percentage

select
round(100.0 * sum(stroke)/count(*),2) as Strokerate
from Risk_Factors_Table;

--gender wise stroke analysis

select
g.gender,
count(*) as patients,
sum(r.stroke) as strokerate
from General_Details_table as g
join Risk_Factors_Table as r
on g.id=r.Patient_id
group by g.gender;

--age wise stroke analysis

select
case
	when g.age<20 then '0-20'
	when g.age<40 then '21-40'
	when g.age<60 then '41-60'
	else '60+'
end as age_group,
count(*) as patients,
sum(r.stroke) as strokecases
from General_Details_table g
join Risk_Factors_Table r
on g.id=r.Patient_id
group by 
case 
	when g.age<20 then '0-20'
	when g.age<40 then '21-40'
	when g.age<60 then '41-60'
	else '60+'
end;


--smoking impact

select
smoking_status,
count(*) as patients,
sum(stroke) as strokecases
from Risk_Factors_Table
group by smoking_status;

--hypertension impact

select
hypertension,
count(*) as patients,
sum(stroke) as strokecases
from Risk_Factors_Table
group by hypertension;

--heart disease impact

select
heart_disease,
count(*) as patients,
sum(stroke) as strokecases
from Risk_Factors_Table
group by heart_disease;

--top risk factors

select
avg(avg_glucose_level) AvgGlucose,
avg(bmi) avgbmi
from Risk_Factors_Table;