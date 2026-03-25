# Virginia Homelessness & Housing Options

Following the Supreme Court's 2024 decision in Grants Pass v. Johnson, many localities - including my own city - have considered criminalizing activities such as sleeping or camping in public.  

In the Grants Pass ruling, Justice Gorsuch writes that the ordinance in question forbids *actions*, and does not criminalize the status of homelessness.  However, a common sense reaction implies that unhoused families and individuals have less choice about whether or not to sleep in public.

In this project, I would like to investigate that common sense reaction using census data, point-in-time homelessness counts, and housing inventory counts for the state of Virginia to examine the impact that adopting similar ordinances may have in my home state.

This project is a work in progress and may yet be altered.

## Questions
#### Homelessness & Temporary Shelter
- How have unhoused populations and shelter availability changed over time?
- What percentage of shelter beds are typically available?
- Are there enough shelter beds for the entire unhoused population?

#### Permanent Housing
- How has the inventory of permanent housing changed in relationship to population growth?
- How has the cost of permanent housing changed in relationship to incomes? 

#### National Trends
- How has Virginia compared to the rest of the United States over this period?

## Data Sources
- U.S. Census Bureau [American Community Survey (ACS) 5-year estimates](https://www.census.gov/programs-surveys/acs/)
- Point-in-Time data files accessed from [HUD User](https://www.huduser.gov/portal/datasets/ahar.html)
- Housing Inventory Counts accessed from [HUD Exchange](https://www.hudexchange.info/programs/coc/coc-housing-inventory-count-reports/)

### Other sources
- City of Grants Pass v. Johnson, 603 U.S. ___ (2024)


# Process

## Data Acquisition
### HUD Data
The U.S. Department of Housing and Urban Development (HUD) collects data from Continuum of Care (CoC) networks in the United States to better understand homelessness and shelter availability.

The Point-in-Time (PIT) Count is a single-night count of individuals experiencing homelessness who are unsheltered or sheltered in emergency shelter, transistional housing, and Safe Haven.  Sheltered individuals are counted every year, while unsheltered individuals are only required to be counted every other year.

- A spreadsheet of PIT Counts from 2007 - 2024 was downloaded from HUD User, and relevant columns copied out into a more normalized table structure for use in PostgreSQL.

The Housing Inventory Count (HIC) is a point-in-time report of beds and units available to unhoused people and families within the CoC.

- I was only able to find HIC reports in PDF format; data was transcribed into a normalized table for use in PostgreSQL.
