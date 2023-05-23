/* Find the names of employees who are also a member of the mall. */

SELECT EMPLOYEE.fName, EMPLOYEE.mName, EMPLOYEE.lName
FROM EMPLOYEE
JOIN MEMBER ON EMPLOYEE.memberID = MEMBER.memberID;
