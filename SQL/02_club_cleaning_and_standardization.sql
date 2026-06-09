-- STEP 1: basic cleaning (NULL + trimming)

SELECT
    PlayerID,
    PlayerName,
    CASE
        WHEN Club IS NULL THEN 'Unknown'
        ELSE TRIM(Club)
    END AS ClubCleaned,
    Position
FROM unified_raw;

-- STEP 2: standardization using LIKE patterns

SELECT
    PlayerID,
    PlayerName,

    CASE
        WHEN ClubCleaned LIKE '%Lech%' THEN 'Lech Poznań'
        WHEN ClubCleaned LIKE '%Legia%' THEN 'Legia Warszawa'
        WHEN ClubCleaned LIKE '%Wisła%' THEN 'Wisła Kraków'
        WHEN ClubCleaned LIKE '%Zagłębie%' THEN 'Zagłębie Lubin'
        WHEN ClubCleaned LIKE '%Śląsk%' THEN 'Śląsk Wrocław'
        WHEN ClubCleaned LIKE '%Raków%' THEN 'Raków Częstochowa'
        WHEN ClubCleaned LIKE '%Widzew%' THEN 'Widzew Łódź'
        WHEN ClubCleaned LIKE '%ŁKS%' THEN 'ŁKS Łódź'
        WHEN ClubCleaned LIKE '%GKS%' THEN 'GKS Katowice'
        WHEN ClubCleaned LIKE '%Korona%' THEN 'Korona Kielce'
        WHEN ClubCleaned LIKE '%Pogoń%' THEN 'Pogoń Szczecin'
        ELSE ClubCleaned
    END AS ClubStep2

FROM (
    SELECT
        PlayerID,
        PlayerName,
        CASE WHEN Club IS NULL THEN 'Unknown' ELSE TRIM(Club) END AS ClubCleaned
    FROM unified_raw
) t;

-- STEP 3: special cases + final standardization

SELECT
    PlayerID,
    PlayerName,

    CASE
        -- missing values
        WHEN Club IS NULL THEN 'Unknown'

        -- basic normalization
        WHEN Club LIKE '%Lech%' THEN 'Lech Poznań'
        WHEN Club LIKE '%Legia%' THEN 'Legia Warszawa'
        WHEN Club LIKE '%Wisła%' THEN 'Wisła Kraków'
        WHEN Club LIKE '%Zagłębie%' THEN 'Zagłębie Lubin'
        WHEN Club LIKE '%Śląsk%' THEN 'Śląsk Wrocław'
        WHEN Club LIKE '%Raków%' THEN 'Raków Częstochowa'
        WHEN Club LIKE '%Widzew%' THEN 'Widzew Łódź'
        WHEN Club LIKE '%ŁKS%' THEN 'ŁKS Łódź'
        WHEN Club LIKE '%GKS%' THEN 'GKS Katowice'
        WHEN Club LIKE '%Korona%' THEN 'Korona Kielce'
        WHEN Club LIKE '%Pogoń%' THEN 'Pogoń Szczecin'

        -- special cases
        WHEN Club LIKE '%Trencin%' THEN 'AS Trenčín'
        WHEN Club LIKE '%Toronto%' THEN 'Toronto FC'
        WHEN Club LIKE '%Escola%' THEN 'Escola Varsovia'

        -- slash handling (simple)
        WHEN Club LIKE '%/%' THEN REPLACE(Club, '/', '|')

        ELSE TRIM(Club)
    END AS ClubStandardized

FROM unified_raw;

-- STEP 4: CREATE CLUB DIMENSION TABLE

-- Create a reference table with unique clubs
-- Each club gets a unique identifier (ClubID)

CREATE TABLE dim_club AS
SELECT DISTINCT
    ClubStandardized AS ClubName
FROM cleaned_data;

-- Add primary key to dimension table

ALTER TABLE dim_club
ADD ClubID INT IDENTITY(1,1) PRIMARY KEY;
