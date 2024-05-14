-- Sofia Ingersoll
-- WK 3 Q2

-- Part 1
-- let's break down why this doesn't work
-- This query is not helpful because 
-- the Site name requires an aggregate function
-- because each Site_name appears more than once
SELECT Site_name, MAX(Area) FROM Site;

-- Here are examples of aggregate functs 
-- that consider all of the Site observations:
SELECT Site_name, AVG(Area) FROM Site
SELECT Site_name, COUNT(*) FROM Site
SELECT Site_name, SUM(Area) FROM Site


-- Part 2
-- However to answer the original query properly
SELECT Site_name, MAX(Area) AS Site_area_max
FROM Site
GROUP BY Site_name 
-- let's add a little spice and see it in descending order
ORDER BY Site_area_max DESC
-- and only look at the site with the largest area
LIMIT 1;



-- Part 3
-- create a query that finds the maximum area
SELECT Site_name, Area 
FROM Site 
-- create a query that selects the site name and
-- area of the site whose area equals the maximum
WHERE Area = (SELECT MAX(Area) FROM Site);

