-- TODO: This query will return a table with the revenue by month and year. It
-- will have different columns: month_no, with the month numbers going from 01
-- to 12; month, with the 3 first letters of each month (e.g. Jan, Feb);
-- Year2016, with the revenue per month of 2016 (0.00 if it doesn't exist);
-- Year2017, with the revenue per month of 2017 (0.00 if it doesn't exist) and
-- Year2018, with the revenue per month of 2018 (0.00 if it doesn't exist).


With rev_month_year  As
( Select strftime('%m', oo.order_delivered_customer_date) month_no, oo.order_id,
  oop.payment_value payment_value, oo.order_delivered_customer_date odcd
  From olist_orders oo, olist_order_payments oop
  Where oo.order_id = oop.order_id
  And   oo.order_status = 'delivered' 
  And   oo.order_delivered_customer_date Is Not NULL 
  And   oo.order_purchase_timestamp Is Not NULL
  Group By oo.order_id 
)
Select
    month_no,
    Case
        When month_no = '01' Then 'Jan'
        When month_no = '02' Then 'Feb'
        When month_no = '03' Then 'Mar'
        When month_no = '04' Then 'Apr'
        When month_no = '05' Then 'May'
        When month_no = '06' Then 'Jun'
        When month_no = '07' Then 'Jul'
        When month_no = '08' Then 'Aug'
        When month_no = '09' Then 'Sep'
        When month_no = '10' Then 'Oct'
        When month_no = '11' Then 'Nov'
        When month_no = '12' Then 'Dec'
    End month,
    Sum(Case strftime('%Y', odcd)
        When '2016' Then (payment_value) Else 0.0 End) 'Year2016',
    Sum(Case strftime('%Y', odcd)
        When '2017' Then (payment_value) Else 0.0 End) 'Year2017',
    Sum(Case strftime('%Y', odcd)
        When '2018' Then (payment_value) Else 0.0 End) 'Year2018'
From rev_month_year
Group By month_no
Order By month_no