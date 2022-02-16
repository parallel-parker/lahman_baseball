--highest 5 average attendance
WITH team_key AS (SELECT DISTINCT teamid, name
				  FROM teams
				  WHERE yearid = 2016)
SELECT park_name, homegames.team, name, attendance / games AS avg_attendance
FROM homegames
INNER JOIN parks
USING(park)
LEFT JOIN team_key
ON homegames.team = team_key.teamid
WHERE homegames.year = 2016
AND homegames.games >= 10
ORDER BY avg_attendance DESC
LIMIT 5;

--lowest 5 average attendance 
WITH team_key AS (SELECT DISTINCT teamid, name
				  FROM teams
				  WHERE yearid = 2016)
SELECT park_name, homegames.team, name, attendance / games AS avg_attendance
FROM homegames
INNER JOIN parks
USING(park)
LEFT JOIN team_key
ON homegames.team = team_key.teamid
WHERE homegames.year = 2016
AND homegames.games >= 10
ORDER BY avg_attendance
LIMIT 5;