/* Find all the employees who work in the ‘Human Resources’ department.*/

SELECT *
FROM employees 
WHERE department = 'Human Resources';


/*Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department.*/

SELECT
first_name,
last_name,
country
FROM employees 
WHERE department = 'Legal';

/*Count the number of employees based in Portugal.*/

SELECT 
COUNT(*) AS emp_portugal
FROM employees 
WHERE country = 'Portugal';

/*Count the number of employees based in either Portugal or Spain.*/

SELECT 
COUNT (*) AS emp_portugal_spain
FROM employees 
WHERE country = 'Portugal' OR country = 'Spain';


/*Count the number of pay_details records lacking a local_account_no.*/

SELECT 
COUNT(*) AS pd_lack_acc_no
FROM pay_details 
WHERE local_account_no IS NULL;


/* Get a table with employees first_name and last_name ordered alphabetically by last_name (put any NULLs last).*/

SELECT 
first_name,
last_name
FROM employees 
ORDER BY last_name ASC NULLS LAST;



/*How many employees have a first_name beginning with ‘F’?*/

SELECT 
COUNT(*) AS name_begin_F
FROM employees 
WHERE first_name = 'F%';

SELECT *
FROM employees 
WHERE first_name = 'F%';


/*Count the number of pension enrolled employees not based in either France or Germany.*/


SELECT *
FROM employees 
WHERE pension_enrol = 'TRUE' AND
	  country NOT IN ('France','Germany');
	 
SELECT 
COUNT(*) AS pension_allexcept_france_germany
FROM employees 
WHERE pension_enrol = 'TRUE' AND
	  (country NOT IN ('France','Germany'));
