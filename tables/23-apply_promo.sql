CREATE TABLE APPLY_PROMO (
    cardNum INTEGER,
    promoID INTEGER,
    paymentID INTEGER,
    PRIMARY KEY (cardNum),
    FOREIGN KEY (cardNum, promoID) REFERENCES PROMOTION(memberCardNum, promoID),
    FOREIGN KEY (paymentID) REFERENCES PAYMENT(paymentID)
);
