-- ============================================
-- 07. Bulk Sample Data Generator (Oracle, PL/SQL)
-- ============================================
-- Generates a larger, more realistic dataset:
--   500 users, 200 movies, 6 genres, ~20,000 ratings
--
-- Use this INSTEAD OF 02_sample_data.sql if you want scale
-- to demo performance / larger result sets. Run 01_schema.sql
-- first, then this file, in place of 02_sample_data.sql.

SET SERVEROUTPUT ON;

-- ---------- Clear existing data (safe re-run) ----------
BEGIN
    DELETE FROM ratings;
    DELETE FROM movies;
    DELETE FROM genres;
    DELETE FROM users;
    COMMIT;
END;
/

-- ---------- Genres (fixed list, same 6 as before) ----------
INSERT INTO genres (genre_name) VALUES ('Action');
INSERT INTO genres (genre_name) VALUES ('Comedy');
INSERT INTO genres (genre_name) VALUES ('Drama');
INSERT INTO genres (genre_name) VALUES ('Sci-Fi');
INSERT INTO genres (genre_name) VALUES ('Thriller');
INSERT INTO genres (genre_name) VALUES ('Romance');
COMMIT;

-- ---------- Generate 500 users ----------
BEGIN
    FOR i IN 1..500 LOOP
        INSERT INTO users (name, email)
        VALUES ('User ' || i, 'user' || i || '@example.com');
    END LOOP;
    COMMIT;
END;
/

-- ---------- Generate 200 movies, random genre + year ----------
DECLARE
    v_genre_id NUMBER;
    v_year     NUMBER;
BEGIN
    FOR i IN 1..200 LOOP
        v_genre_id := TRUNC(DBMS_RANDOM.VALUE(1, 7));   -- genre_id 1-6
        v_year     := TRUNC(DBMS_RANDOM.VALUE(2000, 2025));
        INSERT INTO movies (title, genre_id, release_year)
        VALUES ('Movie Title ' || i, v_genre_id, v_year);
    END LOOP;
    COMMIT;
END;
/

-- ---------- Generate ~20,000 ratings ----------
-- Random (user, movie, rating, date), skipping duplicates
-- because of the UNIQUE(user_id, movie_id) constraint.
-- Max possible unique pairs = 500 x 200 = 100,000, so 20,000
-- is well within range and will complete quickly.
DECLARE
    v_user_id   NUMBER;
    v_movie_id  NUMBER;
    v_rating    NUMBER;
    v_count     NUMBER := 0;
    v_attempts  NUMBER := 0;
    TARGET_ROWS CONSTANT NUMBER := 20000;
    MAX_TRIES   CONSTANT NUMBER := 200000;  -- safety cap
BEGIN
    WHILE v_count < TARGET_ROWS AND v_attempts < MAX_TRIES LOOP
        v_attempts := v_attempts + 1;
        v_user_id  := TRUNC(DBMS_RANDOM.VALUE(1, 501));   -- 1-500
        v_movie_id := TRUNC(DBMS_RANDOM.VALUE(1, 201));   -- 1-200
        v_rating   := TRUNC(DBMS_RANDOM.VALUE(1, 6));     -- 1-5

        BEGIN
            INSERT INTO ratings (user_id, movie_id, rating, rated_on)
            VALUES (
                v_user_id,
                v_movie_id,
                v_rating,
                DATE '2024-01-01' + TRUNC(DBMS_RANDOM.VALUE(0, 600))
            );
            v_count := v_count + 1;
        EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                NULL;  -- duplicate (user, movie) pair, just retry with new random values
        END;

        IF MOD(v_attempts, 5000) = 0 THEN
            COMMIT;  -- periodic commit so it doesn't hold one giant transaction
        END IF;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Ratings inserted: ' || v_count || ' (attempts: ' || v_attempts || ')');
END;
/

-- ---------- Sanity check ----------
SELECT
    (SELECT COUNT(*) FROM users)   AS total_users,
    (SELECT COUNT(*) FROM movies)  AS total_movies,
    (SELECT COUNT(*) FROM genres)  AS total_genres,
    (SELECT COUNT(*) FROM ratings) AS total_ratings
FROM dual;
