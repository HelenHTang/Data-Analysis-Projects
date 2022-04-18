-- COVID 19 DATA EXPLORATION


-- Preliminary Queries: select data that we are going to be starting with

SELECT *
FROM PortfolioProject..coviddeaths


SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..coviddeaths
ORDER BY 1,2

-- Total Cases VS Total Deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percent
FROM PortfolioProject..coviddeaths
ORDER BY 1,2

--Likelihood of dying if you contract covid in the US

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percent
FROM PortfolioProject..coviddeaths
WHERE location LIKE '%states%'
ORDER BY 1,2

-- Total Cases vs Population
-- Shows what percent of population is infected with covid


SELECT location, date, total_cases, population, (total_cases/population)*100 AS percent_pop_infected
FROM PortfolioProject..coviddeaths
-- WHERE location LIKE '%states%'
ORDER BY 1,2

-- Countries with Highest Infection Rate Compared to Population

SELECT location, population, MAX(total_cases) AS highest_infection_count, MAX((total_cases/population))*100 AS percent_pop_infected
FROM PortfolioProject..coviddeaths
-- WHERE location LIKE '%states%'
GROUP BY location, population
ORDER BY percent_pop_infected DESC


-- Countries with Highest Death Count per Population

SELECT location, MAX(CAST(total_deaths as int)) AS total_death_count
FROM PortfolioProject..coviddeaths
-- WHERE location LIKE '%states%'
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY total_death_count DESC


-- By Continent
-- Shows continents with highest death count per population

SELECT continent, MAX(CAST(total_deaths as int)) AS total_death_count
FROM PortfolioProject..coviddeaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY total_death_count DESC

-- Global Numbers

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths as int)) AS total_deaths, SUM(CAST(new_deaths as int))/SUM(new_cases)*100 AS death_percent
FROM PortfolioProject..coviddeaths
WHERE continent IS NOT NULL
ORDER BY 1,2


-- Preliminary Queries

SELECT *
FROM PortfolioProject..covidvaccinations

SELECT *
FROM PortfolioProject..coviddeaths AS dea
JOIN PortfolioProject..covidvaccinations AS vac
ON dea.location = vac.location
AND dea.date = vac. date

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM PortfolioProject..coviddeaths AS dea
JOIN PortfolioProject..covidvaccinations AS vac
ON dea.location = vac.location
AND dea.date = vac. date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3

-- Total Population vs Vaccinations
-- Shows percentage of population that has received at least one covid vaccine

SELECT dea.continent, dea.location, dea.date, dea.population, vac.total_vaccinations, (vac.total_vaccinations/dea.population)*100 AS percent_pop_vaccinated
FROM PortfolioProject..coviddeaths AS dea
JOIN PortfolioProject..covidvaccinations AS vac
ON dea.location = vac.location
AND dea.date = vac. date
WHERE dea.continent IS NOT NULL
ORDER BY 2,3


-- Creating View to store data for visualization

CREATE VIEW countries_with_highest_death_count AS
SELECT location, MAX(CAST(total_deaths as int)) AS total_death_count
FROM PortfolioProject..coviddeaths
WHERE continent IS NOT NULL
GROUP BY location
--ORDER BY total_death_count DESC

SELECT *
FROM countries_with_highest_death_count


