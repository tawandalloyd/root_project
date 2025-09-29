{{ config(materialized='table') }}

SELECT 
  m.RIDE_ID,
  m.rideable_type,
  m.started_at,
  m.ended_at,
  m.start_station_name,
  m.start_station_id,
  m.end_station_name,
  m.end_station_id,
  m.start_lat,
  m.start_lng,
  m.end_lat,
  m.end_lng,
  m.member_casual,
  CASE 
    WHEN m.start_station_name IS NULL OR m.end_station_name IS NULL THEN 5
    WHEN m.rideable_type = 'classic_bike' THEN 15
    WHEN m.rideable_type = 'electric_bike' THEN 20
    ELSE 0
  END AS BASE_PREMIUM,
  w.DATE  AS weather_date,
  w.rain,
  w.wind_speed_10m,
FROM {{ source('src_duckdb', 'TRIPS') }} as m
LEFT JOIN {{ source('src_duckdb', 'weather') }} as w
  ON w.DATE BETWEEN m.started_at AND m.ended_at