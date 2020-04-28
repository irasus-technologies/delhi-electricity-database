CREATE OR REPLACE FUNCTION public."get__tableName_rowCount"()
RETURNS text[]
LANGUAGE PLPGSQL
AS $$
DECLARE
    schematablename TEXT[];
    tablename TEXT;
    rowcounts TEXT[];
    rowcount TEXT;
    i INTEGER := 1;
BEGIN
    FOR tablename IN
        SELECT
            CONCAT(table_schema, '.', table_name)
        FROM
            information_schema.tables
        WHERE
            table_schema IN ('public', 'edata', 'metadata') AND
            table_type = 'BASE TABLE'
    LOOP
        schematablename := STRING_TO_ARRAY(tablename, '.');
        EXECUTE FORMAT('SELECT COUNT(*) FROM %I.%I', schematablename[1], schematablename[2]) INTO rowcount;
        rowcounts[i] := FORMAT('%I,%I', tablename, rowcount);
        i := i + 1;
    END LOOP;
    RETURN rowcounts;
END
$$;
