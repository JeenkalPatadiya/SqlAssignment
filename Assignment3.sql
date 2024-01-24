--1).
SELECT * FROM
employee 
WHERE salary = (SELECT max(salary) FROM employee)

--2).
SELECT dept.dept_name
FROM dept
INNER JOIN employee
ON dept.dept_id = employee.dept_id
GROUP BY dept.dept_name
HAVING COUNT(*) < 3

--3)
SELECT COUNT(*),dept.dept_name
FROM employee INNER JOIN dept
ON employee.dept_id=dept.dept_id
GROUP BY dept_name


--4)
SELECT SUM(employee.salary),dept.dept_name
FROM employee INNER JOIN dept
ON employee.dept_id=dept.dept_id
GROUP BY dept_name


