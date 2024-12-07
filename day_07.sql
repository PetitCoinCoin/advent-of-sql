SELECT
    max_tbl.elf_id AS elf_1_id,
    min_tbl.elf_id AS elf_2_id,
    max_tbl.primary_skill
FROM (
    SELECT DISTINCT ON (primary_skill)
        elf_id,
        years_experience,
        primary_skill
    FROM workshop_elves
    ORDER BY primary_skill, years_experience DESC, elf_id
) max_tbl
JOIN (
    SELECT DISTINCT ON (primary_skill)
        elf_id,
        years_experience,
        primary_skill
    FROM workshop_elves
    ORDER BY primary_skill, years_experience, elf_id
) min_tbl
ON max_tbl.primary_skill = min_tbl.primary_skill
ORDER BY primary_skill
LIMIT 3;
