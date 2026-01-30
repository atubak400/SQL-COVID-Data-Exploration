# Key Insights – SQL COVID Data Exploration

This document summarises the key analytical insights derived from the four Tableau visualizations created from the SQL COVID-19 datasets. Each insight is based on aggregated query outputs and visual trend comparisons.

---

## Visualization 1 – Global COVID-19 Summary Metrics (KPI Cards)

**Key Insights**

1. The overall global death percentage is relatively low compared to total cases, indicating that while infections were widespread, the fatality rate was a small fraction of total cases.
2. Total global case numbers are significantly larger than total deaths, reinforcing the difference between infection spread and mortality impact.
3. Aggregating data at the global level provides context before drilling down into regional or country-level comparisons.
4. Using `continent IS NOT NULL` ensures that only country-level data contributes to the global totals, avoiding duplication from regional summaries.
5. This visualization establishes a baseline for interpreting all subsequent charts.

---

## Visualization 2 – Total Death Count by Continent (Bar Chart)

**Key Insights**

1. Europe recorded the highest total death count among all continents in the dataset.
2. North America follows closely behind Europe, indicating similar overall mortality impact.
3. Africa and Oceania show significantly lower total deaths, highlighting either lower spread, reporting differences, or demographic and healthcare variations.
4. The difference between continents is substantial, showing that the pandemic impact was not evenly distributed worldwide.
5. Visual comparison of bars makes continental disparities immediately noticeable.
6. Excluding “World,” “European Union,” and “International” prevents double-counting aggregated regions.

---

## Visualization 3 – Countries with the Highest Infection Rate Relative to Population (Map Chart)

**Key Insights**

1. Smaller countries tend to appear at the top of infection-percentage rankings because even moderate case numbers represent a large share of their population.
2. Large countries may have very high absolute case counts but lower infection percentages due to population size.
3. Geographic visualization reveals clusters of high infection percentages in certain regions rather than a uniform global pattern.
4. Percent-based metrics provide a fairer comparison than raw totals when populations differ greatly.
5. The map highlights relative severity instead of absolute scale, shifting focus from volume to proportional impact.
6. Population size is a critical factor in interpreting infection statistics correctly.

---

## Visualization 4 – Daily Highest Infection Percentage by Location (Line Chart)

**Key Insights**

1. Infection growth trends differ widely across countries, showing that pandemic progression was not uniform.
2. Smaller nations experience sharper percentage spikes because each new case significantly affects total population ratios.
3. Larger countries display smoother curves, even with large case volumes, due to population dilution.
4. Distinct acceleration periods suggest pandemic waves or surges rather than steady growth.
5. Early months show near-zero infection percentages globally, marking the initial spread phase.
6. Divergence between countries increases over time, reflecting varying policy responses and public health conditions.
7. Plateaus in certain lines may indicate stabilization, intervention success, or slower reporting growth.
8. Temporal visualization helps identify when infection intensity increased rather than only how much.
9. Relative infection impact becomes clearer when tracked over time instead of using static totals.
10. This chart emphasizes **rate of spread over time**, complementing earlier visuals focused on totals and rankings.

---

## Overall Analytical Takeaway

Across all visualizations, the analysis demonstrates that:

- Absolute case and death numbers do not fully represent pandemic impact.
- Population-adjusted metrics provide more balanced comparisons.
- Geographic and temporal perspectives reveal patterns hidden in raw totals.
- Combining SQL aggregation with visual analytics enables deeper insight into both scale and proportional severity of global health events.
