CREATE OR REPLACE FUNCTION public."crosstab_2entities_numeric_n"(
    IN TEXT,
    OUT "time" TIMESTAMP WITHOUT TIME ZONE,
    OUT entity_1 NUMERIC,
    OUT entity_2 NUMERIC)
RETURNS SETOF record
AS '$libdir/tablefunc','crosstab' LANGUAGE C STABLE STRICT;
