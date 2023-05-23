/*  This view returns First Name, Last Name, and Membership Start Date of 
    the 3 members who achieved top 3 total consumptions in the past 1 year. 
*/
CREATE VIEW ANNUAL_TOP_MEMBERS AS 
SELECT MEMBERCARD.memberID, CUSTOMER.fName, CUSTOMER.lName, MEMBERCARD.startDate, CUSTOMER_TOTALS.total as totalConsumption
FROM CUSTOMER, MEMBERCARD,
( 
	SELECT customerID, SUM(PAYMENT.amount) as total from C_ORDER, PAYMENT 
    WHERE C_ORDER.orderID = PAYMENT.orderID AND TIMESTAMPDIFF(YEAR, PAYMENT.paymentTime, current_date()) < 1
    GROUP BY customerID 
) AS CUSTOMER_TOTALS
WHERE CUSTOMER_TOTALS.customerID = CUSTOMER.customerID AND MEMBERCARD.memberID = CUSTOMER.memberID AND CUSTOMER.memberID IS NOT NULL 
ORDER BY CUSTOMER_TOTALS.total DESC 
LIMIT 3;
