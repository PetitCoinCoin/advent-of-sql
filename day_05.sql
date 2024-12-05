SELECT
    production_date,
    100 * delta / previous_production AS percentage_delta
FROM (
    SELECT
        production_date,
        LEAD(toys_produced) OVER (ORDER BY production_date DESC) AS previous_production,
        toys_produced - LEAD(toys_produced) OVER (ORDER BY production_date DESC) AS delta
    FROM toy_production
)
ORDER BY percentage_delta DESC NULLS LAST
LIMIT 1;

-- LAG to get previous row !
