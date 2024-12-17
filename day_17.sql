SELECT
    (business_start_time AT TIME ZONE 'UTC') + ((business_start_time AT TIME ZONE 'UTC')::time - (business_start_time AT TIME ZONE timezone)::time)::interval AS start_utc
FROM workshops
ORDER BY start_utc DESC
LIMIT 1;
