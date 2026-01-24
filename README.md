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

