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
