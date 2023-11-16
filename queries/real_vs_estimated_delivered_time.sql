-- TODO: This query will return a table with the differences between the real 
-- and estimated delivery times by month and year. It will have different 
-- columns: month_no, with the month numbers going from 01 to 12; month, with 
-- the 3 first letters of each month (e.g. Jan, Feb); Year2016_real_time, with 
-- the average delivery time per month of 2016 (NaN if it doesn't exist); 
-- Year2017_real_time, with the average delivery time per month of 2017 (NaN if 
-- it doesn't exist); Year2018_real_time, with the average delivery time per 
-- month of 2018 (NaN if it doesn't exist); Year2016_estimated_time, with the 
-- average estimated delivery time per month of 2016 (NaN if it doesn't exist); 
-- Year2017_estimated_time, with the average estimated delivery time per month 
-- of 2017 (NaN if it doesn't exist) and Year2018_estimated_time, with the 
-- average estimated delivery time per month of 2018 (NaN if it doesn't exist).
-- HINTS
-- 1. You can use the julianday function to convert a date to a number.
-- 2. order_status == 'delivered' AND order_delivered_customer_date IS NOT NULL
-- 3. Take distinct order_id.

WITH sixteen_year AS(
SELECT STRFTIME('%Y-%m', order_purchase_timestamp) as month_year,
STRFTIME('%Y', order_purchase_timestamp) as year,
STRFTIME('%m', order_purchase_timestamp) as month,
ROUND(CAST(AVG((JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_purchase_timestamp))) AS FLOAT),6) AS Year2016_real_time,
ROUND(CAST(AVG((JULIANDAY(order_estimated_delivery_date) - JULIANDAY(order_purchase_timestamp))) AS FLOAT),6) AS Year2016_estimated_time
FROM olist_orders
WHERE year = '2016'
AND 
order_status = 'delivered'
AND
order_delivered_customer_date IS NOT NULL
GROUP BY month_year
ORDER BY month_year),
seventeen_year AS(
SELECT STRFTIME('%Y-%m', order_purchase_timestamp) as month_year,
STRFTIME('%Y', order_purchase_timestamp) as year,
STRFTIME('%m', order_purchase_timestamp) as month,
ROUND(CAST(AVG((JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_purchase_timestamp))) AS FLOAT),6) AS Year2017_real_time,
ROUND(CAST(AVG((JULIANDAY(order_estimated_delivery_date) - JULIANDAY(order_purchase_timestamp))) AS FLOAT),6) AS Year2017_estimated_time
FROM olist_orders
WHERE year = '2017'
AND 
order_status = 'delivered'
AND
order_delivered_customer_date IS NOT NULL
GROUP BY month_year
ORDER BY month_year),
eightteen_year AS(
SELECT STRFTIME('%Y-%m', order_purchase_timestamp) as month_year,
STRFTIME('%Y', order_purchase_timestamp) as year,
STRFTIME('%m', order_purchase_timestamp) as month,
ROUND(CAST(AVG((JULIANDAY(order_delivered_customer_date) - JULIANDAY(order_purchase_timestamp))) AS FLOAT),6) AS Year2018_real_time,
ROUND(CAST(AVG((JULIANDAY(order_estimated_delivery_date) - JULIANDAY(order_purchase_timestamp))) AS FLOAT),6) AS Year2018_estimated_time
FROM olist_orders
WHERE year = '2018'
AND
order_status = 'delivered'
AND
order_delivered_customer_date IS NOT NULL
GROUP BY month_year
ORDER BY month_year),artificial_months AS (
  SELECT '01' AS num_month, 'Jan' AS name_month
  UNION ALL SELECT '02', 'Feb'
  UNION ALL SELECT '03', 'Mar'
  UNION ALL SELECT '04', 'Apr'
  UNION ALL SELECT '05', 'May'
  UNION ALL SELECT '06', 'Jun'
  UNION ALL SELECT '07', 'Jul'
  UNION ALL SELECT '08', 'Aug'
  UNION ALL SELECT '09', 'Sep'
  UNION ALL SELECT '10', 'Oct'
  UNION ALL SELECT '11', 'Nov'
  UNION ALL SELECT '12', 'Dec'
)
SELECT seventeen_year.month AS month_no,
artificial_months.name_month AS month, 
Year2016_real_time,
Year2017_real_time,
Year2018_real_time,
Year2016_estimated_time,
Year2017_estimated_time,
Year2018_estimated_time
FROM seventeen_year
LEFT JOIN sixteen_year
ON seventeen_year.month = sixteen_year.month
LEFT JOIN eightteen_year
ON seventeen_year.month = eightteen_year.month
INNER JOIN artificial_months
ON seventeen_year.month = artificial_months.num_month
ORDER BY seventeen_year.month ASC