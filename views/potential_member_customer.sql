/* Potential-Member-Customer: This view returns the information of the customers
 (not a member yet) who have placed orders more than 10 times in the past 1 month.*/
 

CREATE VIEW Potential_Member_Customer AS
SELECT C.customerID, C.fName, C.mName, C.lName, COUNT(O.orderID) AS NumOrders
FROM CUSTOMER C
JOIN C_ORDER O ON C.customerID = O.customerID
WHERE TIMESTAMPDIFF(MONTH, O.createdTime, current_date()) < 1 AND C.memberID IS NULL
GROUP BY C.customerID, C.fName, C.mName, C.lName
HAVING COUNT(O.orderID) > 10;
