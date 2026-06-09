/*=========================================================
  03A: clean position format
  =========================================================*/


WITH position_cleaned AS (

    SELECT
        PlayerID,
        PlayerName,
        PlayerSurname,

        TRIM(
            REPLACE(
                REPLACE(Position, '/', '|'),
            '.', '|')
        ) AS PositionClean

    FROM unified_raw
)

/*=========================================================
   03B: position normalization (long format)
   split positions into separate rows
   =========================================================*/
    

SELECT
    PlayerID,
    PlayerName,
    PlayerSurname,
    TRIM(value) AS Position
FROM position_cleaned
CROSS APPLY STRING_SPLIT(PositionClean, '|')
WHERE value IS NOT NULL;
