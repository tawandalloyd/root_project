-------------------------------------------------------------------------------------------
-- Count the number of insured trips per day, grouped by product type
------------------------------------------------------------------------------------------

SELECT
  DATE(started_at)    AS trip_date,
  rideable_type AS product,
  COUNT(*)      AS insured_trip_count
FROM TRIPS
GROUP BY trip_date,  product
ORDER BY trip_date, product;


