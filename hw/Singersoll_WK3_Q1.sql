-- Q1
-- initiate database
duckdb database.db

-- create view table for now
-- will convert to table after confirmed process works as expected
CREATE VIEW Site_avg_eggs_test AS
  SELECT Site, Nest_ID, AVG(Egg_num) FROM Bird_eggs 
  GROUP BY Nest_ID;
  
-- let's make a temp table for avg_eggs for each nest_id that includes NULL
CREATE TEMP TABLE Site_avg_eggs AS
  SELECT Site, Nest_ID, AVG(Egg_num) AS avg_egg_num
  FROM Bird_eggs 
  GROUP BY Site, Nest_ID;

-- let's make sure this worked!
SELECT * FROM Site_avg_eggs;      -- great! it worked!


-- Time to make a temp table for avg_eggs without NULL
CREATE TEMP TABLE Site_avg_eggs_no_null AS
SELECT Site, Nest_ID, AVG(Egg_num) AS avg_egg_num
FROM Bird_eggs 
WHERE Egg_num IS NOT NULL
GROUP BY Site, Nest_ID;

-- let's make sure this worked!
SELECT * FROM Site_avg_eggs_no_null;      -- great! it worked!


-- let's compute the difference between those two ways of computing average
-- join then do the difference
SELECT Site, Site_avg_eggs.avg_egg_num - Site_avg_eggs_no_null.avg_egg_num AS avg_diff
    FROM Site_avg_eggs
    -- this is inner join by convention
    JOIN Site_avg_eggs_no_null USING (Site, Nest_ID);       -- as expected, the outputs are exactly the same!

