-- Motor Vehicle Theft in New Zealand
USE stolen_vehicles_db;
-- The number of vehicles stolen each year
SELECT year(date_stolen) AS year_stolen, COUNT(*) AS num_vehicles
FROM stolen_vehicles
GROUP BY year_stolen;

-- The number of vehicles stolen each month
SELECT monthname(date_stolen) AS month_stolen, COUNT(*) AS num_vehicles
FROM stolen_vehicles
GROUP BY month_stolen
ORDER BY num_vehicles DESC;

-- The number of vehicles stolen each day of the week
SELECT dayofweek(date_stolen) AS dow, COUNT(*) AS num_vehicles
FROM stolen_vehicles
GROUP BY dow
ORDER BY num_vehicles DESC;	

-- The full name of each day of the week (Sunday, Monday, Tuesday, etc.)
SELECT 
	dayofweek(date_stolen) AS dow,
	CASE WHEN dayofweek(date_stolen) = 1 THEN 'Sunday'
		 WHEN dayofweek(date_stolen) = 2 THEN 'Monday'
         WHEN dayofweek(date_stolen) = 3 THEN 'Tuesday'
         WHEN dayofweek(date_stolen) = 4 THEN 'Wednesday'
         WHEN dayofweek(date_stolen) = 5 THEN 'Thursday'
         WHEN dayofweek(date_stolen) = 6 THEN 'Friday'
         ELSE 'Saturday'
	END AS day_stolen,
    COUNT(*) AS num_vehicles
FROM stolen_vehicles
GROUP BY dayofweek(date_stolen), day_stolen
ORDER BY dow;

-- Vehicle types that are most often stolen
SELECT vehicle_type, COUNT(*) AS num_stolen
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY num_stolen DESC;

-- Vehicle types that are least often stolen
SELECT vehicle_type, COUNT(*) AS num_stolen
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY num_stolen;

-- The average age of the cars that are stolen for each vehicle type
SELECT vehicle_type, AVG(year(date_stolen) - model_year) AS avg_age
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY avg_age DESC;	

-- The percent of vehicles stolen that are luxury for each vehicle type
WITH lux_stand AS (
	SELECT sv.vehicle_type,
		CASE WHEN md.make_type = 'Luxury' THEN 1 ELSE 0 END AS luxury
	FROM stolen_vehicles AS sv
	LEFT JOIN make_details AS md
	ON sv.make_id = md.make_id)

SELECT vehicle_type, 
	ROUND(sum(luxury) * 100 / COUNT(*), 1) AS perc_luxury
FROM lux_stand
GROUP BY vehicle_type
ORDER BY perc_luxury DESC;

-- A table where the rows represent the top 10 vehicle types, the columns represent the top 7 vehicle colors (plus 1 column for all other colors) 
-- and the values are the number of vehicles stolen
SELECT COUNT(DISTINCT color)
FROM stolen_vehicles;

SELECT color, COUNT(*) AS num_vehicles
FROM stolen_vehicles
GROUP BY color
ORDER BY num_vehicles DESC
LIMIT 7;

SELECT
	vehicle_type, COUNT(*) AS num_vehicles,
    SUM(CASE WHEN color = 'Silver' THEN 1 ELSE 0 END) AS silver_vehicles,
    SUM(CASE WHEN color = 'White' THEN 1 ELSE 0 END) AS white_vehicles,
    SUM(CASE WHEN color = 'Black' THEN 1 ELSE 0 END) AS black_vehicles,
    SUM(CASE WHEN color = 'Blue' THEN 1 ELSE 0 END) AS blue_vehicles,
    SUM(CASE WHEN color = 'Red' THEN 1 ELSE 0 END) AS red_vehicles,
    SUM(CASE WHEN color = 'Grey' THEN 1 ELSE 0 END) AS grey_vehicles,
    SUM(CASE WHEN color = 'Green' THEN 1 ELSE 0 END) AS green_vehicles,
    SUM(CASE WHEN color NOT IN ('Silver', 'White', 'Black', 'Blue', 'Red', 'Grey', 'Green') THEN 1 ELSE 0 END) AS other_colors
FROM stolen_vehicles
GROUP BY vehicle_type
ORDER BY num_vehicles DESC
LIMIT 10;

-- The number of vehicles that were stolen in each region
SELECT ls.region, COUNT(sv.vehicle_id) AS num_vehicles
FROM stolen_vehicles AS sv
LEFT JOIN locations AS ls
ON sv.location_id = ls.location_id
GROUP BY ls.region
ORDER BY num_vehicles DESC;

-- Combine the previous output with the population and density statistics for each region
SELECT ls.region, COUNT(sv.vehicle_id) AS num_vehicles, ls.population, ls.density
FROM stolen_vehicles AS sv
LEFT JOIN locations AS ls
ON sv.location_id = ls.location_id
GROUP BY ls.region, ls.population, ls.density
ORDER BY num_vehicles DESC;	

-- Type of vehicles stolen in the three most dense regions and the three least dense regions?
SELECT ls.region, COUNT(sv.vehicle_id) AS num_vehicles, ls.population, ls.density
FROM stolen_vehicles AS sv
LEFT JOIN locations AS ls
ON sv.location_id = ls.location_id
GROUP BY ls.region, ls.population, ls.density
ORDER BY density DESC   -- order desc or asc to get the 3 most or 3 least regions
LIMIT 3;	
-- added a column to show high and low density vehicle types
(SELECT 'High density', sv.vehicle_type, COUNT(sv.vehicle_id) AS num_vehicles
FROM stolen_vehicles AS sv
LEFT JOIN locations AS ls
ON sv.location_id = ls.location_id
WHERE region IN ('Auckland', 'Nelson', 'Wellington')
GROUP BY sv.vehicle_type
ORDER BY num_vehicles DESC
LIMIT 5)

UNION

(SELECT 'Low Density', sv.vehicle_type, COUNT(sv.vehicle_id) AS num_vehicles
FROM stolen_vehicles AS sv
LEFT JOIN locations AS ls
ON sv.location_id = ls.location_id
WHERE region IN ('Otago', 'Gisborne', 'Southland')
GROUP BY sv.vehicle_type
ORDER BY num_vehicles DESC
LIMIT 5);