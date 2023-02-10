 --Temp Table

 DROP Table if exists #PercentPopulationVaccinated
 Create Table #PercentPopulationVaccinated
 (
 Continent nvarchar(255),
 Location nvarchar(255),
 Date datetime,
 Population numeric,
 New_vaccinations numeric,
 RollingPeopleVaccinated numeric
)

 Insert into #PercentPopulationVaccinated
  Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
  , SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, 
  dea.Date) as RollingPeopleVaccinated
  --, (RollingPeopleVaccinated/population)*100
From PortfolioProject .dbo.CovidDeaths dea
Join PortfolioProject .dbo.CovidVaccinations vac
 On dea.location = vac.location
 and dea.date = vac.date
 --Where dea.continent is not null
 --order by 2,3

  Select *, (RollingPeopleVaccinated/Population)*100
 From #PercentPopulationVaccinated

 --Creating view to store data for later visualization

 Create View PercentPopulationVaccinated as
 Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
  , SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, 
  dea.Date) as RollingPeopleVaccinated
  --, (RollingPeopleVaccinated/population)*100
From PortfolioProject .dbo.CovidDeaths dea
Join PortfolioProject .dbo.CovidVaccinations vac
 On dea.location = vac.location
 and dea.date = vac.date
 Where dea.continent is not null
 --order by 2,3

 Select *
 From PercentPopulationVaccinated