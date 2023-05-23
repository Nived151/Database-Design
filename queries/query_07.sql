/* 7. Find the store that has most different products in stock. */

SELECT STORE.storeID, STORE.storeName, PRODUCT_COUNT.productCount 
FROM STORE, 
(
	SELECT storeID, COUNT(productID) as productCount 
    FROM SELL
    WHERE stock > 0
	GROUP BY storeID
) AS PRODUCT_COUNT,
(
	SELECT MAX(productCount) as maxCount FROM (
		SELECT storeID, COUNT(productID) as productCount 
		FROM SELL
		WHERE stock > 0
		GROUP BY storeID
	) AS PRODUCT_COUNT_2
) AS MAX_COUNT
WHERE PRODUCT_COUNT.productCount = MAX_COUNT.maxCount AND STORE.storeID = PRODUCT_COUNT.storeID;
