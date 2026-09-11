-- ============================================
-- 05. Core Recommendation Query (Oracle)
-- ============================================
-- Pitch: "Find users who agreed with me on movies I liked,
-- then recommend what THEY liked that I haven't seen yet."
--
-- This is collaborative filtering logic implemented purely
-- in SQL via self-joins + a NOT IN exclusion subquery —
-- no ML library involved.

-- Recommendations for target user_id = 1
SELECT
    m.title,
    g.genre_name,
    COUNT(*)                AS liked_by_similar_users,
    ROUND(AVG(r2.rating),2) AS avg_rating
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
WHERE r1.user_id = 1                 -- target user
  AND r1.rating >= 4                 -- movies target user liked
  AND r2.rating >= 4                 -- similar users also liked those movies
  AND r3.rating >= 4                 -- and we recommend other movies they liked
  AND r3.movie_id NOT IN (           -- exclude movies target user already rated
      SELECT movie_id FROM ratings WHERE user_id = 1
  )
GROUP BY m.title, g.genre_name
ORDER BY liked_by_similar_users DESC, avg_rating DESC
FETCH FIRST 5 ROWS ONLY;

-- ------------------------------------------------------------
-- Interview follow-up: "Rewrite the NOT IN as a LEFT JOIN"
-- ------------------------------------------------------------
SELECT
    m.title,
    g.genre_name,
    COUNT(*)                AS liked_by_similar_users,
    ROUND(AVG(r2.rating),2) AS avg_rating
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
LEFT JOIN ratings already_seen
    ON already_seen.user_id = 1
   AND already_seen.movie_id = r3.movie_id
WHERE r1.user_id = 1
  AND r1.rating >= 4
  AND r2.rating >= 4
  AND r3.rating >= 4
  AND already_seen.rating_id IS NULL   -- keeps only movies user 1 hasn't rated
GROUP BY m.title, g.genre_name
ORDER BY liked_by_similar_users DESC, avg_rating DESC
FETCH FIRST 5 ROWS ONLY;
