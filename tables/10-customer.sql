CREATE TABLE CUSTOMER (
    customerID INTEGER,
    fName VARCHAR(20) NOT NULL,
    mName VARCHAR(20),
    lName VARCHAR(20) NOT NULL,
    dob DATE NOT NULL,
    gender VARCHAR(1),
    aptNum INTEGER,
    streetNum INTEGER,
    streetName VARCHAR(50),
    city VARCHAR(50),
    stateCode VARCHAR(2), 
    zip NUMERIC(5,0),
    memberID INTEGER,
    PRIMARY KEY (customerID),
    FOREIGN KEY (memberID) REFERENCES MEMBER(memberID),
    CHECK (gender in (NULL, 'M', 'F', 'O'))
);
