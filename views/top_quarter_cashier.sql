/* 
    Top-Quarter-Cashier: This view returns the information of the cashier who has dealt
    with the most number of orders in the past 3 months.
*/

CREATE VIEW TOP_QUARTER_CASHIER AS 
SELECT EMPLOYEE.employeeID, EMPLOYEE.fName, EMPLOYEE.mName, EMPLOYEE.lName, PAYMENT_COUNT.paymentCount as numOrders
FROM EMPLOYEE,
(
	SELECT MAKE_PAYMENT.cashierID, COUNT(MAKE_PAYMENT.paymentID) as paymentCount FROM MAKE_PAYMENT, PAYMENT
	WHERE MAKE_PAYMENT.paymentID = PAYMENT.paymentID AND TIMESTAMPDIFF(MONTH, PAYMENT.paymentTime, current_date()) < 3
	GROUP BY cashierID
) AS PAYMENT_COUNT,
(
	SELECT MAX(paymentCount) as maxCount FROM 
    (
		SELECT MAKE_PAYMENT.cashierID, COUNT(MAKE_PAYMENT.paymentID) as paymentCount FROM MAKE_PAYMENT, PAYMENT
		WHERE MAKE_PAYMENT.paymentID = PAYMENT.paymentID AND TIMESTAMPDIFF(MONTH, PAYMENT.paymentTime, current_date()) < 3
		GROUP BY cashierID
	) AS PAYMENT_COUNT_2
) AS MAX_COUNT
WHERE PAYMENT_COUNT.paymentCount = MAX_COUNT.maxCount AND EMPLOYEE.employeeID = PAYMENT_COUNT.cashierID;
