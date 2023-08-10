# COVID-19 Exploratory Data Analysis using SQL

## Overview
This repository contains SQL queries and scripts for performing exploratory data analysis (EDA) on COVID-19 data.
The analysis covers various aspects of the pandemic, such as cases, deaths, vaccinations, and population demographics.

## Data Sources
The analysis is based on two main datasets:

### CovidDeaths: 
This table contains information about COVID-19 cases and deaths by location, date, and continent. It includes data on the total cases, total deaths, and population.

### CovidVaccination: 
This table provides data on COVID-19 vaccinations by location, date, and the number of new vaccinations administered.

## Contents
The repository contains the following files:

Covid19_data_Exploration.sql: This file includes SQL queries to perform exploratory analysis on the provided COVID-19 datasets. The queries cover a range of questions, such as:
Calculating daily new cases and deaths.
Calculating the death rate.
Analyzing vaccination trends.
Investigating geographical variations.

## Usage
1. Setup Database: Ensure you have a SQL database set up and running. You can use platforms like MySQL, PostgreSQL, or Microsoft SQL Server.
2. Import Data: Import the provided COVID-19 datasets (CovidDeaths and CovidVaccination) into your database.
3. Run Queries: Open the queries.sql file and execute the queries in your SQL environment. These queries will generate insights and visualizations related to COVID-19 data.
4. Interpret Results: Review the results of the queries to gain insights into the trends and patterns within the COVID-19 data. Feel free to modify the queries to suit your specific analysis needs.

## Notes
The analysis in this repository is for educational and exploratory purposes. It's important to cross-reference findings with official sources and consult domain experts for accurate interpretations.
The SQL queries provided are a starting point. Depending on your analysis goals, you may need to adapt and expand the queries.

## Acknowledgments
The COVID-19 data used in this analysis is sourced from https://ourworldindata.org/covid-deaths

This project was inspired by the need to better understand the impact of the COVID-19 pandemic using SQL-based exploratory analysis.
