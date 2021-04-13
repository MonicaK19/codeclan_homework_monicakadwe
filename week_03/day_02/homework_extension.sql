/*Question 5.How many of the employees serve on one or more committees? RIGHT INCLUSIVE*/


SELECT
c.name,
COUNT(e.id) AS num_emp
FROM
(employees AS e
INNER JOIN employees_committees AS ec
ON e.id= ec.employee_id)
INNER JOIN committees AS c
ON c.id = ec.committee_id 
GROUP BY(c.name); 




/*Question 6.
How many of the employees do not serve on a committee? LEFT EXCLUSIVE*/


SELECT
e.id
FROM
employees AS e
LEFT OUTER JOIN employees_committees AS ec
ON e.id = ec.employee_id
WHERE ec.employee_id IS NULL;
 


/*SELECT 
id 
FROM employees 
WHERE
NOT EXISTS
(SELECT 
ec.employee_id
FROM employees AS e
INNER JOIN employees_committees AS ec
ON e.id = ec.employee_id);

SELECT 
ec.employee_id
FROM employees AS e
LEFT JOIN employees_committees AS ec
ON e.id = ec.employee_id;*/

