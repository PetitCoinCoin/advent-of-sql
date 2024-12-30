CREATE OR REPLACE FUNCTION f_count_mgmt(pk INTEGER)
  RETURNS INT
  LANGUAGE SQL IMMUTABLE PARALLEL SAFE AS
$$
WITH RECURSIVE cte AS (
  SELECT
    staff_id,
    manager_id,
    staff_name
  FROM
    staff
  WHERE
    staff_id = pk
  UNION
  SELECT
    staff.staff_id,
    staff.manager_id,
    staff.staff_name
  FROM
    staff
    INNER JOIN cte ON staff.staff_id = cte.manager_id
)
SELECT COUNT(*) FROM cte;
$$;

SELECT
    MIN(staff_id),
    level,
    COUNT(1) AS peers
FROM (
    SELECT
        staff_id,
        f_count_mgmt(staff_id) AS level
    FROM staff
)
GROUP BY level
ORDER BY peers DESC, level
LIMIT 1;
