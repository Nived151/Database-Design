CREATE TABLE MEMBER (
    memberID INTEGER,
    points INTEGER DEFAULT 0,
    PRIMARY KEY (memberID),
    CHECK (points >= 0)
);
