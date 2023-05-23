/* 13. Find the employee that supervises the most number of floor staffs. */
/* 
    Since we store supervisor ID with each floor staff entry in FLOORSTAFF, we can count the floorstaffID and group by supervisorID (FLOORSTAFF_COUNT subquery).
    Then, we find the maximum count out of all counts (MAX_COUNT subquery).
    Finally, we return the employee info of the employee(s) whose supervising count is equal to the max count.
*/

SELECT EMPLOYEE.employeeID, EMPLOYEE.fName, EMPLOYEE.lName FROM EMPLOYEE,
(
	SELECT FLOORSTAFF.supervisorID as superID, COUNT(FLOORSTAFF.employeeID) as floorstaffCount FROM FLOORSTAFF GROUP BY FLOORSTAFF.supervisorID
) AS FLOORSTAFF_COUNT,
(
	SELECT MAX(FLOORSTAFF_COUNT_2.floorstaffCount) as maxCount FROM 
    (
		SELECT FLOORSTAFF.supervisorID, COUNT(FLOORSTAFF.employeeID) as floorstaffCount FROM FLOORSTAFF GROUP BY FLOORSTAFF.supervisorID
	) AS FLOORSTAFF_COUNT_2
) AS MAX_COUNT
WHERE FLOORSTAFF_COUNT.floorstaffCount = MAX_COUNT.maxCount AND FLOORSTAFF_COUNT.superID = EMPLOYEE.employeeID;
