## Project Summary

This project utilizes Python scripts in the ingest folder to extract data from S3 files and load it into a DuckDB database. Additionally, a Python script integrates with the Meteo Weather API to fetch daily rainfall and wind data. Using DBT Core, the ingested data is transformed into a structured fact table and metric tables within the DuckDB database for efficient analysis and reporting.

## Project Setup Instructions

This guide explains how to set up and run the project on a new machine. The project ingests data from S3 and the Meteo Weather API into DuckDB using Python scripts, then transforms the data into fact and metric tables using DBT Core.

### Prerequisites
- **Python 3.8+**: Ensure Python is installed (`python --version`).
- **Git**: For cloning the repository (`git --version`).
- **DuckDB CLI**: For interacting with duckdb using powershell commands
- **VS Code**: Recommended for editing files (optional).
- **DBT Core**: Installed via `pip` (included in `requirements.txt`).

### Setup Steps

1. Create a folder in Documents (give it any name, I called mine root)
2. Clone Repository from <URL> into folder in documents
3. Open Folder in VS code and create folder called db  another called .env file
4. Replace the db database path in 
    ingest/duckdb_utils (line 11) 
    con = duckdb.connect('C:/Users/TawandaCharuka/Documents/RootProject/db/root_dwh.duckdb') and 
    ingest/weather_api (line 51)
    con = duckdb.connect('C:/Users/TawandaCharuka/Documents/RootProject/db/root_dwh.duckdb')
    replace C:/Users/TawandaCharuka/Documents/RootProject/db/ with your db folder path inside project folder and  leave the root_dwh name as is.
5. Add aws keys provided into .env file

6. In root project Create your venv using commands below
    i. python -m venv <venv name>
    ii. activate venv with command  <venv name>\Scripts\activate (if running scripts is disabled on your system use this command Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process)
    iii. pip install -r requirements.txt

Ingest Data into DuckDB tables from S3 and Weather API
	Run the python scripts in Active VENV
7. - python ingest/duckdb_utils.py
   - python ingest/weather_api.py

Run the DBT transformation pipeline to create Fact and Metric tables using the commands below:
9.  In the Active venv navigate to folder
  - cd transform/stage_premiums
  - in the stage_premiums folder open the config folder then open the profiles yml file
  - Edit the profiles yml file  path: C:/Users/TawandaCharuka/Documents/RootProject/db/root_dwh.duckdb with your db path
  - then execute the command -  dbt run --profiles-dir ./config

Commands to check our duckdb database to see if our tables are in 
    - In our active venv 
10. duckdb C:/Users/TawandaCharuka/Documents/RootProject/db/root_dwh.duckdb replace with database your path
    - once the duckdb cli opens run .tables (to view our tables in schema)
    - run select * from TRIPS; to select and see data in the tables.

## Require assistance to setup project
    - Contact Tawanda @ 084 463 5021/ tawandalloydcharuka@gmail.com 
