CREATE OR REPLACE FUNCTION public."get__tableName_rowMinMax"()
RETURNS text[]
LANGUAGE PLPGSQL
AS $$
DECLARE
    schematablename TEXT[];
    tablename TEXT;
    rowcounts TEXT[];
    rowcount TEXT;
    rowmin TEXT;
    rowmax TEXT;
    i INTEGER := 1;
BEGIN
    FOR tablename IN
        SELECT
            CONCAT(table_schema, '.', table_name)
        FROM
            information_schema.tables
        WHERE
            table_schema IN ('edata') AND
            table_type = 'BASE TABLE'
    LOOP
        schematablename := STRING_TO_ARRAY(tablename, '.');
        EXECUTE FORMAT('SELECT COUNT(*), MIN("serialNumber"), MAX("serialNumber") FROM %I.%I', schematablename[1], schematablename[2]) INTO rowcount, rowmin, rowmax;
        rowcounts[i] := FORMAT('%I,%I,%I,%I', tablename, rowcount, rowmin, rowmax);
        i := i + 1;
    END LOOP;
    RETURN rowcounts;
END
$$;
