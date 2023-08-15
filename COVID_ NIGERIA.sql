SELECT *
FROM SQLPROJECT.DBO.DEATH_RATE
WHERE location LIKE '%NIGERIA%'

--CREATED A TABLE TO LOOK INTO COVID IN NIGERIA

DROP TABLE IF EXISTS #COVID_NIGERIA

CREATE TABLE #COVID_NIGERIA
(CONTINENT VARCHAR (100),
LOCATION VARCHAR (100),
DATE DATETIME,
POPULATION INT, 
TOTAL_CASES INT,
NEW_CASES INT,
TOTAL_DEATHS INT,
NEW_DEATH INT)

INSERT INTO #COVID_NIGERIA
SELECT DBO.DEATH_RATE.continent,DBO.DEATH_RATE.location,DBO.DEATH_RATE.date,DBO.DEATH_RATE.population,DBO.DEATH_RATE.total_cases,DBO.DEATH_RATE.new_cases,DBO.DEATH_RATE.total_deaths,DBO.DEATH_RATE.new_deaths 
FROM SQLPROJECT.DBO.DEATH_RATE
WHERE location LIKE '%NIGERIA%'

SELECT *
FROM #COVID_NIGERIA

--SHOW TOTAL NUMBER OF PEOPLE WHO DIED FROM COVID IN NIGERIA

SELECT continent,location,population,total_cases,new_cases,total_deaths,new_death,
CAST (TOTAL_DEATHS AS decimal) / CAST (POPULATION AS decimal) * 100 AS NGN_DEATH_RATE
FROM #COVID_NIGERIA
ORDER BY 1,2

--SHOWS AMOUT OF PEOPLE THAT GOT COVID BY THE DAY IN NIGERIA

SELECT continent,location,population,total_cases,new_cases,total_deaths,new_death,
CAST (TOTAL_CASES AS decimal) / CAST ( POPULATION AS decimal) *100 AS INFECTED_RATE
FROM #COVID_NIGERIA
ORDER BY 1,2


--TOTAL DEATH IN NIGEERIA 

SELECT SUM (TOTAL_DEATHS) AS TDR
FROM #COVID_NIGERIA

SELECT LOCATION, DATE, SUM (TOTAL_DEATHS) 
FROM #COVID_NIGERIA
WHERE TOTAL_DEATHS IS NOT NULL
GROUP BY DATE, LOCATION
ORDER BY 1,2,3

SELECT LOCATION, DATE, SUM (TOTAL_DEATHS) OVER ( PARTITION BY LOCATION ORDER BY DATE,LOCATION) AS DDT
FROM #COVID_NIGERIA
WHERE TOTAL_DEATHS IS NOT NULL
ORDER BY 1,2,3

--SHOW TOTAL NUMBER OF PEOPLE NEW DEATHS FROM COVID IN NIGERIA

SELECT continent,location,population,total_cases,new_cases,total_deaths,new_death,
CAST (NEW_DEATH AS decimal) / CAST (POPULATION AS decimal) * 100 AS NEW_NGN_DEATH_RATE
FROM #COVID_NIGERIA
ORDER BY 1,2

--SHOWS AMOUT OF NEW PEOPLE THAT GOT COVID BY THE DAY IN NIGERIA

SELECT continent,location,population,total_cases,new_cases,total_deaths,new_death,
CAST (NEW_CASES AS decimal) / CAST ( POPULATION AS decimal) * 100 AS NEW_INFECTED_RATE
FROM #COVID_NIGERIA
ORDER BY 1,2








