SELECT * 
FROM parks_and_recreation.employee_demographics;

SELECT first_name, last_name, birth_date
age,
(age + 10) * 10
FROM parks_and_recreation.employee_demographics;
# PEMDAS

SELECT distinct first_name, gender
FROM parks_and_recreation.employee_demographics
;

SELECT *
FROM employee_demographics
WHERE first_name = 'Tom'
;

SELECT *
FROM employee_salary
WHERE salary >= 5000
;


SELECT *
FROM employee_salary
WHERE salary >= 5000
AND First_name = 'Ben'
;

SELECT *
FROM employee_salary
WHERE salary >= 5000
AND First_name = 'Ben' OR first_name = 'leslie'
;

SELECT *
FROM employee_salary
Where not dept_id = 1
;


SELECT *
FROM employee_salary
WHERE first_name like 'a%' AND dept_id like 4
;

SELECT *
FROM parks_departments
;

SELECT first_name, last_name
FROM employee_demographics
;

SELECT Distinct occupation
FROM employee_salary
;

SELECT *
FROM employee_demographics
WHERE age > 30
;

SELECT *
FROM employee_demographics
WHERE age > 25 
AND gender = 'female'
;


SELECT *
FROM employee_demographics
WHERE age < 20 
OR age > 60
;



SELECT *
FROM employee_demographics
WHERE NOT gender = 'male'
;


SELECT first_name
FROM employee_demographics
Where first_name like 'a%'
;

SELECT last_name
FROM employee_demographics
Where last_name like '%son'
;

SELECT *
FROM employee_demographics
Order by age 
;
SELECT *
FROM employee_demographics
Order by age DESC
;

SELECT *
FROM employee_demographics
Limit 3;

SELECT gender, COUNT(*) AS total_employees
FROM employee_demographics
GROUP BY gender;

-- Join

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
 ON dem. employee_id = sal. employee_id
 ;
SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
 ON dem. employee_id = sal. employee_id
;
SELECT *
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
	ON dem. employee_id = sal. employee_id;
    
SELECT *
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
 ;


SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS first_name_santa,
emp1.first_name AS last_name_santa,
emp2.employee_id AS emp_name,
emp2.first_name AS first_name_emp,
emp2.first_name AS last_name_emp
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
 ;
-- Union 

Select first_name, last_name
from employee_demographics
Union 
Select first_name, last_name
from employee_salary;


Select first_name, last_name, 'Old' AS label
from employee_demographics
Where age > 50
Union 
Select first_name, last_name, 'Highly Paid Employee' AS label
from employee_salary
Where salary > 70000
;


Select first_name, length (first_name)
from employee_demographics
order by 2;

SELECT *
FROM employee_demographics;

SELECT first_name, age 
FROM employee_demographics;

SELECT *
FROM employee_demographics
WHERE age > 30
;

SELECT first_name, last_name
FROM employee_demographics
WHERE gender = 'female';

SELECT distinct occupation
FROM employee_salary
;

SELECT COUNT(*) 
FROM employee_salary;

SELECT AVG (salary)
FROM employee_salary
;

SELECT min(age)
FROM employee_demographics;

SELECT *
FROM employee_demographics
ORDER BY age ASC
;

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employee_demographics;

SELECT CONCAT (first_name, ' ', last_name) AS full_name
FROM employee_demographics;


SELECT dem.first_name, dem.last_name, dem.age, sal.occupation, sal.salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
ON dem.employee_id = sal.employee_id
;

SELECT dem.dept_id, sal.department_name	
FROM employee_salary AS dem
JOIN parks_departments sal
ON dem.dept_id = sal.department_id
;

Select *
from  employee_salary;

Select *
from  parks_departments;


Select *
from  employee_salary
WHERE salary > 100000
;

Select first_name, last_name, (60 - age) AS years_to_retire
from employee_demographics
;

SELECT dem.gender, AVG(sal.salary) AS average_salary
FROM employee_demographics AS dem
JOIN employee_salary AS sal
ON dem.employee_id = sal.employee_id
GROUP BY dem.gender;

select first_name, 
last_name,
case
	When age <=30 then 'Yound'
    When age Between 31 and 50 Then 'Old'
    when age >= 50 then 'death end'
End as age_barcket
from employee_demographics
;

Select first_name, last_name, salary,
Case
	When salary < 50000 then salary + (salary * 0.05 )
    When salary > 50000 then salary + (salary * 0.07 )
End As new_salary,
Case
	When dept_id = 6 Then salary * .10
End As finance
From employee_salary
;

Select *
From employee_demographics
Where employee_id IN
		(Select employee_id
        From employee_salary
        Where dept_id = 1)
;


Select first_name, salary, 
(Select AVG(salary)
From employee_salary)
From employee_salary;

Select gender, Avg(age), Max(age), Min(age), Count(age)
from employee_demographics
group by gender;
 
 
Select gender, AVG(salary)
From employee_demographics As dem
Join employee_salary As sal
	On dem.employee_id = sal.employee_id
Group by gender;

--- windows function

Select dem.first_name, dem.last_name,gender, AVG(salary) Over (partition by gender)
From employee_demographics As dem
Join employee_salary As sal
	On dem.employee_id = sal.employee_id;


Select dem.first_name, dem.last_name,gender, salary,
sum(salary) Over (partition by gender Order by dem.employee_id) AS Rolling_Total
From employee_demographics As dem
Join employee_salary As sal
	On dem.employee_id = sal.employee_id;


Select dem.first_name, dem.last_name,gender, salary,
row_number()over(partition by gender order by salary)
From employee_demographics As dem
Join employee_salary As sal
	On dem.employee_id = sal.employee_id;
    
    
With CTE_Example AS
(
select gender, AVG(salary) avg_sal, Max(salary) Max_sal, Min(salary) Min_sal, Count(salary) Count_sal
From employee_demographics As dem
Join employee_salary As sal
	On dem.employee_id = sal.employee_id
Group by gender
)
Select AVG(avg_sal)
From CTE_Example;


Select gender, Count(*) AS Total
From employee_demographics
Group by gender
;

Select *
From employee_salary
;

SELECT occupation, SUM(salary) AS total_salary
FROM employee_salary
GROUP BY occupation;

Select dept_id, AVG(salary) AS average_salary
From employee_salary
Group by dept_id
;

Select age, Count(*) AS age_group
From employee_demographics
Group by age
;

Select dept_id, count(*) AS total_EPD
From employee_salary
Group by dept_id
Order by total_EPD DESC
;

Select gender, AVG(age) AS average_age
From employee_demographics
group by gender
order by  average_age ASC
;

Select occupation, avg(salary) AS average_salary, Sum(salary) AS Total_salary
From employee_salary
group by occupation
;

Select dept_id, count(distinct occupation) AS unique_occ
From employee_salary
group by dept_id
order by unique_occ
;

Select dept_id, MAX(salary)
From employee_salary
group by dept_id
order by dept_id
;

Select dept_id, sum(employee_id) AS emp_dept
From employee_salary
Group by dept_id
Having employee_id > 5
;
-- mistrake 

SELECT dept_id, COUNT(*) AS emp_dept
FROM employee_salary
GROUP BY dept_id
HAVING COUNT(*) > 5;

Select occupation, sum(salary) AS total_salary
from employee_salary
group by occupation
having sum(salary) > 1000
;

select age, count(*)
from employee_demographics
group by age
having count(*) >= 2
;

Select dept_id, AVG(salary)
from employee_salary
Group by dept_id
Having AVG(salary) < 300000
order by AVG(salary)
limit 3
;

Select dem.employee_id, age, salary
from employee_demographics AS dem
Join employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;
Select *
from employee_salary;

Select *
from parks_departments;



Select dem.first_name, occupation, department_id
from employee_demographics AS dem
inner Join employee_salary AS sal
	ON dem.employee_id = sal.employee_id
inner Join parks_departments AS pd
	ON sal.dept_id = pd.department_name;

Select dem.first_name, occupation, department_id
from employee_demographics AS dem
inner Join employee_salary AS sal
	ON dem.employee_id = sal.employee_id
inner Join parks_departments AS pd
	ON sal.dept_id = pd.department_id;



SELECT dem.first_name || ' ' || dem.last_name AS full_name,
       sal.occupation,
       pd.name AS department_name
FROM employee_demographics AS dem
JOIN employee_salary AS sal
  ON dem.employee_id = sal.employee_id
JOIN parks_departments AS pd
  ON sal.dept_id = pd.department_id;



select dem.first_name, dem.last_name, salary
from employee_demographics AS dem
Join employee_salary AS sal
	ON dem.first_name = sal.first_name
Where dem.first_name = 'leslie'
;


Select first_name, last_name, salary, occupation,
CASE
	when salary < 50000 then salary + (salary * 0.05)
    when salary > 50000 then salary + (salary * 0.07)
End AS salary_update,
CASE
	when dept_id = 6 then salary + (salary * 0.1)
END As bonus
from employee_salary
;

select *
from employee_salary;

With CTE_example as
(
select gender, AVG(salary) avg_sal, Max(salary) max_sal, Min(salary) min_sal, Count(salary) count_sal
From employee_demographics dem
join employee_salary sal
	On dem.employee_id = sal.employee_id
group by gender
)
Select AVG(avg_sal)
From Cte_example
;

Create procedure large_salaries()
Select *
From employee_salary
Where salary >=50000
;

Call large_salaries();











