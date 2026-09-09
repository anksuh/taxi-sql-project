DROP TABLE IF EXISTS raw_trips;

CREATE TABLE raw_trips (
    vendorid                INT,
    tpep_pickup_datetime     TIMESTAMP,
    tpep_dropoff_datetime    TIMESTAMP,
    passenger_count          NUMERIC,
    trip_distance            NUMERIC,
    ratecodeid               NUMERIC,
    store_and_fwd_flag       TEXT,
    pulocationid             INT,
    dolocationid             INT,
    payment_type             INT,
    fare_amount              NUMERIC,
    extra                    NUMERIC,
    mta_tax                  NUMERIC,
    tip_amount               NUMERIC,
    tolls_amount             NUMERIC,
    improvement_surcharge    NUMERIC,
    total_amount             NUMERIC,
    congestion_surcharge     NUMERIC,
    airport_fee              NUMERIC
);
