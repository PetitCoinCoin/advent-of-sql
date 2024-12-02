SELECT
    name,
    first_choice,
    backup_choice,
    color,
    color_count,
    CASE difficulty_to_make
        WHEN 1 THEN 'Simple Gift'
        WHEN 2 THEN 'Moderate Gift'
        ELSE 'Complex Gift'
    END AS gift_complexity,
    CASE category
        WHEN 'outdoor' THEN 'Outside Workshop'
        WHEN 'educational' THEN 'Learning Workshop'
        ELSE 'General Workshop' 
    END AS workshop
FROM (
    SELECT
        name,
        wishes ->> 'first_choice' AS first_choice,
        wishes ->> 'second_choice' AS backup_choice,
        wishes -> 'colors' ->> 0 AS color,
        json_array_length(wishes -> 'colors') AS color_count
    FROM children
    JOIN wish_lists on children.child_id = wish_lists.child_id
) AS child_list
JOIN toy_catalogue on child_list.first_choice = toy_catalogue.toy_name
ORDER BY name LIMIT 5;
