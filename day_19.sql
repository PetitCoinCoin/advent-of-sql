WITH perf AS (
    SELECT
        employee_id,
        salary,
        year_end_performance_scores[CARDINALITY(year_end_performance_scores)]::integer AS last_performance
    FROM employees
)
SELECT SUM(paid) FROM (
    SELECT
        salary * (CASE WHEN last_performance > avg_perf.last_avg_performance THEN 1.15 ELSE 1 END) AS paid
    FROM perf
    CROSS JOIN (
        SELECT
            AVG(last_performance) AS last_avg_performance
        FROM perf
    ) avg_perf
);
