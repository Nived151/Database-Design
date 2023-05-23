
CREATE TABLE MANAGE_FLOOR(
    floorstaffID INTEGER,
    floorNum INTEGER,
    assignedDate DATE,
    PRIMARY KEY (floorstaffID, floorNum, assignedDate),
    FOREIGN KEY (floorstaffID) REFERENCES FLOORSTAFF(employeeID),
    FOREIGN KEY (floorNum) REFERENCES MALL_FLOOR(floorNum)
);
