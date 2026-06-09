/* =========================================================
   02A. BASIC CLEANING
   ========================================================= */

WITH club_cleaned AS (

    SELECT
        PlayerID,
        PlayerName,
        PlayerSurname,
        BirthYear,
        Position,

        CASE
            WHEN Club IS NULL THEN 'Unknown'
            ELSE TRIM(Club)
        END AS ClubCleaned

    FROM unified_raw
),

/* =========================================================
   02B. STANDARDIZATION (MAIN CLUBS)
========================================================= */

club_standardized_main AS (

    SELECT
        PlayerID,
        PlayerName,
        PlayerSurname,
        BirthYear,
        Position,
        ClubCleaned,

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
        END AS ClubStep1

    FROM club_cleaned
),

/* =========================================================
   02C. SPECIAL CASES + FINAL CLUB NAME
========================================================= */

club_final AS (

    SELECT
        PlayerID,
        PlayerName,
        PlayerSurname,
        BirthYear,
        Position,

        CASE
            WHEN ClubStep1 LIKE '%Trencin%' THEN 'AS Trenčín'
            WHEN ClubStep1 LIKE '%Toronto%' THEN 'Toronto FC'
            WHEN ClubStep1 LIKE '%Escola%' THEN 'Escola Varsovia'
            ELSE ClubStep1
        END AS ClubStandardized

    FROM club_standardized_main
),

/* =========================================================
   02D. DIM TABLE (DISTINCT + CLUB ID)
========================================================= */

dim_club AS (

    SELECT
        ROW_NUMBER() OVER (ORDER BY ClubName) AS ClubID,
        ClubName
    FROM (
        SELECT DISTINCT
            ClubStandardized AS ClubName
        FROM club_final
    ) d
)

SELECT *
FROM club_final;
