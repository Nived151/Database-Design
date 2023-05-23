/* Find the average number of orders placed by Potential-Member-Customer */

SELECT AVG(order_count) as avgNumOrders
FROM (
  SELECT COUNT(*) AS order_count
  FROM C_ORDER
  WHERE customerID IN (
    SELECT customerID
    FROM Potential_Member_Customer
  )
  GROUP BY customerID
) AS order_counts;