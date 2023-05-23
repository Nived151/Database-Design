/* 10. Find the floor that have the most number of stores located. */
/* 
    STORE_COUNT aggregates the count of stores located on each floor. 
    Then, MAX_STORE_COUNT finds the maximum store count value out of all the store counts.
    Finally, we return the floor numbers for which they have store count equal to the max store count value.
*/
SELECT STORE_COUNT.floorNum, STORE_COUNT.numStores 
FROM (
	SELECT MALL_FLOOR.floorNum AS floorNum, COUNT(LOCATED_ON.storeID) AS numStores
	FROM MALL_FLOOR, LOCATED_ON
	WHERE MALL_FLOOR.floorNum = LOCATED_ON.floorNum 
	GROUP BY MALL_FLOOR.floorNum
) AS STORE_COUNT, 
(
	SELECT MAX(numStores) as maxNumStores FROM (
		SELECT MALL_FLOOR.floorNum AS floorNum, COUNT(LOCATED_ON.storeID) AS numStores
		FROM MALL_FLOOR, LOCATED_ON
		WHERE MALL_FLOOR.floorNum = LOCATED_ON.floorNum 
		GROUP BY MALL_FLOOR.floorNum
    ) AS STORE_COUNT_2
) AS MAX_STORE_COUNT
WHERE STORE_COUNT.numStores = MAX_STORE_COUNT.maxNumStores;

