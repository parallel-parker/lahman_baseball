/*From 1970 – 2016, what is the largest number of wins for a team that did not win the world series? 
What is the smallest number of wins for a team that did win the world series? 
Doing this will probably result in an unusually small number of wins for a world series champion
– determine why this is the case. Then redo your query, excluding the problem year.
How often from 1970 – 2016 was it the case that a team with the most wins also won the world series? 
What percentage of the time?*/

--Largest # wins that didn't win the World Series
SELECT MAX(W)
FROM teams
WHERE (yearid BETWEEN 1970 AND 2016) 
AND WSWIN = 'N'

--Smallest # of wins that did win the World Series
SELECT MIN(W)
FROM teams
WHERE yearid <> 1981 AND yearid BETWEEN 1970 AND 2016
AND (WSWIN = 'Y')
/*1981 had significantly fewer games played compared to the rest of the years and therefore
resulted in fewer wins*/

--How often did teams with the most wins also win the world series, and find the percentage
WITH max_winners AS (SELECT MAX(W) AS max_wins, yearid
					 FROM teams
					 WHERE yearid BETWEEN 1970 AND 2016
					 GROUP BY yearid
					 ORDER BY yearid)
SELECT t.WSWIN AS won_world_series, 
	   COUNT(mw.max_wins),
	   CASE WHEN t.WSWIN = 'Y' THEN ROUND(COUNT(mw.max_wins)/SUM(COUNT(mw.max_wins)) OVER(),3) END AS percentage_yes,
	   CASE WHEN t.WSWIN = 'N' THEN ROUND(COUNT(mw.max_wins)/SUM(COUNT(mw.max_wins)) OVER (),3) END AS percentage_no
FROM teams AS t INNER JOIN max_winners AS mw ON t.yearid = mw.yearid AND t.W = mw.max_wins
WHERE t.yearid BETWEEN 1970 AND 2016 
	  AND WSWIN IS NOT NULL
GROUP BY t.WSWIN

