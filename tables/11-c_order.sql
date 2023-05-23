CREATE TABLE C_ORDER (
    orderID INTEGER,
    createdTime DATETIME NOT NULL,
    subtotal NUMERIC(9,2) NOT NULL,
    customerID INTEGER NOT NULL,
    PRIMARY KEY (orderID),
    FOREIGN KEY (customerID) REFERENCES CUSTOMER(customerID),
    CHECK(subtotal >= 0.00)
);
