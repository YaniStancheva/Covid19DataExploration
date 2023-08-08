Select * 
From PortfolioProject..covidDeaths
WHERE continent is not null
order by 3,4

-- Percentage of death rate
SELECT 
    Location, 
    date, 
    total_cases, 
    total_deaths, 
   ROUND( CAST(total_deaths AS FLOAT) / total_cases *100,2 )AS death_percentage_rate
FROM PortfolioProject..covidDeaths

--Filter by location
WHERE Location like '%bulgaria%' AND continent is not null
ORDER BY 1, 2;



-- Percentage of death rate by population

SELECT 
    Location, 
    date, 
    total_cases, 
    Population ,
   ROUND( CAST(total_cases AS FLOAT) / population *100,2 )AS death_percentage_population
FROM PortfolioProject..covidDeaths

--Filter by location
WHERE Location like '%United Kingdom%' AND continent is not null
ORDER BY 1, 2;







-- Countries with Highest Infection Rate compared to population
SELECT 
    Location, 
	Population,

	ROUND( CAST(MAX(total_cases) AS FLOAT),2 ) AS Highest_Number_Cases_By_Country, ROUND( CAST(MAX(total_cases) AS FLOAT)/ population * 100 ,2 ) AS percentage_population_infection
FROM PortfolioProject..covidDeaths

WHERE continent is not null
GROUP BY Location, Population
ORDER BY percentage_population_infection desc;



-- Countries with Higher death cases per Population

SELECT Location, MAX(total_deaths)  AS Total_Death_Count
FROM PortfolioProject..covidDeaths
WHERE continent is not null
GROUP BY Location

ORDER BY Total_Death_Count desc;


-- Highest death count by continent

SELECT continent, MAX(total_deaths)  AS Total_Death_by_continent
FROM PortfolioProject..covidDeaths
WHERE continent is not null
GROUP BY continent

ORDER BY Total_Death_by_continent desc;

-- Population vs Vaccination

Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(BIGINT,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated

From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
order by 2,3

-- Countries with highest vaccination rate
Select location, MAX(people_fully_vaccinated) as fully_vaccinated
From PortfolioProject..CovidVaccination
WHERE continent is not null
GROUP BY location
ORDER BY fully_vaccinated desc;



-- Total deaths globally


Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as Percentage_death
From PortfolioProject..CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2




-- Using CTE to perform Calculation on Partition By in previous query

With PopvsVac (Continent, Location, Date, Population, New_Vaccinations, RollingPeopleVaccinated)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(BIGINT,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 

)
Select *, (RollingPeopleVaccinated/Population)*100
From PopvsVac



-- Using Temp Table to perform Calculation on Partition By in previous query

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
, SUM(CONVERT(BIGINT,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinated


-- Creating View to store data for visualization

Create View PercentPopulationVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as RollingPeopleVaccinated
--, (RollingPeopleVaccinated/population)*100
From PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccination vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 