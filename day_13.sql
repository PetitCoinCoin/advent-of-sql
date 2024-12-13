SELECT
    web_domain,
    COUNT(web_domain) AS nb
FROM (
    SELECT
        SPLIT_PART(UNNEST(email_addresses), '@', 2) as web_domain
    FROM contact_list
)
GROUP BY web_domain
ORDER BY nb DESC
LIMIT 1;
