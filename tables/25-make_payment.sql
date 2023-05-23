
CREATE TABLE MAKE_PAYMENT (
    customerID INTEGER,
    paymentID INTEGER,
    cashierID INTEGER,
    PRIMARY KEY (customerID, paymentID, cashierID),
    FOREIGN KEY (customerID) REFERENCES CUSTOMER(customerID),
    FOREIGN KEY (paymentID) REFERENCES PAYMENT(paymentID),
    FOREIGN KEY (cashierID) REFERENCES CASHIER(employeeID)
);

