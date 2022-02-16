/*Q3. Find all players in the database who played at Vanderbilt University. 
Create a list showing each player’s first and last names as well as the total salary they earned in the major leagues. 
Sort this list in descending order by the total salary earned. 
Which Vanderbilt player earned the most money in the majors?*/

--Compared to other Vandy players, David Price earned the most money in the majors. 

--Players who played at Vanderbilt University
SELECT DISTINCT p.namegiven AS Players, p.playerid
FROM people AS p INNER JOIN collegeplaying AS cp ON p.playerid = cp.playerid
				 INNER JOIN schools AS s ON cp.schoolid = s.schoolid
WHERE schoolname = 'Vanderbilt University'

--Players first and last name, and salary earned in major leagues. Order by total salary earned.
SELECT p.namefirst AS first_name, p.namelast AS last_name, SUM(s.salary) OVER(PARTITION BY p.namelast) AS total_salary
FROM salaries AS s INNER JOIN people AS p ON s.playerid = p.playerid
WHERE s.playerid IN
	(SELECT DISTINCT cp.playerid
	 FROM people AS p INNER JOIN collegeplaying AS cp ON p.playerid = cp.playerid
				      INNER JOIN schools AS s ON cp.schoolid = s.schoolid
	 WHERE schoolname = 'Vanderbilt University')
ORDER BY total_salary DESC
