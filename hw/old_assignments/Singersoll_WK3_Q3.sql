-- Sofia Ingersoll
-- WK3 Q3

CREATE TEMP TABLE Averages AS (
    -- compute the average volume of the eggs in each nest
    SELECT 
        NEST_ID,
        AVG(Width * Width * Length) * (3.14/6) AS Avg_volume
    FROM 
        Bird_eggs
    GROUP BY 
        NEST_ID
);
-- nests of each species compute the maximum of those average volumes
SELECT 
    Species.Scientific_name,
    MAX(Avg_volume) AS Max_avg_volume
FROM 
    Species
JOIN 
    Bird_nests ON Species.Code = Bird_nests.Species
JOIN 
    Averages ON Bird_nests.Nest_ID = Averages.nest_id
GROUP BY 
    Species.Scientific_name
-- list by species in descending order of maximum volume
ORDER BY 
    Max_avg_volume DESC;
