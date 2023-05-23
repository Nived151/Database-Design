/* 
    This view returns the information of the most popular product that
    has been sold the most in the whole mall in past 1 month.
*/
CREATE VIEW POPULAR_PRODUCT AS 
SELECT PRODUCT.productID, PRODUCT.productName, PRODUCT.productDescription FROM PRODUCT,
(
	SELECT ORDER_PRODUCT.productID, COUNT(ORDER_PRODUCT.orderID) AS orderCount FROM ORDER_PRODUCT, C_ORDER
	WHERE C_ORDER.orderID = ORDER_PRODUCT.orderID AND TIMESTAMPDIFF(MONTH, C_ORDER.createdTime, current_date()) < 1
	GROUP BY ORDER_PRODUCT.productID
) AS PRODUCT_COUNTS, 
(
	SELECT MAX(PRODUCT_COUNTS_2.orderCount) AS maxCount FROM 
    (
		SELECT ORDER_PRODUCT.productID, COUNT(ORDER_PRODUCT.orderID) AS orderCount FROM ORDER_PRODUCT, C_ORDER
		WHERE C_ORDER.orderID = ORDER_PRODUCT.orderID AND TIMESTAMPDIFF(MONTH, C_ORDER.createdTime, current_date()) < 1
		GROUP BY ORDER_PRODUCT.productID
    ) AS PRODUCT_COUNTS_2
) AS MAX_COUNT
WHERE MAX_COUNT.maxCount = PRODUCT_COUNTS.orderCount AND PRODUCT_COUNTS.productID = PRODUCT.productID;
