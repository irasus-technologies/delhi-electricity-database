CREATE OR REPLACE FUNCTION public."round_minutes"(TIMESTAMP WITHOUT TIME ZONE, INTEGER) 
RETURNS TIMESTAMP WITHOUT TIME ZONE
LANGUAGE SQL
AS $$ 
    SELECT
        DATE_TRUNC('hour', $1)
        + CAST(($2::VARCHAR||' min') as INTERVAL) 
        * ROUND(
        (DATE_PART('minute', $1)::FLOAT + DATE_PART('second', $1) / 60.)::FLOAT 
        / $2::FLOAT
    )
$$;
