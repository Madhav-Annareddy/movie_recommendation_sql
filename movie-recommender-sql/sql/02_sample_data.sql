-- ============================================
-- Movie Recommender (Pure SQL) — Sample Data (Oracle)
-- ============================================

-- Ensure date strings like '2025-01-05' parse as YYYY-MM-DD for this session
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD';

-- ---------- Users ----------
INSERT INTO users (name, email) VALUES ('Aditi Rao', 'aditi@example.com');
INSERT INTO users (name, email) VALUES ('Rohan Mehta', 'rohan@example.com');
INSERT INTO users (name, email) VALUES ('Sneha Kulkarni', 'sneha@example.com');
INSERT INTO users (name, email) VALUES ('Vikram Singh', 'vikram@example.com');
INSERT INTO users (name, email) VALUES ('Priya Nair', 'priya@example.com');
INSERT INTO users (name, email) VALUES ('Arjun Verma', 'arjun@example.com');
INSERT INTO users (name, email) VALUES ('Kavya Reddy', 'kavya@example.com');
INSERT INTO users (name, email) VALUES ('Manish Gupta', 'manish@example.com');
INSERT INTO users (name, email) VALUES ('Divya Iyer', 'divya@example.com');
INSERT INTO users (name, email) VALUES ('Karthik Pillai', 'karthik@example.com');
INSERT INTO users (name, email) VALUES ('Neha Joshi', 'neha@example.com');
INSERT INTO users (name, email) VALUES ('Sameer Khan', 'sameer@example.com');
INSERT INTO users (name, email) VALUES ('Ananya Das', 'ananya@example.com');
INSERT INTO users (name, email) VALUES ('Rahul Chatterjee', 'rahul@example.com');
INSERT INTO users (name, email) VALUES ('Isha Bhat', 'isha@example.com');

-- ---------- Genres ----------
INSERT INTO genres (genre_name) VALUES ('Action');
INSERT INTO genres (genre_name) VALUES ('Comedy');
INSERT INTO genres (genre_name) VALUES ('Drama');
INSERT INTO genres (genre_name) VALUES ('Sci-Fi');
INSERT INTO genres (genre_name) VALUES ('Thriller');
INSERT INTO genres (genre_name) VALUES ('Romance');

-- ---------- Movies ----------
-- genre_id: 1=Action, 2=Comedy, 3=Drama, 4=Sci-Fi, 5=Thriller, 6=Romance
INSERT INTO movies (title, genre_id, release_year) VALUES ('Steel Horizon', 1, 2019);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Laugh Track', 2, 2020);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Quiet Rooms', 3, 2018);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Event Horizon Rising', 4, 2021);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Midnight Signal', 5, 2022);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Paper Hearts', 6, 2017);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Broken Circuit', 4, 2020);
INSERT INTO movies (title, genre_id, release_year) VALUES ('The Long Drive', 3, 2016);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Comedy of Errors 2', 2, 2021);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Shadow Protocol', 5, 2019);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Iron Dawn', 1, 2015);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Love in Monsoon', 6, 2018);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Neon City', 4, 2022);
INSERT INTO movies (title, genre_id, release_year) VALUES ('The Silent Witness', 5, 2020);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Weekend Getaway', 2, 2019);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Falling Skies Redux', 1, 2023);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Letters Unsent', 3, 2014);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Second Chances', 6, 2021);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Deep Cover', 5, 2017);
INSERT INTO movies (title, genre_id, release_year) VALUES ('Starbound', 4, 2018);

-- ---------- Ratings ----------
-- Designed so that some users clearly share taste (e.g. users 1,2,3 all like sci-fi/thriller,
-- users 4,5 like romance/comedy) so the recommendation query returns meaningful results.

-- User 1: Aditi — likes Sci-Fi/Thriller
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (1, 4, 5, '2025-01-05');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (1, 7, 4, '2025-01-10');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (1, 10, 5, '2025-01-15');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (1, 13, 4, '2025-01-20');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (1, 6, 2, '2025-01-22');

-- User 2: Rohan — similar taste to Aditi (Sci-Fi/Thriller)
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (2, 4, 5, '2025-01-06');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (2, 7, 5, '2025-01-11');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (2, 10, 4, '2025-01-16');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (2, 14, 5, '2025-01-21');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (2, 19, 4, '2025-01-25');

-- User 3: Sneha — also Sci-Fi/Thriller fan, overlaps with 1 & 2
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (3, 4, 4, '2025-01-07');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (3, 13, 5, '2025-01-12');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (3, 20, 5, '2025-01-17');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (3, 10, 5, '2025-01-19');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (3, 2, 3, '2025-01-23');

-- User 4: Vikram — Romance/Comedy fan
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (4, 6, 5, '2025-01-08');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (4, 12, 5, '2025-01-13');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (4, 18, 4, '2025-01-18');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (4, 2, 4, '2025-01-24');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (4, 9, 3, '2025-01-26');

-- User 5: Priya — similar to Vikram (Romance/Comedy)
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (5, 6, 4, '2025-01-09');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (5, 12, 5, '2025-01-14');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (5, 18, 5, '2025-01-19');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (5, 15, 4, '2025-01-27');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (5, 9, 4, '2025-01-28');

-- User 6: Arjun — mixed, mostly Action/Drama
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (6, 1, 5, '2025-02-01');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (6, 11, 4, '2025-02-02');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (6, 16, 5, '2025-02-03');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (6, 3, 3, '2025-02-04');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (6, 8, 4, '2025-02-05');

-- User 7: Kavya — similar to Arjun (Action/Drama)
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (7, 1, 4, '2025-02-01');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (7, 11, 5, '2025-02-02');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (7, 16, 4, '2025-02-06');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (7, 17, 5, '2025-02-07');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (7, 3, 4, '2025-02-08');

-- User 8: Manish — Thriller fan, overlaps with users 1-3
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (8, 10, 5, '2025-02-01');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (8, 14, 4, '2025-02-02');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (8, 19, 5, '2025-02-03');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (8, 4, 4, '2025-02-09');

-- User 9: Divya — Drama/Romance mix
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (9, 3, 5, '2025-02-01');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (9, 8, 5, '2025-02-02');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (9, 17, 4, '2025-02-03');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (9, 12, 3, '2025-02-10');

-- User 10: Karthik — broad taste, few ratings
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (10, 1, 3, '2025-02-01');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (10, 5, 4, '2025-02-02');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (10, 9, 4, '2025-02-03');

-- User 11: Neha — Sci-Fi, light overlap
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (11, 4, 4, '2025-02-04');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (11, 20, 4, '2025-02-05');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (11, 7, 5, '2025-02-06');

-- User 12: Sameer — Action fan
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (12, 1, 5, '2025-02-04');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (12, 11, 5, '2025-02-05');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (12, 16, 4, '2025-02-06');

-- User 13: Ananya — Comedy fan
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (13, 2, 5, '2025-02-04');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (13, 9, 5, '2025-02-05');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (13, 15, 4, '2025-02-06');

-- User 14: Rahul — Thriller fan, overlaps with 1,2,3,8
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (14, 10, 5, '2025-02-07');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (14, 14, 5, '2025-02-08');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (14, 19, 4, '2025-02-09');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (14, 4, 5, '2025-02-10');

-- User 15: Isha — Romance fan, overlaps with 4,5
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (15, 6, 5, '2025-02-07');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (15, 12, 4, '2025-02-08');
INSERT INTO ratings (user_id, movie_id, rating, rated_on) VALUES (15, 18, 5, '2025-02-09');

COMMIT;
