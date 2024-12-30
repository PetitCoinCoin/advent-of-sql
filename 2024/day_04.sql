CREATE OR REPLACE FUNCTION f_sub(a1 anyarray, a2 anyarray)
  RETURNS anyarray
  LANGUAGE SQL IMMUTABLE PARALLEL SAFE AS
$func$
SELECT ARRAY (SELECT unnest(a1) EXCEPT ALL SELECT unnest(a2));
$func$;

CREATE OR REPLACE FUNCTION f_common(a1 anyarray, a2 anyarray)
  RETURNS anyarray
  LANGUAGE SQL IMMUTABLE PARALLEL SAFE AS
$func$
SELECT ARRAY (SELECT unnest(a1) INTERSECT SELECT unnest(a2));
$func$;

SELECT 
    toy_id,
    array_length(f_sub(new_tags, previous_tags), 1) AS added_tags,
    array_length(f_common(new_tags, previous_tags), 1) AS unchanged_tags,
    array_length(f_sub(previous_tags, new_tags), 1) AS removed_tags
FROM toy_production
ORDER BY added_tags DESC NULLS LAST
LIMIT 1;

-- This works as well
SELECT *
FROM (
    SELECT
        toy_p.toy_id,
        array_length(added.added_tags, 1) AS added_tags,
        array_length(unchanged.unchanged_tags, 1) AS unchanged_tags,
        array_length(removed.removed_tags, 1) AS removed_tags
    FROM toy_production toy_p
    CROSS JOIN LATERAL (
    SELECT ARRAY (
        SELECT unnest(toy_p."new_tags")
        EXCEPT ALL
        SELECT unnest(toy_p."previous_tags")
        )
    ) added(added_tags)
    CROSS JOIN LATERAL (
    SELECT ARRAY (
        SELECT unnest(toy_p."previous_tags")
        EXCEPT ALL
        SELECT unnest(toy_p."new_tags")
        )
    ) removed(removed_tags)
    CROSS JOIN LATERAL (
    SELECT ARRAY (
        SELECT unnest(toy_p."new_tags")
        INTERSECT
        SELECT unnest(toy_p."previous_tags")
        )
    ) unchanged(unchanged_tags)
)
ORDER BY added_tags DESC NULLS LAST
LIMIT 1;