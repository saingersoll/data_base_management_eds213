-- Sofia Ingersoll
-- WK5 Q1
-- 2024 / 5 / 10

-- Some strategies were mentioned in class for reducing 
-- the possibility of performing UPDATEs and DELETEs that have catastrophic consequences. 
-- What strategy will you use?


-- UPDATE & DELETE 
-- CAUTION: THESE ARE VERY DANGEROUS COMMANDS
-- VERY POWERFULL

--- SAFETY STEPS FOR DELETE
-- So the workflow is a check statement 
-- to ensure I'm working with what I want
-- Then after checking add delete

-- E.G.
-- confirm the rows you want to delete first
SELECT * FROM Species
WHERE Relevance = 'Study species';

-- now that i've confirmed these are the rows I want
-- let's edit the previous clause
DELETE * FROM Species
WHERE Relevance = 'Study species';

-- Finish by confirming it worked 
SELECT Relevance FROM Species

-- SAFETY STEPS FOR UPDATES
-- So the workflow is a check statement 
-- to ensure I'm working with what I want
-- Then after checking execute updates
-- Finish by confirming it worked 


-- E.G.
-- update instances 
UPDATE Species SET Relevance = 'not sure yet' 
WHERE Relevance IS NULL;

SELECT * FROM Species;

-- remove instances
DELETE Species
DELETE FROM Species 
WHERE Relevance = 'not sure yet';

-- check
SELECT * FROM Species
