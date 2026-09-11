-- ============================================
-- 04. Find "Similar Users" — Self-Join on Ratings (Oracle)
-- ============================================
-- Logic: two users are "similar" if they both rated the
-- same movie(s) highly (>= 4). This is the foundation of
-- the recommendation query in 05_recommendations.sql.

-- Users who share taste with target user (user_id = 1)
SELECT DISTINCT
    r2.user_id AS similar_user_id,
    u.name     AS similar_user_name
FROM ratings r1
JOIN ratings r2
    ON r1.movie_id = r2.movie_id
   AND r1.user_id != r2.user_id
JOIN users u
    ON u.user_id = r2.user_id
WHERE r1.user_id = 1
  AND r1.rating >= 4
  AND r2.rating >= 4;

-- Same as above, but ranked by how many movies they agree on
-- (more shared high-rated movies = more "similar")
SELECT
    r2.user_id AS similar_user_id,
    u.name     AS similar_user_name,
    COUNT(*)   AS shared_liked_movies
FROM ratings r1
JOIN ratings r2
    ON r1.movie_id = r2.movie_id
   AND r1.user_id != r2.user_id
JOIN users u
    ON u.user_id = r2.user_id
WHERE r1.user_id = 1
  AND r1.rating >= 4
  AND r2.rating >= 4
GROUP BY r2.user_id, u.name
ORDER BY shared_liked_movies DESC;
