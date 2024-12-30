SELECT
    string_agg(symbol, '')
FROM (
    SELECT
        CHR(value) AS symbol
    FROM letters_a
    WHERE CHR(value) SIMILAR TO '[a-zA-Z,.!?: ]'
    UNION ALL
    SELECT
        CHR(value) AS symbol
    FROM letters_b
    WHERE CHR(value) SIMILAR TO '[a-zA-Z,.!?: ]'
);
