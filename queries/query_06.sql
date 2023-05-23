/* 6. Find the names of members who bring the most number guests. */
/*  
    3rd subquery is taking the UNION of first, middle, last names for members 
    because both customer and employee can be members
*/

	SELECT MEMBER_NAMES.fName, MEMBER_NAMES.mName, MEMBER_NAMES.lName 
	FROM 
	(
		SELECT GUEST.memberID, COUNT(GUEST.guestID) as guestCount 
		FROM GUEST
		GROUP BY GUEST.memberID
	) AS GUEST_COUNT,
	(
		SELECT MAX(GUEST_COUNT_2.guestCount) as maxCount
		FROM (
			SELECT GUEST.memberID, COUNT(GUEST.guestID) as guestCount 
			FROM GUEST
			GROUP BY GUEST.memberID
		) AS GUEST_COUNT_2
	) AS MAX_COUNT,
    (
        (SELECT fName, mName, lName, memberID FROM CUSTOMER) 
        UNION 
        (SELECT fName, mName, lName, memberID FROM EMPLOYEE)
    ) AS MEMBER_NAMES
	WHERE GUEST_COUNT.guestCount = MAX_COUNT.maxCount AND MEMBER_NAMES.memberID = GUEST_COUNT.memberID;
