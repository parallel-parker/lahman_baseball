WITH team_key AS (SELECT teams.yearid, playerid, namefirst, namelast, name
				  FROM managers
				  LEFT JOIN teams
				  ON managers.teamid = teams.teamid
				  AND managers.yearid = teams.yearid
				  LEFT JOIN people
				  USING(playerid))
SELECT awardsmanagers.yearid, namefirst, namelast, name, awardid, lgid
FROM awardsmanagers
LEFT JOIN team_key
USING(playerid, yearid)
WHERE lgid <> 'ML'
AND awardid LIKE 'TSN%'
AND playerid IN
	(SELECT playerid
	FROM awardsmanagers
	WHERE lgid = 'AL'
	AND awardid LIKE 'TSN%'
	INTERSECT
	SELECT playerid
	FROM awardsmanagers
	WHERE lgid = 'NL'
	AND awardid LIKE 'TSN%')
ORDER BY awardsmanagers.yearid;

