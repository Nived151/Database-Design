CREATE TABLE G_PHONE(
    memberID INTEGER,
    guestID INTEGER,
    phoneNum NUMERIC(10,0),
    PRIMARY KEY (memberID, guestID, phoneNum),
    FOREIGN KEY (memberID, guestID) REFERENCES GUEST(memberID, guestID)
);
