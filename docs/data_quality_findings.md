# Data Quality Findings (raw_trips, Jan 2024)

Investigated anomalies in the raw NYC TLC yellow taxi data before designing
the cleaned schema. Each issue was inspected individually rather than
dropped by default.

## Issues found

| Issue | Count | % of rows | Finding | Decision |
|---|---|---|---|---|
| Dropoff before pickup | 56 | <0.01% | Physically impossible timestamps | Drop |
| Negative fare_amount | 37,448 | 1.26% | 94% concentrated in payment_type 2/3/4 (cash/no-charge/dispute) — consistent with legitimate reversed transactions, not corruption. Remaining 2,066 rows have payment_type=0, an undocumented code — treated as bad data. | Keep if payment_type in (1,2,3,4); drop if payment_type=0 |
| passenger_count = 0 | 31,465 | 1.06% | Trip distance/fare look like normal, valid trips — likely a metadata gap from the vendor, not a bad trip | Keep trip, treat passenger_count as unreliable |
| trip_distance > 100 miles | 59 | <0.01% | Clear GPS/entry outliers | Drop |

## Method
For each anomaly, sample rows were inspected directly rather than assuming
"weird = wrong." Negative fares in particular initially looked like pure
data corruption, but breaking them down by payment_type revealed most were
concentrated in non-standard payment types (dispute/no-charge/cash),
suggesting real reversed transactions rather than bad data entry.
