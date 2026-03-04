CREATE EXTENSION IF NOT EXISTS tablefunc;

CREATE OR REPLACE VIEW state_rates AS(
	SELECT
		state_name,
		dp05.year,
		ROUND((homeless::numeric/pop_est::numeric) * 100000) AS unhoused_per_100k
	FROM pit_counts
	INNER JOIN dp05 ON pit_counts.state_name = dp05.name
				   AND pit_counts.year = dp05.year
);


-- highest avg homelessness rates
SELECT 
	state_name,
	ROUND(AVG(unhoused_per_100k)) AS state_avg
FROM state_rates
GROUP BY state_name
ORDER BY state_avg DESC
LIMIT 5
;

-- lowest avg homelessness rates
SELECT 
	state_name,
	ROUND(AVG(unhoused_per_100k)) AS state_avg
FROM state_rates
GROUP BY state_name
ORDER BY state_avg ASC
LIMIT 5
;

-- highest overall
SELECT *
FROM state_rates
ORDER BY unhoused_per_100k DESC
LIMIT 5;

-- lowest overall
SELECT *
FROM state_rates
ORDER BY unhoused_per_100k ASC
LIMIT 5;


-- largest single-year increases (by % change)
SELECT *
FROM
	(SELECT *,
		ROUND(-(1-(unhoused_per_100k / LAG(unhoused_per_100k, 1) OVER (PARTITION BY state_name ORDER BY year))) * 100, 2) AS pct_change
	FROM state_rates
	) AS rates_of_change
WHERE year <> '2009'
ORDER BY pct_change DESC
LIMIT 5
;

-- largest single-year decreases (by % change)
SELECT *
FROM
	(SELECT *,
		ROUND(-(1-(unhoused_per_100k / LAG(unhoused_per_100k, 1) OVER (PARTITION BY state_name ORDER BY year))) * 100, 2) AS pct_change
	FROM state_rates
	) AS rates_of_change
WHERE year <> '2009'
ORDER BY pct_change ASC
LIMIT 5
;


-- Observation / point to pursue: several of the largest yoy decreases were in 2021, and then several of the largest increases were in 2022! 


SELECT *
FROM crosstab(
	'SELECT state_name, year, unhoused_per_100k FROM state_rates ORDER BY state_name, year',
	'SELECT DISTINCT year FROM state_rates ORDER BY year'
	) AS ct(state_name text, "2009" int, "2010" int, "2011" int, "2012" int, "2013" int, "2014" int, "2015" int, "2016" int, "2017" int, "2018" int, "2019" int, "2020" int, "2021" int, "2022" int, "2023" int, "2024" int);
