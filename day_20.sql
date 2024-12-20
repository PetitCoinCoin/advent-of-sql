SELECT
    url,
    CARDINALITY(array_agg(DISTINCT param)) AS unique_param
FROM (
    SELECT
        url,
        split_part(query_param, '=', 1) as param
    FROM (
        SELECT
            url,
            UNNEST(string_to_array(split_part(url, '?', 2), '&')) AS query_param
        FROM web_requests
        WHERE POSITION('utm_source=advent-of-sql' in url) > 0
    )
)
GROUP BY url
ORDER BY unique_param DESC, url
limit 1;
