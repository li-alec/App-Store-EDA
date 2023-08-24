CREATE TABLE appleStore_description_combined AS 

SELECT * FROM appleStore_description1

UNION ALL 

SELECT * FROM appleStore_description2

UNION ALL

SELECT * FROM appleStore_description3

UNION ALL 

SELECT * FROM appleStore_description4

-- Stakeholder is an aspiring app developer who needs data-driven insight on what kind of app to build. What app categories are most popular? What price should i set? 
-- How can I maximize User ratings?
**Exploratory Data Analysis**
SELECT * FROM AppleStore LIMIT 5

-- Checking to see number of unique apps in the table AppleStore
SELECT COUNT(DISTINCT id) AS UNIQUEAPPIDs
FROM AppleStore

-- Checking for any missing values
SELECT COUNT(*) AS MissingValues 
FROM AppleStore 
WHERE track_name IS NULL OR user_rating IS NULL or prime_genre IS NULL

SELECT COUNT(*) AS MissingValues 
FROM appleStore_description_combined 
WHERE track_name IS NULL OR app_desc IS NULL 

-- Summarizing app categories, viewing which is the most popular and how many of each category. 
SELECT prime_genre, COUNT(id) AS NUMAPP
FROM AppleStore
GROUP By prime_genre
ORDER BY NUMAPP DESC 

SELECT min(user_rating) AS MinRating,
	   max(user_rating) AS MaxRating, 
       avg(user_rating) AS AvgRating 
FROM AppleStore 

SELECT 
	(price/2) * 2 AS PriceBinStart,
    ((price / 2) * 2) * 2 As PriceBinENd,
    COUNT(*) AS NumApps 
FROM AppleStore

Group By PriceBinStart
Order by PriceBinStart 

-- Determine whether paid apps have higher ratings than free apps
SELECT CASE 
			WHEN price > 0 THEN 'PAID' 
   			ELSE ' FREE' 
       END AS App_Type, 
       avg(user_rating) AS AvgRating
FROM AppleStore
GROUP By App_Type 

-- Check if apps with more supported languages have higher ratings
SELECT CAse
			WHEN lang_num > 10 THEN '<10 languages'
            WHEN lang_num BETWEEN 10 AND 30 THEN '10-30 languages'
            ELSE '>30'
       END AS Lang,
       avg(user_rating) AS AvgRating 
FROM AppleStore
GROUP By Lang 

-- Check to see if app rating is affected by description

SELECT CASE 
			WHEN length(b.app_desc) < 500 THEN 'SHORT' 
            WHEN length(b.app_desc) BETWEEN 500 AND 1000 THEN 'MEDIUM' 
            ELSE 'LONG' 
       END AS desc_length, 
       avg(user_rating) AS AvgRating
FROM
	Applestore AS A 
JOIN
	appleStore_description_combined as B 
On 
	A.id = B.id 
GROUP BY desc_length
ORDER By desc_length

-- Checking the lowest rated genres 
SELECT prime_genre, avg(user_rating) As AvgRating 
FROM AppleStore
GROUP BY prime_genre
ORDER By AvgRating ASC 
