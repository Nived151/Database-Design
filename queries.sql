/* Find the names of employees who are also a member of the mall. */

SELECT EMPLOYEE.fName, EMPLOYEE.mName, EMPLOYEE.lName
FROM EMPLOYEE
JOIN MEMBER ON EMPLOYEE.memberID = MEMBER.memberID;
/* For each category of Employee, count the number of employees in that category, and the
average salary of that category.  */

SELECT jobPosition, COUNT(*) AS NumEmployees, AVG(salary) AS AvgSalary
FROM EMPLOYEE
GROUP BY jobPosition;/* Find the average number of orders placed by Potential-Member-Customer */

SELECT AVG(order_count) as avgNumOrders
FROM (
  SELECT COUNT(*) AS order_count
  FROM C_ORDER
  WHERE customerID IN (
    SELECT customerID
    FROM Potential_Member_Customer
  )
  GROUP BY customerID
) AS order_counts;/* Find all the customers who purchased the Popular-Product. */

SELECT DISTINCT CUSTOMER.customerID, CUSTOMER.fName, CUSTOMER.mName, CUSTOMER.lName
FROM CUSTOMER
JOIN C_ORDER ON CUSTOMER.customerID = C_ORDER.customerID
JOIN ORDER_PRODUCT ON C_ORDER.orderID = ORDER_PRODUCT.orderID
JOIN POPULAR_PRODUCT ON ORDER_PRODUCT.productID = POPULAR_PRODUCT.productID;/* 5. List all the employees that become a member within a month of being employed */
SELECT EMPLOYEE.fName, EMPLOYEE.mName, EMPLOYEE.lName, EMPLOYEE.startDate
FROM EMPLOYEE, MEMBERCARD
WHERE EMPLOYEE.memberID = MEMBERCARD.memberID 
	AND TIMESTAMPDIFF(MONTH, EMPLOYEE.startDate, MEMBERCARD.startDate) < 1;



/* 6. Find the names of members who bring the most number guests. */
/*  
    3rd subquery is taking the UNION of first, middle, last names for members 
    because both customer and employee can be members
*/

	SELECT MEMBER_NAMES.fName, MEMBER_NAMES.mName, MEMBER_NAMES.lName 
	FROM 
	(
		SELECT GUEST.memberID, COUNT(GUEST.guestID) as guestCount 
		FROM GUEST
		GROUP BY GUEST.memberID
	) AS GUEST_COUNT,
	(
		SELECT MAX(GUEST_COUNT_2.guestCount) as maxCount
		FROM (
			SELECT GUEST.memberID, COUNT(GUEST.guestID) as guestCount 
			FROM GUEST
			GROUP BY GUEST.memberID
		) AS GUEST_COUNT_2
	) AS MAX_COUNT,
    (
        (SELECT fName, mName, lName, memberID FROM CUSTOMER) 
        UNION 
        (SELECT fName, mName, lName, memberID FROM EMPLOYEE)
    ) AS MEMBER_NAMES
	WHERE GUEST_COUNT.guestCount = MAX_COUNT.maxCount AND MEMBER_NAMES.memberID = GUEST_COUNT.memberID;
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
/* 8. Find the floor staff who have taken charge of all the floors in the past 1 week */

SELECT EMPLOYEE.fName, EMPLOYEE.mName, EMPLOYEE.lName 
FROM EMPLOYEE,
(
	SELECT MANAGE_FLOOR.floorstaffID as employeeID, COUNT(DISTINCT MANAGE_FLOOR.floorNum) as floorCount
	FROM MANAGE_FLOOR 
    WHERE DATEDIFF(current_date(), MANAGE_FLOOR.assignedDate) <= 7
	GROUP BY MANAGE_FLOOR.floorstaffID
) AS FLOORSTAFF_COUNT,
(
	SELECT COUNT(floorNum) as numFloors FROM MALL_FLOOR
) AS NUM_FLOORS
WHERE FLOORSTAFF_COUNT.floorCount = NUM_FLOORS.numFloors AND EMPLOYEE.employeeID = FLOORSTAFF_COUNT.employeeID;

/* 9. For each product, list all the stores selling it and the price of the product at the stores. */
/* 
    First we join tables PRODUCT, SELL, STORE on their shared properties. 
    Then we select the name of the product, the store it is sold at, and the price it is being sold at that store.
*/
SELECT PRODUCT.productName, STORE.storeName, SELL.price 
FROM PRODUCT, SELL, STORE
WHERE PRODUCT.productID = SELL.productID AND SELL.storeID = STORE.storeID;
/* 10. Find the floor that have the most number of stores located. */
/* 
    STORE_COUNT aggregates the count of stores located on each floor. 
    Then, MAX_STORE_COUNT finds the maximum store count value out of all the store counts.
    Finally, we return the floor numbers for which they have store count equal to the max store count value.
*/
SELECT STORE_COUNT.floorNum, STORE_COUNT.numStores 
FROM (
	SELECT MALL_FLOOR.floorNum AS floorNum, COUNT(LOCATED_ON.storeID) AS numStores
	FROM MALL_FLOOR, LOCATED_ON
	WHERE MALL_FLOOR.floorNum = LOCATED_ON.floorNum 
	GROUP BY MALL_FLOOR.floorNum
) AS STORE_COUNT, 
(
	SELECT MAX(numStores) as maxNumStores FROM (
		SELECT MALL_FLOOR.floorNum AS floorNum, COUNT(LOCATED_ON.storeID) AS numStores
		FROM MALL_FLOOR, LOCATED_ON
		WHERE MALL_FLOOR.floorNum = LOCATED_ON.floorNum 
		GROUP BY MALL_FLOOR.floorNum
    ) AS STORE_COUNT_2
) AS MAX_STORE_COUNT
WHERE STORE_COUNT.numStores = MAX_STORE_COUNT.maxNumStores;

/* 11. List the schedule of the Gold-Store. */
/* 
    First we get the info of the Gold-Store using the existing view.
    Then, using that info we can find all values in DAILY_SCHEDULE corresponding to the Gold-Store
*/
SELECT DAILY_SCHEDULE.storeID, STORE.storeName, DAILY_SCHEDULE.dayOfWeek, DAILY_SCHEDULE.openTime, DAILY_SCHEDULE.closeTime
FROM DAILY_SCHEDULE, GOLD_STORE, STORE
WHERE GOLD_STORE.storeID = DAILY_SCHEDULE.storeID AND GOLD_STORE.storeID = STORE.storeID
ORDER BY DAILY_SCHEDULE.storeID;
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

/* 13. Find the employee that supervises the most number of floor staffs. */
/* 
    Since we store supervisor ID with each floor staff entry in FLOORSTAFF, we can count the floorstaffID and group by supervisorID (FLOORSTAFF_COUNT subquery).
    Then, we find the maximum count out of all counts (MAX_COUNT subquery).
    Finally, we return the employee info of the employee(s) whose supervising count is equal to the max count.
*/

SELECT EMPLOYEE.employeeID, EMPLOYEE.fName, EMPLOYEE.lName FROM EMPLOYEE,
(
	SELECT FLOORSTAFF.supervisorID as superID, COUNT(FLOORSTAFF.employeeID) as floorstaffCount FROM FLOORSTAFF GROUP BY FLOORSTAFF.supervisorID
) AS FLOORSTAFF_COUNT,
(
	SELECT MAX(FLOORSTAFF_COUNT_2.floorstaffCount) as maxCount FROM 
    (
		SELECT FLOORSTAFF.supervisorID, COUNT(FLOORSTAFF.employeeID) as floorstaffCount FROM FLOORSTAFF GROUP BY FLOORSTAFF.supervisorID
	) AS FLOORSTAFF_COUNT_2
) AS MAX_COUNT
WHERE FLOORSTAFF_COUNT.floorstaffCount = MAX_COUNT.maxCount AND FLOORSTAFF_COUNT.superID = EMPLOYEE.employeeID;
