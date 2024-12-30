SELECT DISTINCT ON(inv_rank)
    c.gift_id,
    g.gift_name,
    PERCENT_RANK() OVER(ORDER BY c.gift_count) AS inv_rank
FROM (
    SELECT
        gift_id,
        COUNT(request_id) AS gift_count
    FROM gift_requests
    GROUP BY gift_id
) c
JOIN gifts g ON g.gift_id = c.gift_id 
ORDER BY inv_rank DESC, gift_name
LIMIT 2;
