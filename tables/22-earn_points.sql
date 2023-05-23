CREATE TABLE EARN_POINTS (
    memberID INTEGER,
    cardNum INTEGER,
    paymentID INTEGER,
    points INTEGER NOT NULL,
    PRIMARY KEY (memberID, cardNum, paymentID),
    FOREIGN KEY (memberID) REFERENCES MEMBER(memberID),
    FOREIGN KEY (cardNum) REFERENCES MEMBERCARD(cardNum),
    FOREIGN KEY (paymentID) REFERENCES PAYMENT(paymentID),
    CHECK (points >= 0)
);
