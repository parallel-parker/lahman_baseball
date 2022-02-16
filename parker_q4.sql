SELECT yearid, SUM(po) AS total_putouts,
	   CASE WHEN pos = 'OF' THEN 'Outfield'
	        WHEN pos IN ('SS', '1B','2B','3B') THEN 'Infield'
			ELSE 'Battery' END AS position
FROM fielding
WHERE yearid = 2016
GROUP BY position,yearid;