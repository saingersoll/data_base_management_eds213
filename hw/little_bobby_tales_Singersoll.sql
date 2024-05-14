-- Sofia Ingersoll
-- WK6 SQL Q1
-- 2024/05/14


-- For the purposes of this problem you may assume that at some point the school’s system performs the query
SELECT *
    FROM Students
    WHERE (name = '%s' AND year = 2024);


-- Now let's substitute lil bobby's name for name
-- Oop, that's a lot easier to see why lil bobby's query was so catatrophic 
-- It contains two commands: selecting students named robert from table 
-- and then it completely drops the students table!
-- completely removing that essential table from the database!
SELECT *
FROM Students
-- this double hyphen is typically used to comment things out
-- I suspect the commented out section was included to meet the requirements 
-- outlined in the query above for name and year
-- but not impact the true statement of dropping the table
WHERE (name = 'Robert'); DROP TABLE Students; --' AND year = 2024);


