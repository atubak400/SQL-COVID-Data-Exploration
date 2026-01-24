#!/bin/bash
set -e

# Project name
PROJECT_NAME="sql-covid-data-exploration"

# Create main project folder
mkdir -p "$PROJECT_NAME"

# Move into project folder
cd "$PROJECT_NAME" || exit 1

# Create subfolders (SQL data exploration project structure)
mkdir -p data/raw
mkdir -p data/excel_split
mkdir -p data/processed
mkdir -p data/exports

mkdir -p sql/queries
mkdir -p sql/views
mkdir -p sql/results
mkdir -p sql/import_notes

mkdir -p notes
mkdir -p assets/screenshots
mkdir -p assets/sql_output_samples
mkdir -p tableau/exports
mkdir -p tableau/screenshots
mkdir -p docs

# Create placeholder files
touch README.md
touch notes/project_plan.md
touch notes/dataset_source.md
touch notes/import_issues_fixes.md

touch docs/query_documentation.md
touch docs/key_findings.md
touch docs/tableau_plan.md

touch data/raw/covid_dataset_raw.xlsx
touch data/excel_split/covid_deaths.xlsx
touch data/excel_split/covid_vaccinations.xlsx

touch sql/queries/01_select_core_columns.sql
touch sql/queries/02_death_percentage.sql
touch sql/queries/03_percent_population_infected.sql
touch sql/queries/04_highest_infection_rate.sql
touch sql/queries/05_highest_death_count.sql
touch sql/queries/06_global_numbers.sql
touch sql/queries/07_join_rolling_vaccinations.sql

touch sql/views/README_views.md
touch sql/results/query_results_notes.txt

touch tableau/exports/tableau_data_extracts_go_here.txt

# Add basic README content
cat <<'EOL' > README.md
# SQL COVID Data Exploration (Portfolio Project 1)

## Overview
This project recreates a full SQL data exploration workflow using a COVID dataset:
- Download dataset and split into two files (Deaths and Vaccinations)
- Import both tables into SQL Server
- Run exploratory SQL queries (rates, rankings, global totals)
- Join deaths + vaccinations and build rolling vaccination metrics
- Create views for later Tableau visualisations

## Tools Used
- Microsoft Excel (light formatting and splitting)
- SQL Server (import + SQL queries)
- Tableau (visualisations in the next project)

## Folder Structure
- data/raw: Original downloaded dataset
- data/excel_split: Split files (covid_deaths.xlsx, covid_vaccinations.xlsx)
- data/processed: Cleaned/standardised versions if needed
- data/exports: Extracts exported from SQL for Tableau or sharing
- sql/queries: All SQL queries used in exploration
- sql/views: Saved views for Tableau connection or exports
- sql/results: Notes or saved outputs from query runs
- notes: Planning notes, dataset link, import issues and fixes
- docs: Query explanations, key findings, Tableau plan
- assets: Screenshots and sample SQL output images
- tableau: Extracts and exports for Tableau work

## Status
Project folders created. Ready to download dataset and begin Excel split + SQL import.
EOL

echo "✅ SQL COVID Data Exploration project structure created successfully."
