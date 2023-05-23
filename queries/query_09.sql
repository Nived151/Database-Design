/* 9. For each product, list all the stores selling it and the price of the product at the stores. */
/* 
    First we join tables PRODUCT, SELL, STORE on their shared properties. 
    Then we select the name of the product, the store it is sold at, and the price it is being sold at that store.
*/
SELECT PRODUCT.productName, STORE.storeName, SELL.price 
FROM PRODUCT, SELL, STORE
WHERE PRODUCT.productID = SELL.productID AND SELL.storeID = STORE.storeID;
