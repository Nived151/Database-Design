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
