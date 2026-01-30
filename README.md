# SQL COVID Data Exploration

## 1. Overview

This project explores global COVID-19 data using **PostgreSQL** and **SQL**, focusing on understanding trends in cases, deaths, and vaccinations. The aim is to demonstrate a complete data analysis workflow, from raw data preparation and database import to querying and analysis, in a way that is suitable for portfolio review and interview discussion.

---

## 2. Dataset

The project uses two datasets originally provided in Excel format:

* **COVID Deaths** (cases, deaths, population metrics)
* **COVID Vaccinations** (testing, vaccination, and policy-related metrics)

These datasets were converted to CSV before being imported into PostgreSQL.

### Dataset Source

The data used in this project comes from **Our World in Data (OWID)**, a widely used and publicly available COVID-19 dataset compiled from official government and health authority sources worldwide. OWID provides regularly updated, well-documented datasets that are commonly used in academic research, journalism, and data analysis projects.

Source:

* Our World in Data – COVID-19 Dataset: [https://ourworldindata.org/covid-deaths](https://ourworldindata.org/covid-deaths)

---

## 3. Tools & Technologies Used

* **PostgreSQL** – Used as the relational database to store and query the COVID datasets reliably at scale.
* **pgAdmin 4** – Used as a graphical interface to manage the PostgreSQL database, inspect tables, and run SQL queries.
* **Terminal (psql)** – Used for reliable, client-side data imports using `\copy` when pgAdmin’s import process failed due to file path and permission limitations.
* **VS Code** – Used for project organisation, SQL scripts, and documentation.

---

## 4. Data Import Process

The data import process involved converting Excel files to CSV, creating database tables with appropriate data types, and importing the data into PostgreSQL. While pgAdmin was initially used, the final import was completed via the terminal to avoid server-side file access issues.

### High-level steps

1. Converted Excel (.xlsx) files to CSV (.csv) to ensure compatibility with PostgreSQL.
2. Created tables in PostgreSQL with schemas matching the CSV column structure.
3. Attempted import via pgAdmin (GUI-based import).
4. Switched to terminal-based import using `psql` and `\copy` due to pgAdmin import failures.
5. Verified successful imports using row counts and sample queries.

> 📄 **Note:** A full, detailed breakdown of the data import process (including reasons, commands used, and validation steps) can be found in [`docs/data_import.md`](docs/data_import.md)

---

## 5. Database Structure

* **Database:** `covid_sql_dataset`
* **Tables:**

  * `covid_deaths`
  * `covid_vaccinations`

Both tables use a shared structure for key identifiers such as `iso_code`, `location`, and `date`, enabling joins and comparative analysis.

---


## 6. SQL Exploration & Analysis

After the data was successfully imported, a series of SQL queries were used to explore, validate, and analyse the datasets. These queries progress from basic validation checks to more advanced analytical techniques, including joins, window functions, common table expressions (CTEs), and views.

The analysis covers:
* Validation of imported data
* Country-level and global case and death trends
* Infection and death rates relative to population
* Daily global case and death patterns
* Vaccination progress over time using rolling totals
* Percentage of population vaccinated per country

> 📄 **Note:** All SQL queries and explanations are documented step-by-step in [`docs/query_documentation.md`](docs/query_documentation.md)

---

## 7. Data Visualization

Visualizations for this project were created using **Tableau** after preparing aggregated datasets through SQL queries.  
Instead of connecting Tableau directly to PostgreSQL, query outputs were exported into individual Excel workbooks and then imported into Tableau as separate data sources. This approach ensured clarity, reproducibility, and a clear link between each visualization and its underlying SQL query.

The visualizations include:

- Global summary metrics (Total Cases, Total Deaths, Death Percentage)
- Total death counts by continent
- Countries with the highest infection rate relative to population
- Daily infection percentage trends by location

> 📊 **Note:** A full breakdown of the visualization workflow, SQL queries used, and chart descriptions can be found in [`docs/data_visualization.md`](docs/data_visualization.md)

---

## 8. Key Insights

Key insights were derived from the SQL analysis and Tableau visualizations to highlight global patterns, regional disparities, and proportional impacts of COVID-19 across countries and time.

These insights focus on:

- Differences between absolute totals and population-adjusted metrics  
- Continental comparisons of mortality impact  
- Countries with the highest infection ratios relative to population size  
- Temporal infection growth trends across selected locations  

> 💡 **Note:** The complete list of insights and analytical observations is documented in [`docs/key_insights.md`](docs/key_insights.md)

---

## 9. Full Dashboard
![Dashboard](/assets/dashboard.png)
A consolidated dashboard was created in **Tableau** to combine all individual visualizations into a single interactive view.  
This dashboard allows users to quickly understand global COVID-19 trends, compare regions, and observe infection patterns over time without switching between multiple sheets.

The dashboard integrates:

- Global summary metrics  
- Continental death comparisons  
- Infection rate distribution by country  
- Time-series infection trends by selected locations  

The purpose of the dashboard is to present the analytical findings in a clear, visual, and decision-friendly format suitable for portfolio demonstration and stakeholder communication.

---

## 10. Conclusion

This project demonstrates a complete end-to-end **SQL data analysis workflow**, starting from raw dataset preparation to structured database import, exploratory querying, visualization, and insight generation.

Key achievements include:

- Successful conversion and import of large datasets into PostgreSQL  
- Development of structured SQL queries for validation and analysis  
- Creation of multiple Tableau visualizations to communicate findings  
- Identification of meaningful trends and proportional comparisons across countries and continents  

Overall, the project highlights practical skills in **data cleaning, SQL analysis, documentation, and data visualization**, making it suitable for portfolio presentation and technical interview discussions. It also establishes a strong foundation for extending the analysis with additional datasets or advanced analytical techniques in the future.

---
