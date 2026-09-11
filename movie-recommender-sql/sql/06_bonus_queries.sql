-- ============================================
-- 06. Bonus Queries — Window Functions & Genre Affinity (Oracle)
-- ============================================

-- Rank recommended movies per target user using RANK()
-- (wraps the core recommendation logic as a subquery)
SELECT
    title,
    genre_name,
    avg_rating,
    RANK() OVER (ORDER BY avg_rating DESC) AS rec_rank
FROM (
    SELECT
        m.title,
        g.genre_name,
        ROUND(AVG(r2.rating), 2) AS avg_rating
    FROM ratings r1
    JOIN ratings r2
        ON r1.movie_id = r2.movie_id
       AND r1.user_id != r2.user_id
    JOIN ratings r3
        ON r2.user_id = r3.user_id
    JOIN movies m
        ON r3.movie_id = m.movie_id
    JOIN genres g
        ON m.genre_id = g.genre_id
    WHERE r1.user_id = 1
      AND r1.rating >= 4
      AND r2.rating >= 4
      AND r3.rating >= 4
      AND r3.movie_id NOT IN (
          SELECT movie_id FROM ratings WHERE user_id = 1
      )
    GROUP BY m.title, g.genre_name
) recs
ORDER BY rec_rank;

-- Which genres does a given user rate highest, on average?
SELECT
    g.genre_name,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(*) AS num_ratings
FROM ratings r
JOIN movies m ON r.movie_id = m.movie_id
JOIN genres g ON m.genre_id = g.genre_id
WHERE r.user_id = 1
GROUP BY g.genre_name
ORDER BY avg_rating DESC;

-- Running average of ratings a user gave, ordered by date
-- (shows if their "generosity" in rating trends up or down over time)
SELECT
    rated_on,
    rating,
    ROUND(AVG(rating) OVER (
        ORDER BY rated_on
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ), 2) AS running_avg_rating
FROM ratings
WHERE user_id = 1
ORDER BY rated_on;
