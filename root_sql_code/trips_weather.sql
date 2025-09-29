-----------------------------------------------------------------------------------------------
--- Join trips with weather data to compare daily insured trips vs rainfall grouped by product
-----------------------------------------------------------------------------------------------
SELECT
    DATE(m.started_at) AS trip_date,
    m.rideable_type    AS product,
    COUNT(*)           AS insured_trip_count,
    SUM(w.rain)        AS total_rainfall    
FROM TRIPS m
LEFT JOIN weather w
    ON w.DATE between m.started_at and m.ended_at
GROUP BY trip_date, product     
ORDER BY trip_date;