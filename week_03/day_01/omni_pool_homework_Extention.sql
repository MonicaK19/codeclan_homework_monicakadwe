/*The corporation wants to make name badges for a forthcoming conference. 
 Return a column badge_label showing employees’ first_name and last_name joined together with their department in the following style: ‘Bob Smith - Legal’. 
 Restrict output to only those employees with stored first_name, last_name and department.*/

SELECT 
first_name,
last_name,
department,
CONCAT(first_name, ' ', last_name, ' - ', department) AS badge_label
FROM employees 
WHERE first_name IS NOT NULL AND last_name IS NOT NULL;



/*One of the conference organisers thinks it would be nice to add the year of the employees’ start_date to the badge_label to celebrate long-standing colleagues, 
 * in the following style ‘Bob Smith - Legal (joined 1998)’. Further restrict output to only those employees with a stored start_date.
*/

SELECT 
first_name,
last_name,
department,
start_date,
CONCAT(first_name, ' ', last_name, ' - ', department, ' ','(joined ', EXTRACT(YEAR FROM start_date), ')') AS badge_label
FROM employees 
WHERE start_date IS NOT NULL;


