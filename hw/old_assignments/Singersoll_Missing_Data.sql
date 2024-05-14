-- Sofia Ingersoll
-- WK4 SQL Q1
-- 2024/05/01

-- Which sites have no egg data? Please answer this question using all three techniques demonstrated in class. 
-- Add an ORDER BY clause to your queries so that all three produce the exact same result

-- First let's peek at the responses requirements in Egg_num from db schema
-- Okie, we'll use Site for NULL values
CREATE TABLE Bird_eggs (
    Book_page VARCHAR,
    Year INTEGER NOT NULL CHECK (Year BETWEEN 1950 AND 2015),
    Site VARCHAR NOT NULL,
    Nest_ID VARCHAR NOT NULL,
    Egg_num INTEGER NOT NULL CHECK (Egg_num BETWEEN 1 AND 20),
    Length FLOAT NOT NULL CHECK (Length > 0 AND Length < 100),
    Width FLOAT NOT NULL CHECK (Width > 0 AND Width < 100),
    PRIMARY KEY (Nest_ID, Egg_num),
    FOREIGN KEY (Site) REFERENCES Site (Code),
    FOREIGN KEY (Nest_ID) REFERENCES Bird_nests (Nest_ID)
);

-- Using a Code NOT IN (subquery) clause.
SELECT Code
FROM Site
WHERE Code NOT IN (
    SELECT DISTINCT Site
    FROM Bird_eggs
)
ORDER BY Code;


-- Using an outer join with a WHERE clause that selects the desired rows. 
-- Caution: make sure your IS NULL test is performed against a column that is not ordinarily allowed to be NULL. 
-- You may want to consult the database schema to remind yourself of column declarations.
SELECT Site.Code
FROM Site 
LEFT JOIN Bird_eggs ON Site.Code = Bird_eggs.Site
    WHERE Bird_eggs.Site IS NULL
    ORDER BY Code;


-- Using the set operation EXCEPT
SELECT Code
FROM Site
EXCEPT
SELECT DISTINCT Site
FROM Bird_eggs
    ORDER BY Code;
