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
