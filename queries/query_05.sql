/* 5. List all the employees that become a member within a month of being employed */
SELECT EMPLOYEE.fName, EMPLOYEE.mName, EMPLOYEE.lName, EMPLOYEE.startDate
FROM EMPLOYEE, MEMBERCARD
WHERE EMPLOYEE.memberID = MEMBERCARD.memberID 
	AND TIMESTAMPDIFF(MONTH, EMPLOYEE.startDate, MEMBERCARD.startDate) < 1;



