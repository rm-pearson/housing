SELECT 
	*,
	ROUND((homeless::numeric/pop_est::numeric) * 100000) AS unhoused_per_100k
FROM
	(SELECT 
		dp05.year,
		SUM(homeless::int) AS homeless,
		SUM(pop_est) AS pop_est
	FROM pit_counts
	INNER JOIN dp05 ON pit_counts.state_name = dp05.name
				   AND pit_counts.year = dp05.year
	GROUP BY dp05.year
	) AS nat_homless
ORDER BY year ASC;
