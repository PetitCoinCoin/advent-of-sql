CREATE OR REPLACE FUNCTION f_count_mgmt(pk INTEGER)
  RETURNS INT
  LANGUAGE SQL IMMUTABLE PARALLEL SAFE AS
$func$
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
$func$;

SELECT
    f_count_mgmt(staff_id) AS mgmt_count
FROM staff
ORDER BY mgmt_count DESC
LIMIT 1;
