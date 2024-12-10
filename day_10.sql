SELECT
    date
FROM (
    SELECT
        date,
        SUM(quantity) FILTER (WHERE drink_name = 'Eggnog') AS eggnog,
        SUM(quantity) FILTER (WHERE drink_name = 'Hot Cocoa') AS hot_cocoa,
        SUM(quantity) FILTER (WHERE drink_name = 'Peppermint Schnapps') AS schnapps
    FROM drinks
    GROUP BY date
)
WHERE hot_cocoa = '38' AND schnapps = '298' AND eggnog = '198';
