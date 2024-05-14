-- Sofia Ingersoll
-- WK4 SQL Q2
-- 2024/05/01

-- using a self-join find Who worked with whom
-- find all pairs of people who worked at the same site,
-- and whose date ranges overlap while at that site

-- Step 1. To the above join, add an ON clause that selects only those 
-- rows where the two people (the “A” person and the “B” person) worked at the same site: ON A.Site = .... 
-- You should wind up with a table with 15521 rows.

SELECT A.Observer AS Observer_A, B.Observer AS Observer_B
FROM Camp_assignment A
JOIN Camp_assignment B ON A.Site = B.Site;


-- Step 2. We’ve matched up people working at the same site, but they don’t necessarily overlap in time. 
-- To the previous ON clause, add another condition that checks that the “A” person’s and the “B” person’s date ranges overlap. 
-- If you are unsure of the formula to do this, it may be helpful to consult this StackOverflow post. Your table should be down to 3500 rows.
SELECT A.Observer AS Observer_A, B.Observer AS Observer_B
FROM Camp_assignment A
JOIN Camp_assignment B ON A.Site = B.Site
    -- Ensure date ranges overlap
    AND A.Start <= B.End AND A.End >= B.Start;



-- Step 3. Well, there’s a problem. To better see it, add a clause WHERE A.Site = 'lkri' so you have only rows. 
-- If you look closely, you can see that there are rows representing people working with themselves, which is not what we’re interested in. 
-- Also, every pair of people working together is represented by two rows, which are identical but with the names in different order. 
-- We only want one row per unique pair of people. We can clean this up by adding a condition to the clause, 
-- A.Observer < B.Observer. I.e., we only want ordered, distinct pairs. Your table should be down to rows.


SELECT A.Observer AS Observer_A, B.Observer AS Observer_B
FROM Camp_assignment A
JOIN Camp_assignment B ON A.Site = B.Site
    WHERE  A.Site = 'lkri'
    -- Ensure date ranges overlap
    AND A.Start <= B.End AND A.End >= B.Start
    -- To avoid duplicate pairs (A, B) and (B, A)
    AND A.Observer < B.Observer; 

-- Step 4. Clean up your table so it looks like this
SELECT A.Site, A.Observer AS Observer_A, B.Observer AS Observer_B, 
FROM Camp_assignment A
JOIN Camp_assignment B ON A.Site = B.Site
    WHERE  A.Site = 'lkri'
    -- Ensure date ranges overlap
    AND A.Start <= B.End AND A.End >= B.Start
    -- To avoid duplicate pairs (A, B) and (B, A)
    AND A.Observer < B.Observer; 

-- Bonus problem!

-- Produce this much nicer table by joining with the Personnel table:
-- You’ll need to join with the Personnel table twice, once for each observer column.
-- You may need give abbreviations to tables 
-- (e.g., JOIN Personnel AS p1) to distinguish the tables and columns. You can do it!


-- let's look at the relaitonships from db schema
CREATE TABLE Camp_assignment (
    Year INTEGER NOT NULL CHECK (Year BETWEEN 1950 AND 2015),
    Site VARCHAR NOT NULL,
    Observer VARCHAR NOT NULL,
    Start DATE,
    "End" DATE,
    FOREIGN KEY (Site) REFERENCES Site (Code),
    FOREIGN KEY (Observer) REFERENCES Personnel (Abbreviation),
    CHECK (Start <= "End"),
    CHECK (Start BETWEEN (Year||'-01-01')::DATE AND (Year||'-12-31')::DATE),
    CHECK ("End" BETWEEN (Year||'-01-01')::DATE AND (Year||'-12-31')::DATE);

CREATE TABLE Personnel (
    Abbreviation VARCHAR PRIMARY KEY,
    Name VARCHAR UNIQUE NOT NULL
);


-- Let's do it!
SELECT ca.Site, p1.Name AS Name_1, p2.Name AS Name_2
FROM Camp_assignment ca
JOIN Personnel p1 ON ca.Observer = p1.Abbreviation
JOIN Camp_assignment cb ON ca.Site = cb.Site
JOIN Personnel p2 ON cb.Observer = p2.Abbreviation
-- Filter for specific site
    WHERE ca.Site = 'lkri' 
-- To avoid duplicate pairs (Name_1, Name_2) and (Name_2, Name_1)
    AND ca.Observer < cb.Observer
-- Ensure date ranges overlap
    AND ca.Start <= cb."End" AND ca."End" >= cb.Start
-- Ensure different names
    AND p1.Abbreviation != p2.Abbreviation;


