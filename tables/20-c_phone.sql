
CREATE TABLE C_PHONE (
    customerID INTEGER,
    phoneNum NUMERIC(10,0),
    PRIMARY KEY (customerID, phoneNum),
    FOREIGN KEY (customerID) REFERENCES CUSTOMER(customerID)
);
