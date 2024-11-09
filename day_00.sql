SELECT
    city,
    country,
    AVG(naughty_nice_score) AS score,
    count(children.child_id) AS count_children
FROM children
RIGHT JOIN christmaslist ON children.child_id = christmaslist.child_id
GROUP BY city, country
HAVING count(children.child_id) > 4
ORDER BY score DESC
