SELECT
    year,
    quarter,
    (total_amount /  LAG(total_amount) OVER (ORDER BY year, quarter)) - 1 AS growth
FROM (
    SELECT
        DATE_PART('year', sale_date) AS year,
        DATE_PART('quarter', sale_date) AS quarter,
        SUM(amount) AS total_amount
    FROM sales
    GROUP BY year, quarter
)
ORDER BY growth DESC NULLS LAST
LIMIT 1;
