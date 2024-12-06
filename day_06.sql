SELECT
    children.name
FROM children
LEFT JOIN gifts ON gifts.child_id = children.child_id
WHERE price > (SELECT AVG(price) FROM gifts)
ORDER BY price
LIMIT 1;
