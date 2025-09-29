{{ config(materialized='table') }}

SELECT
    DATE(m.started_at) AS trip_date,
    m.rideable_type    AS product,
    COUNT(*)           AS insured_trip_count,
    SUM(w.rain)        AS total_rainfall 
FROM {{ source('src_duckdb', 'TRIPS') }} AS m
LEFT JOIN {{ source('src_duckdb', 'weather') }} AS w
ON w.DATE between m.started_at and m.ended_at
GROUP BY trip_date, product     
ORDER BY trip_date
