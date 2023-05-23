CREATE TABLE FLOORSTAFF (
    employeeID INTEGER,
    supervisorID INTEGER,
    PRIMARY KEY (employeeID),
    FOREIGN KEY (employeeID) REFERENCES EMPLOYEE(employeeID),
    FOREIGN KEY (supervisorID) REFERENCES MANAGER(employeeID)
);
