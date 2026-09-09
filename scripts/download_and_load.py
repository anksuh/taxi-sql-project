import urllib.request
import pandas as pd
from sqlalchemy import create_engine

MONTHS = ["2024-01"]
BASE_URL = "https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_{}.parquet"

engine = create_engine("postgresql+psycopg2://taxi_user:taxi_pass@localhost:5432/taxi_db")

for month in MONTHS:
    fname = f"data/yellow_tripdata_{month}.parquet"
    url = BASE_URL.format(month)

    print(f"Loading {fname} into raw_trips...")
    df = pd.read_parquet(fname)
    df.columns = df.columns.str.lower()  # match Postgres's lowercase column names
    df.to_sql("raw_trips", engine, if_exists="append", index=False, chunksize=50000)
    print(f"Loaded {len(df):,} rows from {month}")

print("Done.")
