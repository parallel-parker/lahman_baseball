SELECT p.namefirst, p.namelast, batting.hr AS top_hr, yearid
FROM batting
INNER JOIN
	(SELECT playerid, MAX(hr)
	FROM batting
	WHERE hr > 1
	GROUP BY playerid
	HAVING COUNT(playerid) >= 10 
	ORDER BY playerid) as max_hr
ON batting.hr = max_hr.max
AND batting.playerid = max_hr.playerid
LEFT JOIN people AS p
ON p.playerid = batting.playerid
WHERE yearid = 2016
ORDER BY batting.playerid