-- Q1
-- initiate database
duckdb hw.db

-- create view table for now
-- will convert to table after confirmed process works as expected
CREATE VIEW Site_avg_eggs AS
  FROM Bird_eggs SELECT Egg_num
  GROUP BY Nest_ID,
  AVG(Egg_num);
  
  
CREATE TABLE Species (
    Code TEXT PRIMARY KEY,
    Common_name TEXT UNIQUE NOT NULL,
    Scientific_name TEXT,
    Relevance TEXT
);

