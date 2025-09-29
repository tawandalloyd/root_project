from dotenv import load_dotenv
import os
import duckdb

load_dotenv()  # Loads variables from .env

aws_access_key = os.getenv('AWS_ACCESS_KEY_ID')
aws_secret_key = os.getenv('AWS_SECRET_ACCESS_KEY')
aws_region = os.getenv('AWS_REGION')

con = duckdb.connect('C:/Users/TawandaCharuka/Documents/RootProject/db/root_dwh.duckdb')
con.execute(f"SET s3_region='{aws_region}'")
con.execute(f"SET s3_access_key_id='{aws_access_key}'")
con.execute(f"SET s3_secret_access_key='{aws_secret_key}'")

# Create table and load data from S3 CSV
con.execute("""
    CREATE or REPLACE TABLE TRIPS AS
    SELECT * FROM read_csv_auto('s3://citibike-ingest/202508-citibike-tripdata_*.csv')
""")

result = con.execute("SELECT * FROM TRIPS LIMIT 10").fetchdf()
print(result)

con.close()