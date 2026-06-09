CREATE DATABASE cyclistic_db ;
USE cyclistic_db ;
SELECT COUNT(*) FROM bike_trips ;
SELECT 
    member_casual AS rider_type,
    COUNT(*) AS total_rides,
    ROUND(COUNT(*) * 100.0 / 
        (SELECT COUNT(*) FROM bike_trips), 1) AS percentage
FROM bike_trips
GROUP BY member_casual
ORDER BY total_rides DESC;
SELECT 
    member_casual AS rider_type,
    ROUND(AVG(ride_length), 1) AS avg_ride_mins,
    ROUND(MIN(ride_length), 1) AS shortest_ride_mins,
    ROUND(MAX(ride_length), 1) AS longest_ride_mins,
    ROUND(SUM(ride_length) / 60, 0) AS total_hours_ridden
FROM bike_trips
GROUP BY member_casual
ORDER BY avg_ride_mins DESC;
SELECT 
    member_casual AS rider_type,
    day_name,
    day_of_week,
    COUNT(*) AS total_rides,
    ROUND(AVG(ride_length), 1) AS avg_ride_mins
FROM bike_trips
GROUP BY member_casual, day_name, day_of_week
ORDER BY member_casual, day_of_week;
SELECT 
    member_casual AS rider_type,
    hour,
    COUNT(*) AS total_rides,
    ROUND(AVG(ride_length), 1) AS avg_ride_mins
FROM bike_trips
GROUP BY member_casual, hour
ORDER BY member_casual, hour;
SELECT 
    member_casual AS rider_type,
    rideable_type AS bike_type,
    COUNT(*) AS total_rides,
    ROUND(COUNT(*) * 100.0 / 
        SUM(COUNT(*)) OVER 
        (PARTITION BY member_casual), 1) AS percentage
FROM bike_trips
GROUP BY member_casual, rideable_type
ORDER BY member_casual, total_rides DESC;
SELECT 
    rider_type,
    hour,
    total_rides,
    peak_rank
FROM (
    SELECT 
        member_casual AS rider_type,
        hour,
        COUNT(*) AS total_rides,
        RANK() OVER (
            PARTITION BY member_casual 
            ORDER BY COUNT(*) DESC
        ) AS peak_rank
    FROM bike_trips
    GROUP BY member_casual, hour
) AS ranked
WHERE peak_rank <= 3
ORDER BY rider_type, peak_rank;
SELECT 
    start_station_name,
    COUNT(*) AS total_rides
FROM bike_trips
WHERE member_casual = 'casual'
    AND start_station_name IS NOT NULL
GROUP BY start_station_name
ORDER BY total_rides DESC
LIMIT 10;
SELECT 
    member_casual AS rider_type,
    CASE 
        WHEN day_of_week IN (1, 7) THEN 'Weekend'
        ELSE 'Weekday'
    END AS day_type,
    COUNT(*) AS total_rides,
    ROUND(AVG(ride_length), 1) AS avg_ride_mins
FROM bike_trips
GROUP BY member_casual, day_type
ORDER BY member_casual, day_type;
SELECT 
    member_casual AS rider_type,
    COUNT(*) AS total_rides,
    ROUND(COUNT(*) * 100.0 / 
        (SELECT COUNT(*) FROM bike_trips), 1) AS pct_of_total,
    ROUND(AVG(ride_length), 1) AS avg_ride_mins,
    ROUND(SUM(ride_length) / 60, 0) AS total_hours,
    SUM(CASE WHEN day_of_week IN (1,7) 
        THEN 1 ELSE 0 END) AS weekend_rides,
    SUM(CASE WHEN day_of_week NOT IN (1,7) 
        THEN 1 ELSE 0 END) AS weekday_rides,
    SUM(CASE WHEN hour BETWEEN 7 AND 9 
        THEN 1 ELSE 0 END) AS morning_commute_rides,
    SUM(CASE WHEN hour BETWEEN 16 AND 18 
        THEN 1 ELSE 0 END) AS evening_commute_rides
FROM bike_trips
GROUP BY member_casual
ORDER BY total_rides DESC;