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

/* --- 4 Select within select---*/

/* --- 5 Sum and count---*/

/* --- 6 Join---*/

/* --- 7 More join operations---*/

/* --- 8 Using null---*/

/* --- 8+ Numeric examples---*/

/* --- 9- Window function---*/

/* --- 9+ Covid 19---*/

/* --- 9 Self join---*/