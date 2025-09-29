{{ config(materialized='table') }}

WITH CTE_PREMIUMS AS (
SELECT 
  m.RIDE_ID,
  m.started_at,
  m.ended_at,
  m.start_station_name,
  m.end_station_name,
  m.rideable_type,
  w.rain,
  w.wind_speed_10m,
  CASE
    WHEN m.start_station_name IS NULL OR m.end_station_name IS NULL THEN FALSE
    ELSE TRUE
  END AS usage_flag,
FROM {{ source('src_duckdb', 'TRIPS') }} as m
LEFT JOIN {{ source('src_duckdb', 'weather') }} as w
  ON w.DATE BETWEEN m.started_at AND m.ended_at
)
SELECT 
    DATE(started_at) AS trip_date,
    rideable_type      AS product,
    SUM(
    CASE
    WHEN (rain > 0 OR wind_speed_10m > 10) THEN
      CASE
        WHEN start_station_name IS NULL OR end_station_name IS NULL THEN 5 * 1.2
        WHEN rideable_type = 'classic_bike' THEN 15 * 1.2
        WHEN rideable_type = 'electric_bike' THEN 20 * 1.2
        ELSE 0
      END
    ELSE
      CASE
        WHEN start_station_name IS NULL OR end_station_name IS NULL THEN 5
        WHEN rideable_type = 'classic_bike' THEN 15
        WHEN rideable_type = 'electric_bike' THEN 20
        ELSE 0
      END
    END) AS premium
FROM CTE_PREMIUMS m
GROUP BY trip_date, product
ORDER BY trip_date