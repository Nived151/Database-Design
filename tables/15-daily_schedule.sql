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
