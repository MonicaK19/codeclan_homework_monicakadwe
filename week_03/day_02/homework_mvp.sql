/*MVP*/
/* Question 1.(a). Find the first name, last name and team name of employees who are members of teams. */

SELECT
e.first_name,
e.last_name,
t.name
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id; 

/*Question 1.(b). Find the first name, last name and team name of employees who are members of teams and are enrolled in the pension scheme.*/

SELECT
e.first_name,
e.last_name,
t.name,
e.pension_enrol
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
WHERE e.pension_enrol = TRUE;


/*Question 1.(c). Find the first name, last name and team name of employees who are members of teams, where their team has a charge cost greater than 80.*/

SELECT
e.first_name,
e.last_name,
t.name,
t.charge_cost 
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
WHERE CAST(t.charge_cost AS NUMERIC) > 80
ORDER BY t.charge_cost DESC;


/*Question 2.(a). Get a table of all employees details, together with their local_account_no and local_sort_code, if they have them.*/

SELECT 
e.*,
pd.local_account_no ,
pd.local_sort_code 
FROM employees AS e
LEFT JOIN pay_details AS pd
ON e.pay_detail_id = pd.id;


/* Question 2.(b). Amend your query above to also return the name of the team that each employee belongs to*/

SELECT 
e.* ,
pd.local_account_no ,
pd.local_sort_code,
t.name
FROM 
employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id 
LEFT JOIN pay_details AS pd
ON e.pay_detail_id = pd.id;


/*Question 3.(a). Make a table, which has each employee id along with the team that employee belongs to.*/

SELECT 
e.id,
t.name
FROM employees AS e
RIGHT JOIN teams AS t
ON e.team_id = t.id;


/* Question 3.(b). Breakdown the number of employees in each of the teams*/

SELECT 
t.name,
COUNT(e.id) AS emp_num
FROM employees AS e
RIGHT JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.name;

/*Question 3.(c). Order the table above by so that the teams with the least employees come first.*/

SELECT 
t.name,
COUNT(e.id) AS emp_num
FROM employees AS e
RIGHT JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.name
ORDER BY emp_num ASC;


/*Question 4.(a). Create a table with the team id, team name and the count of the number of employees in each team.*/


SELECT 
t.id,
t.name,
COUNT (e.id) AS num_emp
FROM
teams AS t
LEFT JOIN employees AS e
ON e.team_id = t.id 
GROUP BY t.id,t.name;



/*Question 4.(b). The total_day_charge of a team is defined as the charge_cost of the team multiplied by the number of employees in the team. 
 * Calculate the total_day_charge for each team.*/


SELECT 
t.name,
t.charge_cost,
COUNT(e.id) AS emp_num,
(CAST(t.charge_cost AS numeric)) * (COUNT(e.id)) AS total_day_charge
FROM employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id
/*GROUP BY t.name,t.charge_cost ;*/
GROUP BY t.id;


/*(c). How would you amend your query from above to show only those teams with a total_day_charge greater than 5000?*/

SELECT
*
FROM
(
SELECT 
t.name,
t.charge_cost,
COUNT(e.id) AS emp_num,
((CAST(t.charge_cost AS numeric)) * (COUNT(e.id))) AS total_day_charge 
FROM (employees AS e
INNER JOIN teams AS t
ON e.team_id = t.id) 
/*GROUP BY t.name,t.charge_cost ;*/
/*WHERE ((CAST(t.charge_cost AS numeric)) * (COUNT(e.id))) > 5000*/
GROUP BY t.id
) AS temp1
WHERE temp1.total_day_charge > 5000;



















