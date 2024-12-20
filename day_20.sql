SELECT
    url,
    CARDINALITY(string_to_array(split_part(url, '?', 2), '&')) AS query_params
FROM web_requests
WHERE split_part(substring(url from 'utm_source=[\w-]+'), '=', 2) = 'advent-of-sql'
ORDER BY query_params DESC, url
LIMIT 1;
