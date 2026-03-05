CREATE OR REPLACE VIEW national_rates AS
	(SELECT 
		dp05.year,
		SUM(homeless::int) AS homeless,
		SUM(pop_est) AS pop_est,
		ROUND((SUM(homeless::numeric)/SUM(pop_est::numeric)) * 100000) AS unhoused_per_100k
	FROM pit_counts
	INNER JOIN dp05 ON pit_counts.state_name = dp05.name
				   AND pit_counts.year = dp05.year
	GROUP BY dp05.year
	ORDER BY year ASC
	);

SELECT *
FROM national_rates
;

SELECT REGR_SLOPE(year, unhoused_per_100k) AS trendline
FROM national_rates
;