/* --- 0 Select basics---*/
SELECT population FROM world
  WHERE name = 'Germany'

SELECT name, population FROM world
  WHERE name IN ('Sweden', 'Norway', 'Denmark')

SELECT name, area FROM world
  WHERE area BETWEEN 200000 AND 250000

/* --- 1 Select name---*/
SELECT name FROM world
  WHERE name LIKE 'Y%'

SELECT name FROM world
  WHERE name LIKE '%y'

SELECT name FROM world
  WHERE name LIKE '%x%'

SELECT name FROM world
  WHERE name LIKE '%land'

SELECT name FROM world
  WHERE name LIKE 'C%ia'

SELECT name FROM world
  WHERE name LIKE '%oo%'

SELECT name FROM world
  WHERE name LIKE '%a%a%a%'

SELECT name FROM world
 WHERE name LIKE '_t%'
ORDER BY name

SELECT name FROM world
 WHERE name LIKE '%o__o%'

SELECT name FROM world
 WHERE name LIKE '____'

SELECT name
  FROM world
 WHERE name LIKE capital

SELECT name
  FROM world
 WHERE capital LIKE concat(name,' city')

Select capital, name
From world
where capital like concat(name,'%')

select capital, name
from world
where capital like concat(name,'_%')

select name, replace(capital, name, '')
from world
where capital like concat(name,'_%')

/* --- 2 Select from world---*/
SELECT name, continent, population FROM world

SELECT name FROM world
WHERE population >= 200000000

SELECT name, (gdp / population) as per_capita_gdp FROM world
WHERE population >= 200000000

select name, (population / 1000000) population_in_millions
from world
where continent = 'South America'

select name, population
from world
where name in('France', 'Germany', 'Italy')

select name
from world
where name like '%United%'

select name, population, area
from world
where area >= 3000000
or population >= 250000000

select name, population, area
from world
where area >= 3000000
xor population >= 250000000

select name, round(population/1000000, 2), round(gdp/1000000000, 2)
from world
where continent= 'South America'

select name, round(gdp / population, -3)
from world
where gdp >= 1000000000000

SELECT name, capital
  FROM world
 WHERE LENGTH(name) = LENGTH(capital)

SELECT name, capital
FROM world
where left(name, 1) = left(capital, 1)
and name != capital

SELECT name
   FROM world
WHERE name not like '% %'
and name like '%a%'
and name like '%e%'
and name like '%i%'
and name like '%o%'
and name like '%u%'

/* --- 3 Select from Nobel---*/
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950

SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'

select yr, subject
from nobel
where winner = 'Albert Einstein'

select winner
from nobel
where subject = 'Peace'
and yr >= 2000

select yr, subject, winner
from nobel
where subject = 'Literature'
and yr between 1980 and 1989

SELECT * FROM nobel
 WHERE winner IN ('Theodore Roosevelt',
                  'Woodrow Wilson',
                  'Jimmy Carter',
                  'Barack Obama')

select winner from nobel
where winner like 'John %'

select yr, subject, winner from nobel
where (yr = 1980 and subject = 'Physics')
or (yr = 1984 and subject = 'Chemistry')

select yr, subject, winner from nobel
where yr = 1980
and subject not in ('Chemistry', 'Medicine')

select yr, subject, winner from nobel
where (subject = 'Medicine' and yr < 1910)
or (subject = 'Literature' and yr >= 2004)

select * from nobel
where winner = 'PETER GRÜNBERG'

select * from nobel
where winner = "EUGENE O\'NEILL"

select winner, yr, subject from nobel
where winner like 'Sir%'
order by yr desc,winner

SELECT winner, subject
  FROM nobel
 WHERE yr=1984
 ORDER BY subject IN ('Physics','Chemistry'),subject,winner

/* --- 4 Select within select---*/
SELECT name FROM world
  WHERE population >
     (SELECT population FROM world
      WHERE name='Russia')

select name
from world
where continent = 'Europe' and
gdp/population > ( select gdp/population from world where name = 'United Kingdom' )

select name, continent from world
where continent = (select continent from world where name = 'Argentina')
or continent = (select continent from world where name = 'Australia')
order by name

select name, population from world
where population > (select population from world where name = 'Canada')
and population < (select population from world where name = 'Polonia')

select name, 
concat(round(100*population/(select population from world where name = 'Germany')),'%')
from world
where continent = 'Europe'

select name from world 
where gdp > (select max(gdp) from world where continent = 'Europe')

SELECT continent, name, area FROM world x
  WHERE area >= ALL
    (SELECT area FROM world y
        WHERE y.continent=x.continent
          AND area>0)

select continent, min(name) as name from world
group by continent
order by continent

select continent, sum(population) as pop from world a
group by continent

/* --- 5 Sum and count---*/
SELECT SUM(population)
FROM world

select continent from world
group by continent

select sum(gdp) from world
where continent = 'Africa'

select count(name) from world
where area >= 1000000

select sum(population) from world
where name in('Estonia', 'Latvia', 'Lithuania')

select continent, count(name) from world
group by continent

select continent, count(name) from world
where population >= 10000000
group by continent

select continent from world a
where 
(select sum(population) from world where continent = a.continent group by continent) >= 100000000
group by continent

/* --- 6 Join---*/
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'

SELECT id,stadium,team1,team2
  FROM game
where id = 1012

SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (id=matchid)
where goal.teamid = 'GER'

select team1, team2, player from game
join goal on id=matchid
where player like 'Mario%'

SELECT player, teamid, coach, gtime
  FROM goal join eteam on teamid=id
 WHERE gtime<=10

select mdate, teamname from game
join eteam on team1=eteam.id
where coach = 'Fernando Santos'

select player from goal
join game on matchid=id
where stadium = 'National Stadium, Warsaw'

SELECT distinct(player)
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' or team2='GER')
and teamid != 'GER'

SELECT teamname, count(gtime)
  FROM eteam JOIN goal ON id=teamid
group by teamname
 ORDER BY teamname

select stadium, count(gtime) from game
join goal on id=matchid
group by stadium

SELECT matchid,mdate, count(gtime)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'POL' OR team2 = 'POL')
group by matchid, mdate

SELECT matchid,mdate, count(gtime)
  FROM game JOIN goal ON matchid = id 
 WHERE (team1 = 'GER' OR team2 = 'GER')
and teamid = 'GER'
group by matchid, mdate

SELECT id,mdate,
  team1,
  CASE WHEN teamid=team1 THEN 
  (select count(gtime) from goal where teamid = team1 and matchid = id) else 0
  END score1,
  team2,
  case when teamid=team2 then 
  (select count(gtime) from goal where teamid = team2 and matchid = id) else 0
  end score2
  FROM game x JOIN goal ON matchid = id
group by id, mdate, team1, teamid, team2
order by mdate

/* --- 7 More join operations---*/
SELECT id, title
 FROM movie
 WHERE yr=1962

select yr from movie
where title = 'Citizen Kane'

select id, title, yr from movie
where title like '%Star Trek%'
order by yr

select id from actor
where name = 'Glenn Close'

select id from movie
where title = 'Casablanca'

select name from movie a
join casting b on a.id=b.movieid
join actor c on b.actorid=c.id
where a.id=11768

select name from movie a
join casting b on a.id=b.movieid
join actor c on b.actorid=c.id
where a.title = 'Alien'

select title from movie a
join casting b on a.id=b.movieid
join actor c on b.actorid=c.id
where c.name = 'Harrison Ford'

select title from movie a
join casting b on a.id=b.movieid
join actor c on b.actorid=c.id
where c.name = 'Harrison Ford'
and b.ord !=1

select a.title, c.name from movie a
join casting b on a.id=b.movieid
join actor c on b.actorid=c.id
where b.ord = 1

SELECT yr,COUNT(title) FROM
  movie JOIN casting ON movie.id=movieid
        JOIN actor   ON actorid=actor.id
WHERE name='Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

/* --- 8 Using null---*/
select name from teacher
where dept is null

SELECT teacher.name, dept.name
 FROM teacher JOIN dept
           ON (teacher.dept=dept.id)

SELECT teacher.name, dept.name
 FROM teacher left JOIN dept
           ON (teacher.dept=dept.id)

SELECT teacher.name, dept.name
 FROM teacher right JOIN dept
           ON (teacher.dept=dept.id)

select name, COALESCE(mobile, '07986 444 2266') from teacher

/* --- 8+ Numeric examples---*/
SELECT A_STRONGLY_AGREE
  FROM nss
 WHERE question='Q01'
   AND institution='Edinburgh Napier University'
   AND subject='(8) Computer Science'

SELECT institution, subject
  FROM nss
 WHERE question='Q15'
   AND score>=100

SELECT institution,score
  FROM nss
 WHERE question='Q15'
   AND score<50
   AND subject='(8) Computer Science'

SELECT subject, sum(response)
  FROM nss
 WHERE question='Q22'
   AND (subject='(8) Computer Science' or subject='(H) Creative Arts and Design')
group by subject

SELECT subject, sum(response*A_STRONGLY_AGREE*.01) 
  FROM nss
 WHERE question='Q22'
   AND (subject='(8) Computer Science' or subject='(H) Creative Arts and Design')
group by subject

SELECT subject, round(sum(response*A_STRONGLY_AGREE/100)/sum(response)*100,0)
  FROM nss
 WHERE question='Q22'
   AND (subject='(8) Computer Science' or subject='(H) Creative Arts and Design')
group by subject

SELECT institution, ROUND(SUM(response*score/100)/SUM(response)*100,0)
  FROM nss
 WHERE question='Q22'
   AND (institution LIKE '%Manchester%')
group by institution
ORDER BY institution

SELECT institution, sum(sample),
(SELECT sample FROM nss y
WHERE subject='(8) Computer Science'
AND x.institution = y.institution
AND question='Q01')
  FROM nss x
 WHERE question='Q01'
   AND (institution LIKE '%Manchester%')
group by institution

/* --- 9- Window function---*/
SELECT lastName, party, votes
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY votes DESC

SELECT party, votes,
       RANK() OVER (ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000024' AND yr = 2017
ORDER BY party

SELECT yr,party, votes,
      RANK() OVER (PARTITION BY yr ORDER BY votes DESC) as posn
  FROM ge
 WHERE constituency = 'S14000021'
ORDER BY party,yr

SELECT constituency, party
FROM ge x 
WHERE constituency BETWEEN 'S14000021' AND 'S14000026'
AND yr  = 2017 AND votes >= ALL(SELECT votes FROM ge y  WHERE x.constituency = y. constituency AND y.yr = 2017)
ORDER BY constituency,votes DESC

SELECT party , COUNT(*)
FROM ge x 
WHERE constituency like 'S%'
AND yr  = 2017 AND votes >= ALL(SELECT votes FROM ge y  WHERE x.constituency = y. constituency AND y.yr = 2017)
GROUP BY party

/* --- 9 Self join---*/
select count(id) from stops

select id from stops where name = 'Craiglockhart'

SELECT id, name FROM stops, route
WHERE id=stop
AND company='LRT'
AND num='4'

