# SQL Query Documentation

This document records the SQL queries used during the exploration and analysis of the COVID-19 datasets. Queries are grouped by purpose to clearly show the analytical workflow, from validation checks to exploratory analysis and, later, deeper insights.

---

## 1. Data Validation Queries

These queries were used to confirm that data was successfully imported into PostgreSQL and that the tables contain the expected number of records.

```sql
SELECT COUNT(*) FROM public.covid_vaccinations;
```
**Explanation:**
This query counts the total number of rows in the covid_vaccinations table. It was used to verify that the CSV import completed successfully and that all records were loaded into the database.

## 2. Exploratory Queries

Exploratory queries were used to inspect the structure of the data, confirm column alignment, and understand how records are organised across locations and dates.

```sql
SELECT *
FROM public.covid_vaccinations
ORDER BY location, date
LIMIT 20;
```

**Explanation:**
This query previews a small sample of the vaccination dataset, ordered by location and date. It was used to confirm that dates were parsed correctly, data was ordered chronologically within each country, and columns were aligned as expected after import.

## 3. Exploratory Queries – COVID Deaths Dataset
```sql
SELECT
  location,
  date,
  total_cases,
  new_cases,
  total_deaths,
  population
FROM public.covid_deaths
ORDER BY location, date
LIMIT 20;
```
**Explanation:**
This query explores the COVID deaths dataset by selecting key case, death, and population columns and ordering the results by country and date. It is used to verify the timeline of reported cases and deaths for each location and to confirm that the data is structured correctly for time-based analysis.

## 4. Death Percentage Over Time – United States

```sql
SELECT
  location,
  date,
  total_cases,
  total_deaths,
  (total_deaths / NULLIF(total_cases, 0)) * 100 AS percentage_death
FROM public.covid_deaths
WHERE location = 'United States'
ORDER BY location, date;
```
**Explanation:**
This query calculates the percentage of deaths from total cases for the United States by date by dividing total deaths by total cases and multiplying by 100, then orders the results by location and date.

## 5. Countries with the Highest Infection Rate Relative to Population

```sql
SELECT 
  Location, 
  Population, 
  MAX(total_cases) AS HighestInfectionCount, 
  MAX(COALESCE((total_cases / population), 0)*100) PercentPopulationInfected
FROM public.covid_deaths
GROUP BY Location, Population
ORDER BY PercentPopulationInfected DESC;
```
![3](/assets/3.png)
**Explanation:**
This query groups the data by each country (and its population), finds the highest recorded total cases for each country, calculates the highest percentage of the population infected, and then sorts countries from highest to lowest infection percentage.

Aggregate functions are SQL functions that take many rows of data and return a single summary value, such as `COUNT()` to count rows, `SUM()` to add values, `AVG()` to find the average, `MIN()` to get the smallest value, and `MAX()` to get the largest value.

When I mix aggregate functions with non-aggregated columns, SQL needs a GROUP BY to define how rows are grouped, and every non-aggregated column in the SELECT clause must appear in the GROUP BY so each group produces one clear, unambiguous result.

## 6. Countries with the Highest Death Rate Relative to Population

```sql
SELECT
  location,
  population,
  Max(total_deaths) as HighestDeathCount,
  Max((total_deaths/population))*100 as PercentagePopulationDeath
FROM public.covid_deaths
GROUP BY location, population
ORDER BY PercentagePopulationDeath desc
```
**Explanation:**
This query groups data by country and population, finds the highest recorded total deaths for each country, calculates the highest percentage of the population that died from COVID-19, and then orders countries from highest to lowest death percentage.

## 7. Regions with the Highest Total Death Count
```sql
SELECT
  location,
  SUM(new_deaths) as totalDeathCount
FROM public.covid_deaths
WHERE continent is null
	and location not in ('World', 'European Union', 'International') 
GROUP BY location
ORDER BY totalDeathCount desc
```
![2](/assets/2.png)

**Explanation:**
This query groups non-country aggregate records by location, excludes global summary rows, calculates the total number of deaths by summing daily new deaths for each location, and orders the results from the highest to the lowest total death count.

## 8. Non-Country Records with the Highest Total Death Count
```sql
SELECT
  location,
  MAX(total_deaths) AS total_death_count
FROM public.covid_deaths
WHERE continent IS NULL
GROUP BY location
ORDER BY total_death_count DESC;
```
**Explanation:**
This query groups the data by non-country locations (such as continents or regions), finds the maximum total deaths for each one, and orders the results from highest to lowest total death count.

## 9. Daily New Cases Across All Countries
```sql
SELECT
  location,
  Max(total_deaths) as totalDeathCount
FROM public.covid_deaths
WHERE continent is null
GROUP BY location
ORDER BY totalDeathCount desc
```
**Explanation:**
This query calculates the total number of new COVID-19 cases per day across all countries and orders the results by date and daily case count.

## 10. continent IS NOT NUL vs continent IS NUL
When continent IS NOT NULL, the continent column contains continent names (like Africa or Europe) and the location column contains countries that belong to those continents; when continent IS NULL, there is no continent value, and the location column is used for non-country summaries such as continents, regions, income groups, or the world itself. For Example:
| location      | continent     | date       | new_cases | total_deaths |
| ------------- | ------------- | ---------- | --------- | ------------ |
| Nigeria       | Africa        | 2020-03-01 | 1         | 0            |
| United States | North America | 2020-03-01 | 30        | 1            |
| France        | Europe        | 2020-03-01 | 20        | 0            |
|   Africa      |   NULL        | 2020-03-01 | 51        | 1            |
|   Europe      |   NULL        | 2020-03-01 | 20        | 0            |
|   World       |   NULL        | 2020-03-01 | 102       | 2            |

## 11. Daily New Cases and Deaths (Sorted by New Cases)
```sql
SELECT
  date,
  SUM(new_cases) as dailynewcases,
  SUM(new_deaths) as dailynewdeaths
FROM public.covid_deaths
WHERE continent is not null
GROUP BY date
ORDER BY 2 desc
```
**Explanation:**
This query calculates the total number of new COVID-19 cases and new deaths per day across all countries, then sorts the days from the highest to the lowest number of new cases.


## 12. Daily New Cases and Deaths (Sorted by New Deaths)
```sql
SELECT
  date,
  SUM(new_cases) as dailynewcases,
  SUM(new_deaths) as dailynewdeaths
FROM public.covid_deaths
WHERE continent is not null
GROUP BY date
ORDER BY 3 desc
```
**Explanation:**
This query calculates total daily new cases and deaths across all countries and then sorts the results by the daily number of deaths in descending order.


## 13. Daily Global Death Percentage
```sql
SELECT
  date,
  SUM(new_cases) as dailynewcases,
  SUM(new_deaths) as dailynewdeaths,
  SUM(new_deaths)/SUM(new_cases)*100 as dailydeathpercentage
FROM public.covid_deaths
WHERE continent is not null
GROUP BY date
ORDER BY 1
```
**Explanation:**
This query calculates daily global totals for new cases and deaths, computes the daily death percentage from those totals, and orders the results by date.

## 14. Overall Global Death Percentage
```sql
SELECT
  SUM(new_cases) as totalcases,
  SUM(new_deaths) as totaldeaths,
  SUM(new_deaths)/SUM(new_cases)*100 as totaldeathpercentage
FROM public.covid_deaths
WHERE continent is not null
```
![1](/assets/1.png)

**Explanation:**
This query calculates the total number of COVID-19 cases and deaths across all countries and then computes the overall death percentage from those totals.

## 15. Joining COVID Deaths and Vaccination Data
```sql
SELECT *
FROM public.covid_deaths dea
Join public.covid_vaccinations vac
  On dea.location = vac.location
  and dea.date = vac.date
```
**Explanation:**
This query joins the COVID deaths and vaccinations tables by matching rows with the same location and date, returning combined data from both tables.

## 16. Daily Vaccination Data by Country
```sql
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
FROM public.covid_deaths dea
Join public.covid_vaccinations vac
  On dea.location = vac.location
  and dea.date = vac.date
WHERE dea.continent is not null
ORDER by 2, 3
```
**Explanation:**
This query joins deaths and vaccination data by location and date, keeps only country-level records, and displays each country’s daily population and new vaccinations ordered by location and date.

## 17. Rolling Total of Vaccinations by Country
```sql
SELECT 
	dea.continent, 
	dea.location, 
	dea.date, 
	dea.population, 
	vac.new_vaccinations, 
	SUM(vac.new_vaccinations) OVER(Partition by dea.Location Order by dea.location, dea.date) as RollingPeopleVaccinated
FROM public.covid_deaths dea
Join public.covid_vaccinations vac
  On dea.location = vac.location
  and dea.date = vac.date
WHERE dea.continent is not null
ORDER by 2, 3
```
**Explanation:**
This query joins deaths and vaccination data and uses a window function to calculate a running total of people vaccinated for each country over time, ordered by date.

It joins deaths and vaccination data by location and date, filters to country-level rows using continent IS NOT NULL, and keeps all daily records instead of grouping them. It uses a window function, SUM(new_vaccinations) OVER (PARTITION BY location ORDER BY date), to calculate a running total of vaccinations for each country over time without collapsing rows. This is different from GROUP BY, which would return one row per group instead of showing daily progress.

For example:
| location | date       | new_vaccinations | rolling_vaccinations |
| -------- | ---------- | ---------------- | -------------------- |
| UK       | 2021-01-01 | 100              | 100                  |
| UK       | 2021-01-02 | 150              | 250                  |
| UK       | 2021-01-03 | 200              | 450                  |
-- The window function adds up vaccinations row by row, keeping all rows visible, instead of collapsing everything into one row like GROUP BY would.

## 18. Percentage of Population Vaccinated Using a CTE
```sql
WITH PopvsVac (continent, location, date, population, new_vaccinations, rolling_people_vaccinated) AS
(
  SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(COALESCE(vac.new_vaccinations, 0)) OVER (
      PARTITION BY dea.location
      ORDER BY dea.date
    ) AS rolling_people_vaccinated
  FROM public.covid_deaths dea
  JOIN public.covid_vaccinations vac
    ON dea.location = vac.location
   AND dea.date = vac.date
  WHERE dea.continent IS NOT NULL
)
SELECT *,
       (rolling_people_vaccinated / population) * 100 AS percent_population_vaccinated
FROM PopvsVac;
```
**Explanation:**
This query uses a CTE to join COVID deaths and vaccination data by country and date, calculate a running total of vaccinations per country over time using a window function, and then compute the percentage of each country’s population that has been vaccinated.

## 19. Creating a View for Percentage of Population Vaccinated
```sql
CREATE VIEW percent_population_vaccinated as
SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(COALESCE(vac.new_vaccinations, 0)) OVER (
      PARTITION BY dea.location
      ORDER BY dea.date
    ) AS rolling_people_vaccinated
  FROM public.covid_deaths dea
  JOIN public.covid_vaccinations vac
    ON dea.location = vac.location
   AND dea.date = vac.date
  WHERE dea.continent IS NOT NULL

SELECT * FROM public.percent_population_vaccinated
```
**Explanation:**
This code creates a view that joins deaths and vaccination data by country and date, filters to country-level records, and calculates a running total of vaccinations per country over time using a window function.

## 20. Daily Highest COVID-19 Infection Percentage by Location
```sql
SELECT 
  date,
  Location, 
  Population, 
  MAX(total_cases) AS HighestInfectionCount, 
  MAX(COALESCE((total_cases / population), 0)*100) PercentPopulationInfected
FROM public.covid_deaths
GROUP BY Location, Population, date
ORDER BY PercentPopulationInfected DESC;
```
![4](/assets/4.png)

**Explanation:**
This query groups the data by location, population, and date, finds the highest total COVID-19 cases recorded on each date for each location, calculates the percentage of the population affected, and orders the results from highest to lowest infection percentage.
