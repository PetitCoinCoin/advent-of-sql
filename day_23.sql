CREATE OR REPLACE FUNCTION f_missing (INTEGER, INTEGER) RETURNS INTEGER[] AS $$
DECLARE
    counter INTEGER = $1; 
    missing int []; 
BEGIN
    WHILE counter != 0 LOOP
        missing  := array_append(missing, $2 - counter);
        counter := counter - 1; 
    END LOOP;
    RETURN missing;   
END;   
$$ LANGUAGE 'plpgsql';

SELECT * 
FROM (
    SELECT
        f_missing(id - LAG(id) OVER (ORDER BY id) - 1, id) AS delta
    FROM sequence_table
)
WHERE delta IS NOT NULL;
