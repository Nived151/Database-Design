
CREATE TABLE PRODUCT (
    productID INTEGER,
    productName VARCHAR(50) NOT NULL,
    productDescription VARCHAR(250),
    PRIMARY KEY (productID)
);
CREATE TABLE STORE (
    storeID INTEGER,
    storeName VARCHAR(50) NOT NULL,
    storeType VARCHAR(50),
    PRIMARY KEY (storeID)
);
CREATE TABLE MALL_FLOOR (
    floorNum INTEGER,
    PRIMARY KEY (floorNum)
);
CREATE TABLE MEMBER (
    memberID INTEGER,
    points INTEGER DEFAULT 0,
    PRIMARY KEY (memberID),
    CHECK (points >= 0)
);
CREATE TABLE EMPLOYEE (
    employeeID INTEGER,
    salary NUMERIC(9,2),
    startDate DATE,
	jobPosition VARCHAR(3),
    fName VARCHAR(20) NOT NULL,
    mName VARCHAR(20),
    lName VARCHAR(20) NOT NULL,
    dob DATE NOT NULL,
    gender VARCHAR(1),
    aptNum INTEGER,
    streetNum INTEGER,
    streetName VARCHAR(50),
    city VARCHAR(50),
    stateCode VARCHAR(2), 
    zip NUMERIC(5,0),
    memberID INTEGER,
    PRIMARY KEY (employeeID),
    FOREIGN KEY (memberID) REFERENCES MEMBER(memberID),
    CHECK (gender in (NULL, 'M', 'F', 'O')),
    CHECK (jobPosition in ('MGR', 'FLR', 'CSH')),
    CHECK (employeeID >= 0)
);
CREATE TABLE MANAGER (
    employeeID INTEGER,
    PRIMARY KEY (employeeID),
    FOREIGN KEY (employeeID) REFERENCES EMPLOYEE(employeeID)
);
CREATE TABLE MEMBERCARD (
    cardNum INTEGER,
    memberID INTEGER NOT NULL,
    startDate DATE NOT NULL,
    managerID INTEGER NOT NULL,
    PRIMARY KEY (cardNum),
    FOREIGN KEY (memberID) REFERENCES MEMBER(memberID),
    FOREIGN KEY (managerID) REFERENCES MANAGER(employeeID)
);
CREATE TABLE PROMOTION (
    memberCardNum INTEGER,
    promoID INTEGER,
    promoDescription VARCHAR(250),
    PRIMARY KEY (memberCardNum, promoID),
    FOREIGN KEY (memberCardNum) REFERENCES MEMBERCARD(cardNum)
);
CREATE TABLE GUEST (
    memberID INTEGER,
    guestID INTEGER,
    fName VARCHAR(20) NOT NULL,
    mName VARCHAR(20),
    lName VARCHAR(20) NOT NULL,
    dob DATE NOT NULL,
    gender VARCHAR(1),
    aptNum INTEGER,
    streetNum INTEGER,
    streetName VARCHAR(50),
    city VARCHAR(50),
    stateCode VARCHAR(2), 
    zip NUMERIC(5,0),
    PRIMARY KEY (memberID, guestID),
    FOREIGN KEY (memberID) REFERENCES MEMBER(memberID),
    CHECK (gender in (NULL, 'M', 'F', 'O'))
);
CREATE TABLE CUSTOMER (
    customerID INTEGER,
    fName VARCHAR(20) NOT NULL,
    mName VARCHAR(20),
    lName VARCHAR(20) NOT NULL,
    dob DATE NOT NULL,
    gender VARCHAR(1),
    aptNum INTEGER,
    streetNum INTEGER,
    streetName VARCHAR(50),
    city VARCHAR(50),
    stateCode VARCHAR(2), 
    zip NUMERIC(5,0),
    memberID INTEGER,
    PRIMARY KEY (customerID),
    FOREIGN KEY (memberID) REFERENCES MEMBER(memberID),
    CHECK (gender in (NULL, 'M', 'F', 'O'))
);
CREATE TABLE C_ORDER (
    orderID INTEGER,
    createdTime DATETIME NOT NULL,
    subtotal NUMERIC(9,2) NOT NULL,
    customerID INTEGER NOT NULL,
    PRIMARY KEY (orderID),
    FOREIGN KEY (customerID) REFERENCES CUSTOMER(customerID),
    CHECK(subtotal >= 0.00)
);
CREATE TABLE PAYMENT (
    paymentID INTEGER,
    paymentTime DATETIME NOT NULL,
    method VARCHAR(20) NOT NULL,
    amount NUMERIC(9,2) NOT NULL,
    orderID INTEGER NOT NULL,
    PRIMARY KEY (paymentID),
    FOREIGN KEY (orderID) REFERENCES C_ORDER(orderID),
    CHECK (method in ('CASH', 'CREDIT', 'CHECK', 'MEMBERCARD')),
    CHECK(amount >= 0)
);
CREATE TABLE FLOORSTAFF (
    employeeID INTEGER,
    supervisorID INTEGER,
    PRIMARY KEY (employeeID),
    FOREIGN KEY (employeeID) REFERENCES EMPLOYEE(employeeID),
    FOREIGN KEY (supervisorID) REFERENCES MANAGER(employeeID)
);
CREATE TABLE CASHIER (
    employeeID INTEGER,
    storeID INTEGER,
    PRIMARY KEY (employeeID),
    FOREIGN KEY (employeeID) REFERENCES EMPLOYEE(employeeID),
    FOREIGN KEY (storeID) REFERENCES STORE(storeID)
);
CREATE TABLE DAILY_SCHEDULE (
    storeID INTEGER,
    dayOfWeek VARCHAR(3),
    openTime TIME,
    closeTime TIME,
    managerID INTEGER,
    PRIMARY KEY (storeID, dayOfWeek),
    FOREIGN KEY (storeID) REFERENCES STORE(storeID),
    FOREIGN KEY (managerID) REFERENCES MANAGER(employeeID),
    CHECK (openTime <= closeTime),
    CHECK (dayOfWeek in ('MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT', 'SUN'))
);
CREATE TABLE LOCATED_ON (
    storeID INTEGER,
    floorNum INTEGER,
    PRIMARY KEY (storeID, floorNum),
    FOREIGN KEY (storeID) REFERENCES STORE(storeID),
    FOREIGN KEY (floorNum) REFERENCES MALL_FLOOR(floorNum)
);
CREATE TABLE SELL(
    storeID INTEGER,
    productID INTEGER,
    price DECIMAL(9,2) NOT NULL,
    stock INTEGER NOT NULL,
    PRIMARY KEY (storeID, productID),
    FOREIGN KEY (storeID) REFERENCES STORE(storeID),
    FOREIGN KEY (productID) REFERENCES PRODUCT(productID),
    CHECK (price >= 0.00),
    CHECK (stock >= 0)
);

CREATE TABLE MANAGE_FLOOR(
    floorstaffID INTEGER,
    floorNum INTEGER,
    assignedDate DATE,
    PRIMARY KEY (floorstaffID, floorNum, assignedDate),
    FOREIGN KEY (floorstaffID) REFERENCES FLOORSTAFF(employeeID),
    FOREIGN KEY (floorNum) REFERENCES MALL_FLOOR(floorNum)
);
CREATE TABLE E_PHONE (
    employeeID INTEGER,
    phoneNum NUMERIC(10,0),
    PRIMARY KEY (employeeID, phoneNum),
    FOREIGN KEY (employeeID) REFERENCES EMPLOYEE(employeeID)
); 

CREATE TABLE C_PHONE (
    customerID INTEGER,
    phoneNum NUMERIC(10,0),
    PRIMARY KEY (customerID, phoneNum),
    FOREIGN KEY (customerID) REFERENCES CUSTOMER(customerID)
);
CREATE TABLE G_PHONE(
    memberID INTEGER,
    guestID INTEGER,
    phoneNum NUMERIC(10,0),
    PRIMARY KEY (memberID, guestID, phoneNum),
    FOREIGN KEY (memberID, guestID) REFERENCES GUEST(memberID, guestID)
);
CREATE TABLE EARN_POINTS (
    memberID INTEGER,
    cardNum INTEGER,
    paymentID INTEGER,
    points INTEGER NOT NULL,
    PRIMARY KEY (memberID, cardNum, paymentID),
    FOREIGN KEY (memberID) REFERENCES MEMBER(memberID),
    FOREIGN KEY (cardNum) REFERENCES MEMBERCARD(cardNum),
    FOREIGN KEY (paymentID) REFERENCES PAYMENT(paymentID),
    CHECK (points >= 0)
);
CREATE TABLE APPLY_PROMO (
    cardNum INTEGER,
    promoID INTEGER,
    paymentID INTEGER,
    PRIMARY KEY (cardNum),
    FOREIGN KEY (cardNum, promoID) REFERENCES PROMOTION(memberCardNum, promoID),
    FOREIGN KEY (paymentID) REFERENCES PAYMENT(paymentID)
);
CREATE TABLE ORDER_PRODUCT (
    orderID INTEGER,
    productID INTEGER,
    storeID INTEGER,
    quantity INTEGER NOT NULL,
    PRIMARY KEY (orderID, productID, storeID),
    FOREIGN KEY (orderID) REFERENCES C_ORDER(orderID),
    FOREIGN KEY (storeID) REFERENCES STORE(storeID),
    FOREIGN KEY (productID) REFERENCES PRODUCT(productID),
    FOREIGN KEY (storeID, productID) REFERENCES SELL(storeID, productID),
    CHECK (quantity >= 1)
);

CREATE TABLE MAKE_PAYMENT (
    customerID INTEGER,
    paymentID INTEGER,
    cashierID INTEGER,
    PRIMARY KEY (customerID, paymentID, cashierID),
    FOREIGN KEY (customerID) REFERENCES CUSTOMER(customerID),
    FOREIGN KEY (paymentID) REFERENCES PAYMENT(paymentID),
    FOREIGN KEY (cashierID) REFERENCES CASHIER(employeeID)
);

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
/* Potential-Member-Customer: This view returns the information of the customers
 (not a member yet) who have placed orders more than 10 times in the past 1 month.*/
 

CREATE VIEW Potential_Member_Customer AS
SELECT C.customerID, C.fName, C.mName, C.lName, COUNT(O.orderID) AS NumOrders
FROM CUSTOMER C
JOIN C_ORDER O ON C.customerID = O.customerID
WHERE TIMESTAMPDIFF(MONTH, O.createdTime, current_date()) < 1 AND C.memberID IS NULL
GROUP BY C.customerID, C.fName, C.mName, C.lName
HAVING COUNT(O.orderID) > 10;
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
