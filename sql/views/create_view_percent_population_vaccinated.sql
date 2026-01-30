CREATE VIEW percent_population_vaccinated as
SELECT
    dea.continent,
    dea.location,
    dea.date,
    dea.population,
    vac.new_vaccinations,
    SUM(vac.new_vaccinations) OVER (
      PARTITION BY dea.location
      ORDER BY dea.date
    ) AS rolling_people_vaccinated
  FROM public.covid_deaths dea
  JOIN public.covid_vaccinations vac
    ON dea.location = vac.location
   AND dea.date = vac.date
  WHERE dea.continent IS NOT NULL

