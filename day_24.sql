SELECT
    songs.song_id,
    songs.song_title,
    pl.played,
    sk.skipped
FROM songs
JOIN (
    SELECT
        song_id,
        COUNT(1) AS played
    FROM user_plays
    GROUP BY song_id
) pl ON pl.song_id = songs.song_id
JOIN (
    SELECT
        song_id,
        COUNT(1) AS skipped
    FROM user_plays
    GROUP BY song_id, duration
    HAVING duration IS NULL
) sk ON sk.song_id = songs.song_id
ORDER BY played DESC, skipped
LIMIT 1;
