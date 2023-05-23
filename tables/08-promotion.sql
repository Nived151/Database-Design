CREATE TABLE PROMOTION (
    memberCardNum INTEGER,
    promoID INTEGER,
    promoDescription VARCHAR(250),
    PRIMARY KEY (memberCardNum, promoID),
    FOREIGN KEY (memberCardNum) REFERENCES MEMBERCARD(cardNum)
);
