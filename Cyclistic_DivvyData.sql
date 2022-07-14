-- Create table merging the year 2021 and adding additional fields to ease analysis
CREATE TABLE 	
	Cyclistic_Trips_year_2021 AS
SELECT 
	*,
	TIMESTAMPDIFF(SECOND, started_at, ended_at) as ride_lenght,
	DAYNAME(started_at) AS day_of_the_week, 
	MONTHNAME(started_at) AS month,
	YEAR(started_at) AS year
FROM Cyclistic_Trips_2021_01 ct UNION ALL
SELECT 
	*,
	TIMESTAMPDIFF(SECOND, started_at, ended_at) as ride_lenght,
	DAYNAME(started_at) AS day_of_the_week, 
	MONTHNAME(started_at) AS month,
	YEAR(started_at) AS year
FROM Cyclistic_Trips_2021_02 ct2 UNION ALL
SELECT 
	*,
	TIMESTAMPDIFF(SECOND, started_at, ended_at) as ride_lenght,
	DAYNAME(started_at) AS day_of_the_week, 
	MONTHNAME(started_at) AS month,
	YEAR(started_at) AS year
FROM Cyclistic_Trips_2021_03 ct3 UNION ALL
SELECT 
	*,
	TIMESTAMPDIFF(SECOND, started_at, ended_at) as ride_lenght,
	DAYNAME(started_at) AS day_of_the_week, 
	MONTHNAME(started_at) AS month,
	YEAR(started_at) AS year
FROM Cyclistic_Trips_2021_04 ct4 UNION ALL
SELECT 
	*,
	TIMESTAMPDIFF(SECOND, started_at, ended_at) as ride_lenght,
	DAYNAME(started_at) AS day_of_the_week, 
	MONTHNAME(started_at) AS month,
	YEAR(started_at) AS year
FROM Cyclistic_Trips_2021_05 ct5  UNION ALL
SELECT 
	*,
	TIMESTAMPDIFF(SECOND, started_at, ended_at) as ride_lenght,
	DAYNAME(started_at) AS day_of_the_week, 
	MONTHNAME(started_at) AS month,
	YEAR(started_at) AS year
FROM Cyclistic_Trips_2021_06 ct6  UNION ALL
SELECT 
	*,
	TIMESTAMPDIFF(SECOND, started_at, ended_at) as ride_lenght,
	DAYNAME(started_at) AS day_of_the_week, 
	MONTHNAME(started_at) AS month,
	YEAR(started_at) AS year
FROM Cyclistic_Trips_2021_07 ct7 UNION ALL
SELECT 
	*,
	TIMESTAMPDIFF(SECOND, started_at, ended_at) as ride_lenght,
	DAYNAME(started_at) AS day_of_the_week, 
	MONTHNAME(started_at) AS month,
	YEAR(started_at) AS year
FROM Cyclistic_Trips_2021_08 ct8 UNION ALL
SELECT 
	*,
	TIMESTAMPDIFF(SECOND, started_at, ended_at) as ride_lenght,
	DAYNAME(started_at) AS day_of_the_week, 
	MONTHNAME(started_at) AS month,
	YEAR(started_at) AS year
FROM Cyclistic_Trips_2021_09 ct9 UNION ALL
SELECT 
	*,
	TIMESTAMPDIFF(SECOND, started_at, ended_at) as ride_lenght,
	DAYNAME(started_at) AS day_of_the_week, 
	MONTHNAME(started_at) AS month,
	YEAR(started_at) AS year
FROM Cyclistic_Trips_2021_10 ct10  UNION ALL
SELECT 
	*,
	TIMESTAMPDIFF(SECOND, started_at, ended_at) as ride_lenght,
	DAYNAME(started_at) AS day_of_the_week, 
	MONTHNAME(started_at) AS month,
	YEAR(started_at) AS year
FROM Cyclistic_Trips_2021_11 ct11 UNION ALL
SELECT 
	*,
	TIMESTAMPDIFF(SECOND, started_at, ended_at) as ride_lenght,
	DAYNAME(started_at) AS day_of_the_week, 
	MONTHNAME(started_at) AS month,
	YEAR(started_at) AS year
FROM Cyclistic_Trips_2021_12 ct12 

-- Check duplicate ride_ids
SELECT 
	COUNT(DISTINCT ride_id),
	COUNT(ride_id) 
FROM Cyclistic_Trips_year_2021 

SELECT COUNT(ride_id)
FROM Cyclistic_Trips_year_2021

-- Check rides with negative time traveled
-- keep the rides with 0 time traveled to be potential analysis 
SELECT *
FROM Cyclistic_Trips_year_2021 cty 
WHERE ride_lenght <0

-- Delete those rides with negative time traveled
DELETE FROM Cyclistic_Trips_year_2021 
WHERE ride_lenght <0

-- Perform quick analysis 

-- Analyse number of rides between members and causal riders
SELECT 
	member_casual,
	`month`,
	COUNT(*) 
FROM Cyclistic_Trips_year_2021 cty 
GROUP BY member_casual, `month`  
ORDER BY `month` 

-- Average number of rides by weekday 
SELECT 
	day_of_the_week,
	member_casual,
	COUNT(*)
FROM Cyclistic_Trips_year_2021 cty 
GROUP BY 
	day_of_the_week,
	member_casual 
ORDER BY 
CASE day_of_the_week
WHEN 'Monday' THEN 1
WHEN 'Tuesday' THEN 2
WHEN 'Wednesday' THEN 3
WHEN 'Thursday' THEN 4
WHEN 'Friday' THEN 5
WHEN 'Saturday' THEN 6
WHEN 'Sunday' THEN 7
END ASC 

-- difference in average ride length between casual and members
SELECT 
	member_casual,
	ROUND(AVG(ride_lenght), 2) AS avg_leng_seconds
FROM Cyclistic_Trips_year_2021 cty 
GROUP BY member_casual 

-- average ride length by weekday 
SELECT 
	day_of_the_week,
	member_casual, 
	ROUND(AVG(ride_lenght), 2) as avg_time_seconds 
FROM Cyclistic_Trips_year_2021 cty 
GROUP BY 
	day_of_the_week,
	member_casual 
ORDER BY 
CASE day_of_the_week
WHEN 'Monday' THEN 1
WHEN 'Tuesday' THEN 2
WHEN 'Wednesday' THEN 3
WHEN 'Thursday' THEN 4
WHEN 'Friday' THEN 5
WHEN 'Saturday' THEN 6
WHEN 'Sunday' THEN 7
END ASC 

-- difference in ride type by members or casual riders
SELECT 
	rideable_type,
	member_casual,
	COUNT(*) 
FROM Cyclistic_Trips_year_2021 cty 
GROUP BY 
	rideable_type,
	member_casual 
	
