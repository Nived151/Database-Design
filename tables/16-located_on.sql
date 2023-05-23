CREATE TABLE LOCATED_ON (
    storeID INTEGER,
    floorNum INTEGER,
    PRIMARY KEY (storeID, floorNum),
    FOREIGN KEY (storeID) REFERENCES STORE(storeID),
    FOREIGN KEY (floorNum) REFERENCES MALL_FLOOR(floorNum)
);
