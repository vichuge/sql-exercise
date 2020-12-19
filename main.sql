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