CREATE OR REPLACE FUNCTION f_other_avg(fn VARCHAR, hy INTEGER, s VARCHAR)
  RETURNS NUMERIC
  LANGUAGE SQL IMMUTABLE PARALLEL SAFE AS
$func$
SELECT
    ROUND(AVG(trees_harvested)::numeric, 2)
  FROM
    treeharvests
  WHERE
    field_name = fn and harvest_year = hy and season != s
$func$;

SELECT
    f_other_avg(field_name, harvest_year, season) AS other_avg
FROM treeharvests
ORDER BY other_avg DESC
LIMIT 1;


-- This is what I implemented first, thinking we would have several years
-- and that the average was on the last 3 seasons (not some weird loop over the year)

-- SELECT
--     field_name,
--     harvest_year,
--     season,
--     ROUND(((LAG(trees_harvested, 1) OVER (
--         PARTITION BY field_name
--         ORDER BY field_name, harvest_year DESC, int_season DESC
--     ) +
--     LAG(trees_harvested, 2) OVER (
--         PARTITION BY field_name
--         ORDER BY field_name, harvest_year DESC, int_season DESC
--     ) +
--     LAG(trees_harvested, 3) OVER (
--         PARTITION BY field_name
--         ORDER BY field_name, harvest_year DESC, int_season DESC
--     )) / 3)::numeric, 2) AS other_avg
-- FROM (
--     SELECT
--         field_name,
--         harvest_year,
--         trees_harvested,
--         season,
--         CASE season
--             WHEN 'Spring' THEN 1
--             WHEN 'Summer' THEN 2
--             WHEN 'Fall' THEN 3
--             ELSE 4
--         END AS int_season
--     FROM treeharvests
-- )
-- ORDER BY other_avg DESC NULLS LAST
-- LIMIT 1;
