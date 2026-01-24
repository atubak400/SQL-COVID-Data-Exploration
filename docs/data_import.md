# Data Import Documentation

## Overview

This section documents the **complete data import process** used in this project, from converting the original Excel files to CSV, through database setup, to successfully importing and validating the data in PostgreSQL. This documentation is written to clearly explain *what was done*, *why it was done*, and *how it was verified*, in a way that is suitable for a portfolio or interview discussion.

---

## Step 1: Converting Excel Files to CSV

### What was done

The original COVID datasets were provided in **Excel (.xlsx)** format. These files were converted into **CSV (.csv)** format before importing them into the database.

### Why this was necessary

PostgreSQL does not natively import Excel files. While pgAdmin provides graphical import tools, PostgreSQL works most reliably with **CSV files**, which are plain-text, lightweight, and universally supported by database systems. Using CSV also avoids hidden Excel formatting issues that can cause import failures.

### Result

Two CSV files were created:

* `CovidDeaths.csv`
* `CovidVaccinations.csv`

These files were placed in the project directory under:

```
data/raw/
```

---

## Step 2: Tools Used and Why

### PostgreSQL

PostgreSQL was used as the **relational database engine** for this project.

**Why PostgreSQL was chosen:**

* Industry-standard SQL database
* Strong support for analytical queries
* Excellent handling of large datasets
* Widely used in data analyst and data engineering roles

### pgAdmin

pgAdmin was used as the **graphical database management tool**.

**Why pgAdmin was used:**

* Visual database exploration (tables, schemas, data preview)
* Query editor for running and testing SQL
* Useful for validating imports and inspecting results

pgAdmin was especially useful for confirming that tables were created correctly and that data was imported as expected.

---

## Step 3: Why Terminal Was Used Instead of pgAdmin Import

### Initial attempt

The initial approach was to import the CSV files using **pgAdmin’s Import/Export Data** feature.

### Problem encountered

The pgAdmin import failed due to:

* Date format mismatch (`DD/MM/YYYY` vs PostgreSQL default)
* File access and permission issues on macOS
* Less control over how PostgreSQL interpreted the CSV data

### Decision

To gain **full control and reliability**, the import was moved to the **Terminal using psql**.

### Why Terminal (`psql`) was the correct solution

* Allows client-side imports using `\copy`
* Avoids macOS file permission issues
* Makes the import process explicit and reproducible
* Commonly used in real-world data and engineering workflows

---

## Step 4: Connecting to PostgreSQL via Terminal

The Terminal was used to connect directly to the database:

```sql
psql -U postgres -d covid_sql_dataset
```

This opened an interactive PostgreSQL session where all import commands were executed.

---

## Step 5: Creating Tables to Match the CSV Structure

Before importing, tables were created manually to **exactly match the column order and data types** of the CSV files. This ensures that each column maps correctly during import.

Example (Covid deaths table):

```sql
CREATE TABLE public.covid_deaths (
  iso_code TEXT,
  continent TEXT,
  location TEXT,
  date DATE,
  population NUMERIC,
  total_cases NUMERIC,
  new_cases NUMERIC,
  new_cases_smoothed NUMERIC,
  total_deaths NUMERIC,
  new_deaths NUMERIC,
  new_deaths_smoothed NUMERIC,
  total_cases_per_million NUMERIC,
  new_cases_per_million NUMERIC,
  new_cases_smoothed_per_million NUMERIC,
  total_deaths_per_million NUMERIC,
  new_deaths_per_million NUMERIC,
  new_deaths_smoothed_per_million NUMERIC,
  reproduction_rate NUMERIC,
  icu_patients NUMERIC,
  icu_patients_per_million NUMERIC,
  hosp_patients NUMERIC,
  hosp_patients_per_million NUMERIC,
  weekly_icu_admissions NUMERIC,
  weekly_icu_admissions_per_million NUMERIC,
  weekly_hosp_admissions NUMERIC,
  weekly_hosp_admissions_per_million NUMERIC
);
```

---

## Step 6: Handling Date Format Issues

The CSV files used the date format:

```
DD/MM/YYYY
```

PostgreSQL defaults to a different date format, so the session date style was explicitly set:

```sql
SET datestyle = 'DMY';
```

This ensured that dates such as `24/02/2020` were interpreted correctly.

---

## Step 7: Importing the Data Using \copy

The data was imported using PostgreSQL’s **client-side copy command**:

```sql
\copy public.covid_deaths FROM '/Users/kingsleyatuba/Desktop/Data Analyst/Projects/Sql-Covid-Data-Exploration/data/raw/CovidDeaths.csv' CSV HEADER
```

**Why `\copy` was used instead of `COPY`:**

* `COPY` runs on the database server and cannot access user directories on macOS
* `\copy` runs on the client (Terminal) and can read local files

The same approach was used for the vaccinations dataset.

---

## Step 8: Verifying the Import

After each import, validation queries were run to confirm success.

### Row count check

```sql
SELECT COUNT(*) FROM public.covid_deaths;
```

### Data preview

```sql
SELECT * FROM public.covid_deaths LIMIT 5;
```

### Successful result

The import returned:

```
COPY 85171
```

This confirmed that all rows were imported correctly.

---

## Final Outcome

At the end of this process:

* Both datasets were successfully imported
* Dates were correctly parsed
* Tables were structured for efficient analysis
* The database was fully ready for SQL exploration and joins

This completes the **data ingestion and preparation phase** of the project.
