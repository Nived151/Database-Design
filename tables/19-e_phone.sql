CREATE TABLE E_PHONE (
    employeeID INTEGER,
    phoneNum NUMERIC(10,0),
    PRIMARY KEY (employeeID, phoneNum),
    FOREIGN KEY (employeeID) REFERENCES EMPLOYEE(employeeID)
); 
