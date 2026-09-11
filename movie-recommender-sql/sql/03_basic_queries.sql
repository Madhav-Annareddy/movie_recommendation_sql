-- ============================================
-- 03. Basic Queries — Aggregates & Fundamentals (Oracle)
-- ============================================

-- Average rating and rating count per movie
SELECT
    m.title,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(*) AS num_ratings
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
ORDER BY avg_rating DESC;

-- Top 5 highest-rated movies with at least 3 ratings
SELECT
    m.title,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(*) AS num_ratings
FROM movies m
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY m.title
HAVING COUNT(*) >= 3
ORDER BY avg_rating DESC
FETCH FIRST 5 ROWS ONLY;

-- How many movies has each user rated?
SELECT
    u.name,
    COUNT(r.rating_id) AS movies_rated
FROM users u
LEFT JOIN ratings r ON u.user_id = r.user_id
GROUP BY u.name
ORDER BY movies_rated DESC;

-- Average rating per genre
SELECT
    g.genre_name,
    ROUND(AVG(r.rating), 2) AS avg_rating,
    COUNT(*) AS num_ratings
FROM genres g
JOIN movies m ON g.genre_id = m.genre_id
JOIN ratings r ON m.movie_id = r.movie_id
GROUP BY g.genre_name
ORDER BY avg_rating DESC;
