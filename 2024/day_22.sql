SELECT
    SUM(CASE WHEN 'SQL' = ANY (string_to_array(skills, ',')) THEN 1 ELSE 0 END)
FROM elves;
