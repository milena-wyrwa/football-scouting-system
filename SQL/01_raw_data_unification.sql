/* =========================================================
   01. RAW DATA UNIFICATION (YEARLY TABLES → SINGLE DATASET)
   =========================================================
   Each table represents a birth year cohort (not a column)
   Tables: dbo.[2009] ... dbo.[2017]
========================================================= */

WITH unified_raw AS (

    SELECT
        PlayerID,
        PlayerName,
        Club,
        Position,
        NULL AS Attributes,
        '2009' AS BirthYear
    FROM dbo.[2009]

    UNION ALL

    SELECT
        PlayerID,
        PlayerName,
        Club,
        Position,
        NULL AS Attributes,
        '2010' AS BirthYear
    FROM dbo.[2010]

    UNION ALL

    SELECT
        PlayerID,
        PlayerName,
        Club,
        Position,
        NULL AS Attributes,
        '2011' AS BirthYear
    FROM dbo.[2011]

    UNION ALL

    SELECT
        PlayerID,
        PlayerName,
        Club,
        Position,
        NULL AS Attributes,
        '2012' AS BirthYear
    FROM dbo.[2012]

    UNION ALL

    SELECT
        PlayerID,
        PlayerName,
        Club,
        Position,
        NULL AS Attributes,
        '2013' AS BirthYear
    FROM dbo.[2013]

    UNION ALL

    SELECT
        PlayerID,
        PlayerName,
        Club,
        Position,
        NULL AS Attributes,
        '2014' AS BirthYear
    FROM dbo.[2014]

    UNION ALL

    SELECT
        PlayerID,
        PlayerName,
        Club,
        Position,
        NULL AS Attributes,
        '2015' AS BirthYear
    FROM dbo.[2015]

    UNION ALL

    SELECT
        PlayerID,
        PlayerName,
        Club,
        Position,
        NULL AS Attributes,
        '2016' AS BirthYear
    FROM dbo.[2016]

    UNION ALL

    SELECT
        PlayerID,
        PlayerName,
        Club,
        Position,
        NULL AS Attributes,
        '2017' AS BirthYear
    FROM dbo.[2017]
)
