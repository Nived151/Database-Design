/* 12. Find the store that produces the most amount of sale in the past 1 week. */
/* 
    First, we total up the amount of sales in the past 7 days for each store (STORE_TOTAL table).
    Then, we find the max of the total sales for each store.
    Finally, we return the store(s) whose total amounts is equal to the maximum total sales in the past 7 days.
*/
SELECT STORE.storeName, STORE_TOTAL.totalAmount FROM STORE, 
(
	SELECT STORE_AMOUNT.storeID, SUM(STORE_AMOUNT.amount) as totalAmount FROM 
	(
		SELECT DISTINCT(PAYMENT.paymentID) as paymentID, PAYMENT.amount as amount, STORE.storeID as storeID FROM PAYMENT, ORDER_PRODUCT, STORE
		WHERE datediff(current_date(), PAYMENT.paymentTime) <= 7 AND ORDER_PRODUCT.orderID = PAYMENT.orderID AND ORDER_PRODUCT.storeID = STORE.storeID 
	) AS STORE_AMOUNT
	GROUP BY STORE_AMOUNT.storeID
) AS STORE_TOTAL, 
(
	SELECT MAX(totalAmount) maxAmount FROM (
		SELECT STORE_AMOUNT.storeID, SUM(STORE_AMOUNT.amount) as totalAmount FROM 
		(
			SELECT DISTINCT(PAYMENT.paymentID) as paymentID, PAYMENT.amount as amount, STORE.storeID as storeID FROM PAYMENT, ORDER_PRODUCT, STORE
			WHERE datediff(current_date(), PAYMENT.paymentTime) <= 7 AND ORDER_PRODUCT.orderID = PAYMENT.orderID AND ORDER_PRODUCT.storeID = STORE.storeID 
		) AS STORE_AMOUNT
		GROUP BY STORE_AMOUNT.storeID
	) AS STORE_TOTAL_2 
) AS MAX_AMOUNT
WHERE STORE_TOTAL.totalAmount = MAX_AMOUNT.maxAmount AND STORE_TOTAL.storeID = STORE.storeID;

