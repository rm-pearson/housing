SELECT 
	year,
	homeless::integer AS pit_count,
	ROUND((homeless::numeric - (LAG(homeless::numeric) OVER (PARTITION BY state ORDER BY year)))/
		(LAG(homeless::numeric) OVER (PARTITION BY state ORDER BY year)) * 100, 2) AS yoy_pct_change
FROM pit_counts
WHERE state_name = 'Virginia'
;