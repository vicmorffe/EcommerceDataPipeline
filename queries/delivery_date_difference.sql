-- TODO: This query will return a table with two columns; State, and 
-- Delivery_Difference. The first one will have the letters that identify the 
-- states, and the second one the average difference between the estimate 
-- delivery date and the date when the items were actually delivered to the 
-- customer.
-- HINTS:
-- 1. You can use the julianday function to convert a date to a number.
-- 2. You can use the CAST function to convert a number to an integer.
-- 3. You can use the STRFTIME function to convert a order_delivered_customer_date to a string removing hours, minutes and seconds.
-- 4. order_status == 'delivered' AND order_delivered_customer_date IS NOT NULL


SELECT customer_state AS State, 
cast(AVG(ROUND((JULIANDAY(STRFTIME('%Y-%m-%d', order_estimated_delivery_date)) - JULIANDAY(STRFTIME('%Y-%m-%d', order_delivered_customer_date))))) as int) AS Delivery_Difference 
FROM (SELECT * FROM olist_orders
    INNER JOIN olist_customers
    ON olist_orders.customer_id = olist_customers.customer_id)
    GROUP BY customer_state
order by Delivery_Difference  ASC 
        

