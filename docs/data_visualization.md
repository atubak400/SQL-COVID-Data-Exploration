# Data Visualization Documentation

This document explains the process used to generate visualizations for the SQL COVID Data Exploration project. It outlines the workflow from SQL query execution to final dashboard visuals in Tableau, ensuring transparency and reproducibility.

---

## 1. Overview

The visualizations in this project were created using **Tableau**, with data prepared through **SQL queries** executed in PostgreSQL. Instead of connecting Tableau directly to the database, query results were exported through Excel workbooks to maintain clarity, portability, and ease of documentation.

This approach ensures that each visualization is traceable to a specific SQL query and dataset snapshot.

---

## 2. Tools Used

- **PostgreSQL** – Executed SQL queries to extract analytical results.
- **pgAdmin 4** – Used as the graphical interface to run queries and view outputs.
- **Microsoft Excel** – Used as an intermediate data storage format for each query result.
- **Tableau** – Used to design and generate visualizations and dashboards.

---

## 3. Visualization Workflow

The workflow followed a structured and repeatable pipeline:

1. **Execute SQL Query**
   - Queries were written and executed in PostgreSQL using pgAdmin.
   - Outputs included both column headers and result rows.

2. **Copy Query Output**
   - The full output table, including headers, was copied directly from pgAdmin.

3. **Paste into Excel**
   - Each query result was pasted into **a new Excel workbook**.
   - Every visualization had its **own separate Excel file**, not multiple sheets within a single file.

4. **Save Excel Workbook**
   - Each workbook represented a single dataset tied to one SQL query.

5. **Import into Tableau**
   - Each Excel workbook was imported into Tableau as a **separate data source**.

6. **Create Tableau Sheet**
   - One Tableau sheet was created per Excel workbook.
   - Each sheet generated one visualization.

---

## 4. Visualization 1 – Global COVID-19 Summary Metrics (KPI Cards)
![Viz 1](/assets/Viz%201.png)
### Purpose
The purpose of this visualization is to provide a high-level overview of the global impact of COVID-19. It establishes context for the rest of the analysis by summarising **total cases**, **total deaths**, and the **overall global death percentage** using country-level data only.

This visualization acts as the entry point into the dataset before exploring country comparisons, timelines, and vaccination trends. Instead of a bar or pie chart, this visualization uses **KPI cards / summary tiles**, which are ideal for displaying single aggregated values clearly and immediately.

### SQL Query Used

```sql
SELECT
    SUM(new_cases) AS totalcases,
    SUM(new_deaths) AS totaldeaths,
    SUM(new_deaths) / SUM(new_cases) * 100 AS totaldeathpercentage
FROM public.covid_deaths
WHERE continent IS NOT NULL;
```

---

## 5. Visualization 2 – Total COVID-19 Deaths by Continent
![Viz 2](/assets/Viz%202.png)
### Purpose

The purpose of this visualization is to compare the total number of COVID-19 deaths across continents. It provides a regional perspective of the pandemic’s impact and helps identify which continents experienced the highest overall mortality. This visualization builds on the global summary by breaking the data down into major geographic regions for clearer comparative analysis.

A **bar chart** was used because it is effective for comparing numerical values across categories and makes differences between continents immediately visible.


### SQL Query Used

```sql
SELECT
    location,
    SUM(new_deaths) AS totalDeathCount
FROM public.covid_deaths
WHERE continent IS NULL
  AND location NOT IN ('World', 'European Union', 'International')
GROUP BY location
ORDER BY totalDeathCount DESC;
```

---

## 6. Visualization 3 – Countries with the Highest Infection Rate Relative to Population (Map Chart)
![Viz 3](/assets/Viz%203.png)
### Purpose

The purpose of this visualization is to identify which countries experienced the highest proportion of COVID-19 infections relative to their population size. Instead of looking at raw case counts, this view focuses on **infection rate as a percentage of total population**, allowing fair comparison between small and large countries.

This visualization highlights geographical patterns and reveals how severely different nations were impacted when adjusted for population size.

### SQL Query Used

```sql
SELECT
    location,
    population,
    MAX(total_cases) AS HighestInfectionCount,
    MAX(COALESCE((total_cases / population), 0) * 100) AS PercentPopulationInfected
FROM public.covid_deaths
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC;
```

---

## 7. Visualization 4 – Daily Highest COVID-19 Infection Percentage by Location (Line Chart)
![Viz 4](/assets/Viz%204.png)
### Purpose

The purpose of this visualization is to analyse how the percentage of each country’s population infected with COVID-19 changed over time.  
Unlike the previous visualizations that focused on totals or rankings, this chart introduces a **time-series perspective**, allowing trends, growth rates, and comparative infection progress between countries to be observed month by month.

This visualization helps identify which countries experienced faster infection growth and how infection percentages evolved across different periods of the pandemic.

A line chart was selected because it is the most effective way to display **changes over time**.  
It allows multiple countries to be compared simultaneously while preserving chronological order and trend direction.

### SQL Query Used

```sql
SELECT
  Location,
  Population,
  date,
  MAX(total_cases) AS HighestInfectionCount,
  MAX(COALESCE((total_cases / population), 0) * 100) AS PercentPopulationInfected
FROM public.covid_deaths
GROUP BY Location, Population, date
ORDER BY PercentPopulationInfected DESC;
```
