/*1 MVP


Question 1.
Are there any pay_details records lacking both a local_account_no and iban number?*/

SELECT 
	*
FROM 
	pay_details 
WHERE 
	iban IS NULL OR 
	local_account_no IS NULL;


SELECT 
	*
FROM 
	pay_details 
WHERE 
	iban IS NULL AND 
	local_account_no IS NULL;



/*Question 2.
Get a table of employees first_name, last_name and country, ordered alphabetically first by country and then by last_name (put any NULLs last).*/


SELECT 
	first_name,last_name, country 
FROM 
	employees 
ORDER BY 
	country ASC,
	last_name ASC NULLS LAST;


/*Question 3.
Find the details of the top ten highest paid employees in the corporation.*/

SELECT
	id,first_name,last_name,salary 
FROM 
	employees 
ORDER BY 
	salary DESC NULLS LAST
LIMIT 10;


/*Question 4.
Find the first_name, last_name and salary of the lowest paid employee in Hungary.*/

SELECT
	first_name, last_name, salary, country 
FROM 
	employees 
WHERE 
	country = 'Hungary'
ORDER BY 
	salary ASC NULLS LAST;


/*Question 5.
Find all the details of any employees with a ‘yahoo’ email address?*/

SELECT 
	* 
FROM
	employees
WHERE
	email LIKE CONCAT('%','yahoo', '%');


/*Question 6.
Obtain a count by department of the employees who started work with the corporation in 2003.*/

SELECT
	COUNT(id),
	department 
FROM 
	employees 
WHERE
	start_date BETWEEN '2013-01-01' AND '2013-12-31'
GROUP BY department;


/*
Question 7.
Obtain a table showing department, fte_hours and the number of employees in each department who work each fte_hours pattern. 
Order the table alphabetically by department, and then in ascending order of fte_hours.
*/

SELECT
	department, fte_hours, 
	COUNT(id) AS emp_num
FROM
	employees
GROUP BY 
	department, fte_hours
ORDER BY department  ASC NULLS LAST;


/*Question 8.
Provide a breakdown of the numbers of employees enrolled, not enrolled, and with unknown enrollment status in the corporation pension scheme.*/

SELECT
	pension_enrol, 
	COUNT(id) AS pension_count
FROM 
	employees 
GROUP BY 
	pension_enrol
ORDER BY
	pension_enrol; 



/*Question 9.
What is the maximum salary among those employees in the ‘Engineering’ department who work 1.0 full-time equivalent hours (fte_hours)?*/

SELECT
    MAX(salary)
FROM 
	employees 
WHERE 
	department = 'Engineering' AND 
	fte_hours = 1;



/*
Question 10.
Get a table of country, number of employees in that country, and the average salary of employees in that country for any countries in which more than 30 employees are based.
Order the table by average salary descending.
*/

SELECT
	country,
	COUNT(id) AS emp_num,
	AVG(salary) AS avg_salary
FROM 
	employees
GROUP BY
	country
HAVING COUNT(id) > 30
ORDER BY avg_salary DESC;


/*
Question 11.
Return a table containing each employees first_name, last_name, full-time equivalent hours (fte_hours), salary, and a new column effective_yearly_salary 
which should contain fte_hours multiplied by salary.
*/

SELECT
	first_name,
	last_name,
	fte_hours,
	salary,
	fte_hours * salary AS effective_yearly_salary
FROM 
	employees 
ORDER BY effective_yearly_salary DESC NULLS LAST; 


/*Question 12.
Find the first name and last name of all employees who lack a local_tax_code.*/

SELECT
e.first_name,
e.last_name, 
pd.local_tax_code 
FROM 
	employees AS e
FULL OUTER JOIN
	pay_details AS pd
ON
	pd.id = e.pay_detail_id
WHERE
	pd.local_tax_code IS NULL; 


/*Question 13.
The expected_profit of an employee is defined as (48 * 35 * charge_cost - salary) * fte_hours, where charge_cost depends upon the team to which the employee belongs. 
Get a table showing expected_profit for each employee.*/

SELECT
e.first_name,
e.last_name, 
t.name AS team,
e.fte_hours,
t.charge_cost, 
(48*35*(CAST(t.charge_cost AS INTEGER)))* e.fte_hours  AS expected_profit
FROM 
	employees AS e
INNER JOIN 
	teams AS t
ON
	e.team_id = t.id;


/*Question 14.
Obtain a table showing any departments in which there are two or more employees lacking a stored first name. 
Order the table in descending order of the number of employees lacking a first name, and then in alphabetical order by department.*/


SELECT
	COUNT(id) AS emp_count,
	department
FROM
	employees 
WHERE 
	first_name IS NULL
GROUP BY department
ORDER BY department ASC;


/*Question 15.
[Bit Tougher] 
Return a table of those employee first_names shared by more than one employee, together with a count of the number of times each first_name occurs. 
Omit employees without a stored first_name from the table. 
Order the table descending by count, 
and then alphabetically by first_name.*/



SELECT
	first_name,
	COUNT(first_name) AS count_first_name
FROM 
	employees 
WHERE
	first_name IS NOT NULL
GROUP BY 
	first_name 
ORDER BY 
	count_first_name DESC NULLS LAST,
	first_name ASC NULLS LAST;


/*Question 16.
[Tough] Find the proportion of employees in each department who are grade 1.*/

/*Hints
Think of the desired proportion for a given department as the number of employees in that department who are grade 1,
divided by the total number of employees in that department.
You can write an expression in a SELECT statement, e.g. grade = 1. This would result in BOOLEAN values.
If you could convert BOOLEAN to INTEGER 1 and 0, you could sum them. The CAST() function lets you convert data types.
In SQL, an INTEGER divided by an INTEGER yields an INTEGER. To get a REAL value, you need to convert the top, bottom or both sides of the division to REAL.*/


/*part 1*/

SELECT
	department, 
	COUNT(id) AS emp_count_deptwise
FROM 
	employees
GROUP BY 
	department;


/*part 2*/
SELECT
	department,	
	COUNT(id) AS emp_count_deptwise_grade1
FROM 
	employees 
WHERE 
	grade = 1
GROUP BY department;



/*another attempt*/
SELECT 
	department,
	(count(id)/ (SELECT COUNT(id) AS emp_count_deptwise FROM employees GROUP BY department) as (proportion integer))
FROM employees 
WHERE grade = 1 AND department = department 
group by department;


/*attempt 3*/


WITH abc AS (
SELECT
	department,	
	COUNT(id) AS emp_count_deptwise_grade1
FROM 
	employees 
WHERE 
	grade = 1
GROUP BY department
)

SELECT
abc.department,
e.department, 
abc.emp_count_deptwise_grade1,
COUNT(e.id),
abc.emp_count_deptwise_grade1/CAST(COUNT(e.id) AS REAL) AS proportion
FROM employees AS e 
INNER JOIN abc
ON e.department = abc.department
GROUP BY e.department,abc.department,abc.emp_count_deptwise_grade1


/*abc.emp_count_deptwise_grade1/CAST(COUNT(e.id) AS REAL) AS proportion */







