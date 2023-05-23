/* For each category of Employee, count the number of employees in that category, and the
average salary of that category.  */

SELECT jobPosition, COUNT(*) AS NumEmployees, AVG(salary) AS AvgSalary
FROM EMPLOYEE
GROUP BY jobPosition;