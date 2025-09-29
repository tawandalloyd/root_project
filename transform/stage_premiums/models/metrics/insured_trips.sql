{{ config(materialized='table') }}

SELECT
  DATE(started_at)    AS trip_date,
  rideable_type AS product,
  COUNT(*)      AS insured_trip_count
FROM {{ source('src_duckdb', 'TRIPS') }} 
GROUP BY trip_date, product
ORDER BY trip_date, product