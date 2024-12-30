SELECT drop_off
FROM (
    SELECT
        receipt ->> 'drop_off' AS drop_off,
        receipt ->> 'garment' AS garment,
        receipt ->> 'color' AS color
    FROM (
        SELECT
            record_date,
            jsonb_array_elements(cleaning_receipts) AS receipt
        FROM santarecords
    )
)
WHERE garment = 'suit' AND color = 'green'
ORDER BY drop_off DESC
LIMIT 1;
