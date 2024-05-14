-- Sofia Ingersoll
-- WK4 SQL Q3
-- 2024/05/01

-- looking at nest data for “nome” between 1998 and 2008 inclusive, 
-- and for which egg age was determined by floating,
-- can you determine the name of the observer who observed exactly 36 nests? 
-- Please submit your SQL. Your SQL should return exactly one row


-- Let's see what table we can use
-- no Personnel, Site, Species
-- This range is between 2005 and 2014, so no go
SELECT MIN(Year) AS Min_Year, MAX(Year) AS Max_Year
FROM Camp_assignment;

-- This is the table we'll have to join with
-- Primary keys of interest: Year, Site, Observer, Nest_ID
SELECT MIN(Year) AS Min_Year, MAX(Year) AS Max_Year
FROM Bird_nests;

-- Actually, I think we just need Bird_nests from db schema
CREATE TABLE Bird_nests (
    Book_page VARCHAR,
    Year INTEGER NOT NULL CHECK (Year BETWEEN 1950 AND 2015),
    Site VARCHAR NOT NULL,
    Nest_ID VARCHAR PRIMARY KEY,
    Species VARCHAR NOT NULL,
    Observer VARCHAR,
    Date_found DATE NOT NULL
        CHECK (
            Date_found BETWEEN (Year||'-01-01')::DATE
            AND (Year||'-12-31')::DATE
        ),
    how_found VARCHAR CHECK (how_found IN ('searcher', 'rope', 'bander')),
    Clutch_max INTEGER CHECK (Clutch_max BETWEEN 0 AND 20),
    floatAge FLOAT CHECK (floatAge BETWEEN 0 AND 30),
    ageMethod VARCHAR CHECK (ageMethod IN ('float', 'lay', 'hatch')),
    FOREIGN KEY (Site) REFERENCES Site (Code),
    FOREIGN KEY (Species) REFERENCES Species (Code),
    FOREIGN KEY (Observer) REFERENCES Personnel (Abbreviation)
);

-- Let's give it a go!
SELECT Observer AS Name, COUNT(*) AS Num_floated_nests
FROM Bird_nests
    WHERE Site = 'nome' 
    AND Year BETWEEN 1998 AND 2008 
    AND ageMethod = 'float'
    GROUP BY Observer
    HAVING COUNT(*) = 36;

-- Beautiful! Let's make it pretty like we did in Q2!
SELECT Personnel.Name AS Observer, COUNT(*) AS Num_floated_nests
FROM Bird_nests
JOIN Personnel ON Bird_nests.Observer = Personnel.Abbreviation
    WHERE Bird_nests.Site = 'nome' 
    AND Bird_nests.Year BETWEEN 1998 AND 2008 
    AND Bird_nests.ageMethod = 'float'
    GROUP BY Personnel.Name
    HAVING COUNT(*) = 36;



