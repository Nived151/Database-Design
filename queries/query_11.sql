/* 11. List the schedule of the Gold-Store. */
/* 
    First we get the info of the Gold-Store using the existing view.
    Then, using that info we can find all values in DAILY_SCHEDULE corresponding to the Gold-Store
*/
SELECT DAILY_SCHEDULE.storeID, STORE.storeName, DAILY_SCHEDULE.dayOfWeek, DAILY_SCHEDULE.openTime, DAILY_SCHEDULE.closeTime
FROM DAILY_SCHEDULE, GOLD_STORE, STORE
WHERE GOLD_STORE.storeID = DAILY_SCHEDULE.storeID AND GOLD_STORE.storeID = STORE.storeID
ORDER BY DAILY_SCHEDULE.storeID;
