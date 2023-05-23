/*  This view returns the information of the store that has the most number of
    distinct customers that placed order in the past 1 month 
*/
CREATE VIEW GOLD_STORE AS 
SELECT STORE.storeID, STORE.storeName, STORE.storeType, CUSTOMER_COUNTS.customerCount as distinctCustomers FROM STORE, 
(
	SELECT ORDER_PRODUCT.storeID, COUNT(DISTINCT C_ORDER.customerID) AS customerCount FROM C_ORDER, ORDER_PRODUCT 
	WHERE TIMESTAMPDIFF(MONTH, C_ORDER.createdTime, current_time()) < 1 AND ORDER_PRODUCT.orderID = C_ORDER.orderID
	GROUP BY ORDER_PRODUCT.storeID
) AS CUSTOMER_COUNTS,
(
	SELECT MAX(CUSTOMER_COUNTS_2.customerCount) AS maxCount FROM 
    (
		SELECT ORDER_PRODUCT.storeID, COUNT(DISTINCT C_ORDER.customerID) AS customerCount FROM C_ORDER, ORDER_PRODUCT 
		WHERE TIMESTAMPDIFF(MONTH, C_ORDER.createdTime, current_time()) < 1 AND ORDER_PRODUCT.orderID = C_ORDER.orderID
		GROUP BY ORDER_PRODUCT.storeID
    ) AS CUSTOMER_COUNTS_2
) AS MAX_COUNT
WHERE STORE.storeID = CUSTOMER_COUNTS.storeID AND CUSTOMER_COUNTS.customerCount = MAX_COUNT.maxCount;
