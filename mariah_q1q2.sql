--1. What range of years for baseball games played does the provided database cover?
SELECT MIN(debut) AS earliest_debut, MAX(finalgame) AS final_game
FROM people
/*2. Find the name and height of the shortest player in the database. 
How many games did he play in? What is the name of the team for which he played?*/
SELECT p.namegiven AS name, height, G_all, t.name AS team
FROM people AS p INNER JOIN appearances AS a ON p.playerid = a.playerid 
				 INNER JOIN teams AS t ON a.teamid=t.teamid
ORDER BY height
LIMIT 1

