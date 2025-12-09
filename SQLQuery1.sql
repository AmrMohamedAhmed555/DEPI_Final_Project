CREATE VIEW v_MTA_Analytics AS
SELECT 
    Date,
    Transport_Type,
    Total_Ridership,
    CAST(Recovery_Percent AS FLOAT) / 100.0 as Recovery_Rate,
    YEAR(Date) as Year,
    DATENAME(MONTH, Date) as Month_Name,
    MONTH(Date) as Month_Num,
    DATENAME(WEEKDAY, Date) as Day_Name,
    
    CASE 
        WHEN Transport_Type IN ('Bridges and Tunnels') THEN 'Private Vehicle'
        ELSE 'Public Transit'
    END as Transport_Category,

    CASE 
        WHEN Recovery_Percent < 50 THEN 'Critical (<50%)'
        WHEN Recovery_Percent BETWEEN 50 AND 89 THEN 'Recovering (50-90%)'
        ELSE 'Normal (>90%)'
    END as Recovery_Status

FROM MTA_Unpivoted_Data;
