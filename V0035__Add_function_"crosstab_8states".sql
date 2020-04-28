CREATE OR REPLACE FUNCTION public."crosstab_8states"(
    IN TEXT,
    OUT "time" TIMESTAMP WITHOUT TIME ZONE,
    OUT "CH" REAL,
    OUT "HP" REAL,
    OUT "HR" REAL,
    OUT "JK" REAL,
    OUT "PB" REAL,
    OUT "RJ" REAL,
    OUT "UK" REAL,
    OUT "UP" REAL)
RETURNS SETOF record
AS '$libdir/tablefunc','crosstab' LANGUAGE C STABLE STRICT;
