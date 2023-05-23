/* 8. Find the floor staff who have taken charge of all the floors in the past 1 week */

SELECT EMPLOYEE.fName, EMPLOYEE.mName, EMPLOYEE.lName 
FROM EMPLOYEE,
(
	SELECT MANAGE_FLOOR.floorstaffID as employeeID, COUNT(DISTINCT MANAGE_FLOOR.floorNum) as floorCount
	FROM MANAGE_FLOOR 
    WHERE DATEDIFF(current_date(), MANAGE_FLOOR.assignedDate) <= 7
	GROUP BY MANAGE_FLOOR.floorstaffID
) AS FLOORSTAFF_COUNT,
(
	SELECT COUNT(floorNum) as numFloors FROM MALL_FLOOR
) AS NUM_FLOORS
WHERE FLOORSTAFF_COUNT.floorCount = NUM_FLOORS.numFloors AND EMPLOYEE.employeeID = FLOORSTAFF_COUNT.employeeID;

