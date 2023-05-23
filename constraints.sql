/* Ensure subtotal in C_ORDER matches sum of product quantities multiplied by their sell price by the store the order was placed in. */
CREATE ASSERTION c_order_subtotal_assertion
CHECK ( NOT EXISTS 
    (
        SELECT * FROM c_order,
            (
                SELECT order_product.orderID AS orderID, SUM(order_product.quantity * sell.price) AS subtotal FROM order_product, sell 
                WHERE (order_product.storeID, order_product.productID) = (sell.storeID, sell.productID)
                GROUP BY order_product.orderID
            ) AS order_subtotal
        WHERE c_order.orderID = sub.orderID AND c_order.subtotal <> sub.subtotal
    )
);

/* Ensure MANAGER entries correspond to an EMPLOYEE entry with the jobPosition = 'MGR' */
CREATE ASSERTION manager_employee_assertion
CHECK ( NOT EXISTS 
    (
        SELECT * FROM MANAGER, EMPLOYEE 
        WHERE MANAGER.employeeID = EMPLOYEE.employeeID AND EMPLOYEE.jobPosition <> 'MGR'
    )
);

/* Ensure FLOORSTAFF entries correspond to an EMPLOYEE entry with the jobPosition = 'FLR' */
CREATE ASSERTION floorstaff_employee_assertion
CHECK ( NOT EXISTS 
    (
        SELECT * FROM FLOORSTAFF, EMPLOYEE 
        WHERE FLOORSTAFF.employeeID = EMPLOYEE.employeeID AND EMPLOYEE.jobPosition <> 'FLR'
    )
);

/* Ensure CASHIER entries correspond to an EMPLOYEE entry with the jobPosition = 'CSH' */
CREATE ASSERTION cashier_employee_assertion
CHECK ( NOT EXISTS 
    (
        SELECT * FROM CASHIER, EMPLOYEE 
        WHERE CASHIER.employeeID = EMPLOYEE.employeeID AND EMPLOYEE.jobPosition <> 'CSH'
    )
);

/* Ensure EMPLOYEEs are at least 8 years old */
CREATE ASSERTION employee_age_assertion
CHECK ( NOT EXISTS
    (
        SELECT * FROM EMPLOYEE 
        WHERE TIMESTAMPDIFF(YEAR, EMPLOYEE.dob, current_date()) < 18
    )
)
