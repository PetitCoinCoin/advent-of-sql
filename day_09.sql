SELECT
    reindeer_name,
    max_speed
FROM (
    SELECT
        reindeer_id,
        MAX(speed) AS max_speed
    FROM (
        SELECT
            reindeer_id,
            ROUND(AVG(speed_record)::numeric, 2 ) AS speed
        FROM training_sessions
        GROUP BY reindeer_id, exercise_name
    )
    GROUP BY reindeer_id
) tbl_speed
JOIN reindeers ON tbl_speed.reindeer_id = reindeers.reindeer_id
WHERE reindeer_name != 'Rudolph'
ORDER BY max_speed DESC
LIMIT 3;
