SELECT
  -- Aggregates
  COUNT(DISTINCT transaction_id) AS number_of_sales,
  SUM(transaction_qty * unit_price) AS total_revenue,
  SUM(transaction_qty) AS number_of_unit_sold,

  -- Dates
  TO_DATE(transaction_date) AS purchase_date,
  TO_CHAR(TO_DATE(transaction_date), 'YYYYMM') AS month_id,
  DAYNAME(TO_DATE(transaction_date)) AS day_of_the_week,

  -- Time
  CASE
      WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
      WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
      WHEN transaction_time BETWEEN '17:00:00' AND '20:59:59' THEN 'Evening'
      ELSE 'Night'
END AS time_bucket,


CASE
       WHEN total_revenue BETWEEN 0 AND 10 THEN 'Low'
       WHEN total_revenue BETWEEN 11 AND 49 THEN 'Medium'
ELSE 'High' 
END AS spender_bucket,
  
  -- Grouping fields
       store_location,
       product_category,
       product_detail,
       product_type

FROM "SALES"."PUBLIC"."SHOP"

GROUP BY 
  purchase_date,
  month_id,
  day_of_the_week,
  store_location,
  time_bucket,
  product_category,
  product_detail,
  product_type
  --spender_bucket,
  
  HAVING total_revenue > 0;
