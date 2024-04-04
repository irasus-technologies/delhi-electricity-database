--
-- PostgreSQL database dump
--

-- Dumped from database version 13.13 (Debian 13.13-1.pgdg110+1)
-- Dumped by pg_dump version 13.13 (Debian 13.13-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: edata; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "edata";


--
-- Name: metadata; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA "metadata";


--
-- Name: tablefunc; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "tablefunc" WITH SCHEMA "public";


--
-- Name: EXTENSION "tablefunc"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "tablefunc" IS 'functions that manipulate whole tables, including crosstab';


--
-- Name: crosstab_2entities_numeric_n("text"); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "public"."crosstab_2entities_numeric_n"("text", OUT "time" timestamp without time zone, OUT "entity_1" numeric, OUT "entity_2" numeric) RETURNS SETOF "record"
    LANGUAGE "c" STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


--
-- Name: crosstab_8states("text"); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "public"."crosstab_8states"("text", OUT "time" timestamp without time zone, OUT "CH" real, OUT "HP" real, OUT "HR" real, OUT "JK" real, OUT "PB" real, OUT "RJ" real, OUT "UK" real, OUT "UP" real) RETURNS SETOF "record"
    LANGUAGE "c" STABLE STRICT
    AS '$libdir/tablefunc', 'crosstab';


--
-- Name: get__tableName_rowCount(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "public"."get__tableName_rowCount"() RETURNS "text"[]
    LANGUAGE "plpgsql"
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


--
-- Name: get__tableName_rowMinMax(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "public"."get__tableName_rowMinMax"() RETURNS "text"[]
    LANGUAGE "plpgsql"
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


--
-- Name: round_minutes(timestamp without time zone, integer); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION "public"."round_minutes"(timestamp without time zone, integer) RETURNS timestamp without time zone
    LANGUAGE "sql"
    AS $_$ 
    SELECT
        DATE_TRUNC('hour', $1)
        + CAST(($2::VARCHAR||' min') as INTERVAL) 
        * ROUND(
        (DATE_PART('minute', $1)::FLOAT + DATE_PART('second', $1) / 60.)::FLOAT 
        / $2::FLOAT
    )
$_$;


SET default_tablespace = '';

SET default_table_access_method = "heap";

--
-- Name: discoms; Type: TABLE; Schema: edata; Owner: -
--

CREATE TABLE "edata"."discoms" (
    "timestamp" timestamp without time zone NOT NULL,
    "unitNumber" smallint NOT NULL,
    "power" real NOT NULL,
    "serialNumber" bigint NOT NULL
);


--
-- Name: discoms_serialNumber_seq; Type: SEQUENCE; Schema: edata; Owner: -
--

CREATE SEQUENCE "edata"."discoms_serialNumber_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: discoms_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: edata; Owner: -
--

ALTER SEQUENCE "edata"."discoms_serialNumber_seq" OWNED BY "edata"."discoms"."serialNumber";


--
-- Name: energy_export; Type: TABLE; Schema: edata; Owner: -
--

CREATE TABLE "edata"."energy_export" (
    "timestamp" timestamp without time zone NOT NULL,
    "unitNumber" smallint NOT NULL,
    "power" real NOT NULL,
    "serialNumber" bigint NOT NULL
);


--
-- Name: energy_export_serialNumber_seq; Type: SEQUENCE; Schema: edata; Owner: -
--

CREATE SEQUENCE "edata"."energy_export_serialNumber_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: energy_export_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: edata; Owner: -
--

ALTER SEQUENCE "edata"."energy_export_serialNumber_seq" OWNED BY "edata"."energy_export"."serialNumber";


--
-- Name: energy_import; Type: TABLE; Schema: edata; Owner: -
--

CREATE TABLE "edata"."energy_import" (
    "timestamp" timestamp without time zone NOT NULL,
    "unitNumber" smallint NOT NULL,
    "power" real NOT NULL,
    "serialNumber" bigint NOT NULL
);


--
-- Name: energy_import_serialNumber_seq; Type: SEQUENCE; Schema: edata; Owner: -
--

CREATE SEQUENCE "edata"."energy_import_serialNumber_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: energy_import_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: edata; Owner: -
--

ALTER SEQUENCE "edata"."energy_import_serialNumber_seq" OWNED BY "edata"."energy_import"."serialNumber";


--
-- Name: frequency; Type: TABLE; Schema: edata; Owner: -
--

CREATE TABLE "edata"."frequency" (
    "timestamp" timestamp without time zone NOT NULL,
    "frequency" real NOT NULL,
    "serialNumber" bigint NOT NULL
);


--
-- Name: frequency_serialNumber_seq; Type: SEQUENCE; Schema: edata; Owner: -
--

CREATE SEQUENCE "edata"."frequency_serialNumber_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: frequency_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: edata; Owner: -
--

ALTER SEQUENCE "edata"."frequency_serialNumber_seq" OWNED BY "edata"."frequency"."serialNumber";


--
-- Name: plants_centre; Type: TABLE; Schema: edata; Owner: -
--

CREATE TABLE "edata"."plants_centre" (
    "timestamp" timestamp without time zone NOT NULL,
    "unitNumber" smallint NOT NULL,
    "power" real NOT NULL,
    "serialNumber" bigint NOT NULL
);


--
-- Name: plants_centre_serialNumber_seq; Type: SEQUENCE; Schema: edata; Owner: -
--

CREATE SEQUENCE "edata"."plants_centre_serialNumber_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plants_centre_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: edata; Owner: -
--

ALTER SEQUENCE "edata"."plants_centre_serialNumber_seq" OWNED BY "edata"."plants_centre"."serialNumber";


--
-- Name: plants_state; Type: TABLE; Schema: edata; Owner: -
--

CREATE TABLE "edata"."plants_state" (
    "timestamp" timestamp without time zone NOT NULL,
    "unitNumber" smallint NOT NULL,
    "power" real NOT NULL,
    "serialNumber" bigint NOT NULL
);


--
-- Name: plants_state_serialNumber_seq; Type: SEQUENCE; Schema: edata; Owner: -
--

CREATE SEQUENCE "edata"."plants_state_serialNumber_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plants_state_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: edata; Owner: -
--

ALTER SEQUENCE "edata"."plants_state_serialNumber_seq" OWNED BY "edata"."plants_state"."serialNumber";


--
-- Name: states; Type: TABLE; Schema: edata; Owner: -
--

CREATE TABLE "edata"."states" (
    "timestamp" timestamp without time zone NOT NULL,
    "unitNumber" smallint NOT NULL,
    "power" real NOT NULL,
    "serialNumber" bigint NOT NULL
);


--
-- Name: states_serialNumber_seq; Type: SEQUENCE; Schema: edata; Owner: -
--

CREATE SEQUENCE "edata"."states_serialNumber_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: states_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: edata; Owner: -
--

ALTER SEQUENCE "edata"."states_serialNumber_seq" OWNED BY "edata"."states"."serialNumber";


--
-- Name: substations; Type: TABLE; Schema: edata; Owner: -
--

CREATE TABLE "edata"."substations" (
    "timestamp" timestamp without time zone NOT NULL,
    "unitNumber" smallint NOT NULL,
    "power" real NOT NULL,
    "serialNumber" bigint NOT NULL
);


--
-- Name: substations_serialNumber_seq; Type: SEQUENCE; Schema: edata; Owner: -
--

CREATE SEQUENCE "edata"."substations_serialNumber_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: substations_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: edata; Owner: -
--

ALTER SEQUENCE "edata"."substations_serialNumber_seq" OWNED BY "edata"."substations"."serialNumber";


--
-- Name: discoms; Type: TABLE; Schema: metadata; Owner: -
--

CREATE TABLE "metadata"."discoms" (
    "serialNumber" integer NOT NULL,
    "utilityName" character varying NOT NULL,
    "abbreviation" character varying(8) NOT NULL
);


--
-- Name: discoms_serialNumber_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE "metadata"."discoms_serialNumber_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: discoms_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: metadata; Owner: -
--

ALTER SEQUENCE "metadata"."discoms_serialNumber_seq" OWNED BY "metadata"."discoms"."serialNumber";


--
-- Name: energy_export; Type: TABLE; Schema: metadata; Owner: -
--

CREATE TABLE "metadata"."energy_export" (
    "serialNumber" integer NOT NULL,
    "transformerName" character varying NOT NULL
);


--
-- Name: energy_export_serialNumber_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE "metadata"."energy_export_serialNumber_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: energy_export_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: metadata; Owner: -
--

ALTER SEQUENCE "metadata"."energy_export_serialNumber_seq" OWNED BY "metadata"."energy_export"."serialNumber";


--
-- Name: energy_import; Type: TABLE; Schema: metadata; Owner: -
--

CREATE TABLE "metadata"."energy_import" (
    "serialNumber" integer NOT NULL,
    "feederName" character varying NOT NULL
);


--
-- Name: energy_import_serialNumber_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE "metadata"."energy_import_serialNumber_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: energy_import_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: metadata; Owner: -
--

ALTER SEQUENCE "metadata"."energy_import_serialNumber_seq" OWNED BY "metadata"."energy_import"."serialNumber";


--
-- Name: plants_centre; Type: TABLE; Schema: metadata; Owner: -
--

CREATE TABLE "metadata"."plants_centre" (
    "serialNumber" integer NOT NULL,
    "plantName" character varying NOT NULL,
    "fuel" character varying NOT NULL,
    "town_district" character varying NOT NULL,
    "stateName" character varying NOT NULL,
    "utilityName_EG" character varying NOT NULL,
    "utilityName_fuel" character varying NOT NULL,
    "water" character varying NOT NULL
);


--
-- Name: plants_centre_serialNumber_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE "metadata"."plants_centre_serialNumber_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plants_centre_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: metadata; Owner: -
--

ALTER SEQUENCE "metadata"."plants_centre_serialNumber_seq" OWNED BY "metadata"."plants_centre"."serialNumber";


--
-- Name: plants_state; Type: TABLE; Schema: metadata; Owner: -
--

CREATE TABLE "metadata"."plants_state" (
    "serialNumber" integer NOT NULL,
    "plantName" character varying NOT NULL
);


--
-- Name: plants_state_serialNumber_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE "metadata"."plants_state_serialNumber_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: plants_state_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: metadata; Owner: -
--

ALTER SEQUENCE "metadata"."plants_state_serialNumber_seq" OWNED BY "metadata"."plants_state"."serialNumber";


--
-- Name: states; Type: TABLE; Schema: metadata; Owner: -
--

CREATE TABLE "metadata"."states" (
    "serialNumber" integer NOT NULL,
    "stateName" character varying NOT NULL,
    "stateCode" character varying(2) NOT NULL
);


--
-- Name: states_serialNumber_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE "metadata"."states_serialNumber_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: states_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: metadata; Owner: -
--

ALTER SEQUENCE "metadata"."states_serialNumber_seq" OWNED BY "metadata"."states"."serialNumber";


--
-- Name: substations; Type: TABLE; Schema: metadata; Owner: -
--

CREATE TABLE "metadata"."substations" (
    "serialNumber" integer NOT NULL,
    "substationName" character varying NOT NULL,
    "latitude" double precision,
    "longitude" double precision
);


--
-- Name: substations_serialNumber_seq; Type: SEQUENCE; Schema: metadata; Owner: -
--

CREATE SEQUENCE "metadata"."substations_serialNumber_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: substations_serialNumber_seq; Type: SEQUENCE OWNED BY; Schema: metadata; Owner: -
--

ALTER SEQUENCE "metadata"."substations_serialNumber_seq" OWNED BY "metadata"."substations"."serialNumber";


--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."flyway_schema_history" (
    "installed_rank" integer NOT NULL,
    "version" character varying(50),
    "description" character varying(200) NOT NULL,
    "type" character varying(20) NOT NULL,
    "script" character varying(1000) NOT NULL,
    "checksum" integer,
    "installed_by" character varying(100) NOT NULL,
    "installed_on" timestamp without time zone DEFAULT "now"() NOT NULL,
    "execution_time" integer NOT NULL,
    "success" boolean NOT NULL
);


--
-- Name: version_schema; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "public"."version_schema" (
    "version" character varying NOT NULL,
    "updatedAt" timestamp with time zone DEFAULT "now"()
);


--
-- Name: discoms serialNumber; Type: DEFAULT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."discoms" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"edata"."discoms_serialNumber_seq"'::"regclass");


--
-- Name: energy_export serialNumber; Type: DEFAULT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."energy_export" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"edata"."energy_export_serialNumber_seq"'::"regclass");


--
-- Name: energy_import serialNumber; Type: DEFAULT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."energy_import" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"edata"."energy_import_serialNumber_seq"'::"regclass");


--
-- Name: frequency serialNumber; Type: DEFAULT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."frequency" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"edata"."frequency_serialNumber_seq"'::"regclass");


--
-- Name: plants_centre serialNumber; Type: DEFAULT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."plants_centre" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"edata"."plants_centre_serialNumber_seq"'::"regclass");


--
-- Name: plants_state serialNumber; Type: DEFAULT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."plants_state" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"edata"."plants_state_serialNumber_seq"'::"regclass");


--
-- Name: states serialNumber; Type: DEFAULT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."states" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"edata"."states_serialNumber_seq"'::"regclass");


--
-- Name: substations serialNumber; Type: DEFAULT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."substations" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"edata"."substations_serialNumber_seq"'::"regclass");


--
-- Name: discoms serialNumber; Type: DEFAULT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY "metadata"."discoms" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"metadata"."discoms_serialNumber_seq"'::"regclass");


--
-- Name: energy_export serialNumber; Type: DEFAULT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY "metadata"."energy_export" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"metadata"."energy_export_serialNumber_seq"'::"regclass");


--
-- Name: energy_import serialNumber; Type: DEFAULT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY "metadata"."energy_import" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"metadata"."energy_import_serialNumber_seq"'::"regclass");


--
-- Name: plants_centre serialNumber; Type: DEFAULT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY "metadata"."plants_centre" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"metadata"."plants_centre_serialNumber_seq"'::"regclass");


--
-- Name: plants_state serialNumber; Type: DEFAULT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY "metadata"."plants_state" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"metadata"."plants_state_serialNumber_seq"'::"regclass");


--
-- Name: states serialNumber; Type: DEFAULT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY "metadata"."states" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"metadata"."states_serialNumber_seq"'::"regclass");


--
-- Name: substations serialNumber; Type: DEFAULT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY "metadata"."substations" ALTER COLUMN "serialNumber" SET DEFAULT "nextval"('"metadata"."substations_serialNumber_seq"'::"regclass");


--
-- Name: discoms_serialNumber_seq; Type: SEQUENCE SET; Schema: edata; Owner: -
--

SELECT pg_catalog.setval('"edata"."discoms_serialNumber_seq"', 1, false);


--
-- Name: energy_export_serialNumber_seq; Type: SEQUENCE SET; Schema: edata; Owner: -
--

SELECT pg_catalog.setval('"edata"."energy_export_serialNumber_seq"', 1, false);


--
-- Name: energy_import_serialNumber_seq; Type: SEQUENCE SET; Schema: edata; Owner: -
--

SELECT pg_catalog.setval('"edata"."energy_import_serialNumber_seq"', 1, false);


--
-- Name: frequency_serialNumber_seq; Type: SEQUENCE SET; Schema: edata; Owner: -
--

SELECT pg_catalog.setval('"edata"."frequency_serialNumber_seq"', 1, false);


--
-- Name: plants_centre_serialNumber_seq; Type: SEQUENCE SET; Schema: edata; Owner: -
--

SELECT pg_catalog.setval('"edata"."plants_centre_serialNumber_seq"', 1, false);


--
-- Name: plants_state_serialNumber_seq; Type: SEQUENCE SET; Schema: edata; Owner: -
--

SELECT pg_catalog.setval('"edata"."plants_state_serialNumber_seq"', 1, false);


--
-- Name: states_serialNumber_seq; Type: SEQUENCE SET; Schema: edata; Owner: -
--

SELECT pg_catalog.setval('"edata"."states_serialNumber_seq"', 1, false);


--
-- Name: substations_serialNumber_seq; Type: SEQUENCE SET; Schema: edata; Owner: -
--

SELECT pg_catalog.setval('"edata"."substations_serialNumber_seq"', 1, false);


--
-- Name: discoms_serialNumber_seq; Type: SEQUENCE SET; Schema: metadata; Owner: -
--

SELECT pg_catalog.setval('"metadata"."discoms_serialNumber_seq"', 1, false);


--
-- Name: energy_export_serialNumber_seq; Type: SEQUENCE SET; Schema: metadata; Owner: -
--

SELECT pg_catalog.setval('"metadata"."energy_export_serialNumber_seq"', 1, false);


--
-- Name: energy_import_serialNumber_seq; Type: SEQUENCE SET; Schema: metadata; Owner: -
--

SELECT pg_catalog.setval('"metadata"."energy_import_serialNumber_seq"', 1, false);


--
-- Name: plants_centre_serialNumber_seq; Type: SEQUENCE SET; Schema: metadata; Owner: -
--

SELECT pg_catalog.setval('"metadata"."plants_centre_serialNumber_seq"', 1, false);


--
-- Name: plants_state_serialNumber_seq; Type: SEQUENCE SET; Schema: metadata; Owner: -
--

SELECT pg_catalog.setval('"metadata"."plants_state_serialNumber_seq"', 1, false);


--
-- Name: states_serialNumber_seq; Type: SEQUENCE SET; Schema: metadata; Owner: -
--

SELECT pg_catalog.setval('"metadata"."states_serialNumber_seq"', 1, false);


--
-- Name: substations_serialNumber_seq; Type: SEQUENCE SET; Schema: metadata; Owner: -
--

SELECT pg_catalog.setval('"metadata"."substations_serialNumber_seq"', 1, false);


--
-- Name: discoms discoms_pkey; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."discoms"
    ADD CONSTRAINT "discoms_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: frequency duplicate_frequency; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."frequency"
    ADD CONSTRAINT "duplicate_frequency" UNIQUE ("timestamp");


--
-- Name: energy_export energy_export_pkey; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."energy_export"
    ADD CONSTRAINT "energy_export_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: energy_import energy_import_pkey; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."energy_import"
    ADD CONSTRAINT "energy_import_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: frequency frequency_pkey; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."frequency"
    ADD CONSTRAINT "frequency_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: frequency min_frequency; Type: CHECK CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE "edata"."frequency"
    ADD CONSTRAINT "min_frequency" CHECK (("frequency" >= (45)::double precision)) NOT VALID;


--
-- Name: discoms min_power; Type: CHECK CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE "edata"."discoms"
    ADD CONSTRAINT "min_power" CHECK (("power" >= (0)::double precision)) NOT VALID;


--
-- Name: plants_centre min_power; Type: CHECK CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE "edata"."plants_centre"
    ADD CONSTRAINT "min_power" CHECK (("power" >= (0)::double precision)) NOT VALID;


--
-- Name: plants_state min_power; Type: CHECK CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE "edata"."plants_state"
    ADD CONSTRAINT "min_power" CHECK (("power" >= (0)::double precision)) NOT VALID;


--
-- Name: states min_power; Type: CHECK CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE "edata"."states"
    ADD CONSTRAINT "min_power" CHECK (("power" >= (0)::double precision)) NOT VALID;


--
-- Name: substations min_power; Type: CHECK CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE "edata"."substations"
    ADD CONSTRAINT "min_power" CHECK (("power" >= (0)::double precision)) NOT VALID;


--
-- Name: plants_centre plants_centre_pkey; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."plants_centre"
    ADD CONSTRAINT "plants_centre_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: plants_state plants_state_pkey; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."plants_state"
    ADD CONSTRAINT "plants_state_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: discoms spacetime_discoms; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."discoms"
    ADD CONSTRAINT "spacetime_discoms" UNIQUE ("timestamp", "unitNumber");


--
-- Name: energy_export spacetime_energy_export; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."energy_export"
    ADD CONSTRAINT "spacetime_energy_export" UNIQUE ("timestamp", "unitNumber");


--
-- Name: energy_import spacetime_energy_import; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."energy_import"
    ADD CONSTRAINT "spacetime_energy_import" UNIQUE ("timestamp", "unitNumber");


--
-- Name: plants_centre spacetime_plants_centre; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."plants_centre"
    ADD CONSTRAINT "spacetime_plants_centre" UNIQUE ("timestamp", "unitNumber");


--
-- Name: plants_state spacetime_plants_state; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."plants_state"
    ADD CONSTRAINT "spacetime_plants_state" UNIQUE ("timestamp", "unitNumber");


--
-- Name: states spacetime_states; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."states"
    ADD CONSTRAINT "spacetime_states" UNIQUE ("timestamp", "unitNumber");


--
-- Name: substations spacetime_substations; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."substations"
    ADD CONSTRAINT "spacetime_substations" UNIQUE ("timestamp", "unitNumber");


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."states"
    ADD CONSTRAINT "states_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: substations substations_pkey; Type: CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."substations"
    ADD CONSTRAINT "substations_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: discoms discoms_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY "metadata"."discoms"
    ADD CONSTRAINT "discoms_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: energy_export energy_export_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY "metadata"."energy_export"
    ADD CONSTRAINT "energy_export_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: energy_import energy_import_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY "metadata"."energy_import"
    ADD CONSTRAINT "energy_import_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: plants_centre plants_centre_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY "metadata"."plants_centre"
    ADD CONSTRAINT "plants_centre_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: plants_state plants_state_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY "metadata"."plants_state"
    ADD CONSTRAINT "plants_state_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: states states_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY "metadata"."states"
    ADD CONSTRAINT "states_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: substations substations_pkey; Type: CONSTRAINT; Schema: metadata; Owner: -
--

ALTER TABLE ONLY "metadata"."substations"
    ADD CONSTRAINT "substations_pkey" PRIMARY KEY ("serialNumber");


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "public"."flyway_schema_history"
    ADD CONSTRAINT "flyway_schema_history_pk" PRIMARY KEY ("installed_rank");


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "flyway_schema_history_s_idx" ON "public"."flyway_schema_history" USING "btree" ("success");


--
-- Name: states unitNumber; Type: FK CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."states"
    ADD CONSTRAINT "unitNumber" FOREIGN KEY ("unitNumber") REFERENCES "metadata"."states"("serialNumber");


--
-- Name: discoms unitNumber; Type: FK CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."discoms"
    ADD CONSTRAINT "unitNumber" FOREIGN KEY ("unitNumber") REFERENCES "metadata"."discoms"("serialNumber");


--
-- Name: plants_centre unitNumber; Type: FK CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."plants_centre"
    ADD CONSTRAINT "unitNumber" FOREIGN KEY ("unitNumber") REFERENCES "metadata"."plants_centre"("serialNumber");


--
-- Name: plants_state unitNumber; Type: FK CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."plants_state"
    ADD CONSTRAINT "unitNumber" FOREIGN KEY ("unitNumber") REFERENCES "metadata"."plants_state"("serialNumber");


--
-- Name: substations unitNumber; Type: FK CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."substations"
    ADD CONSTRAINT "unitNumber" FOREIGN KEY ("unitNumber") REFERENCES "metadata"."substations"("serialNumber");


--
-- Name: energy_import unitNumber; Type: FK CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."energy_import"
    ADD CONSTRAINT "unitNumber" FOREIGN KEY ("unitNumber") REFERENCES "metadata"."energy_import"("serialNumber");


--
-- Name: energy_export unitNumber; Type: FK CONSTRAINT; Schema: edata; Owner: -
--

ALTER TABLE ONLY "edata"."energy_export"
    ADD CONSTRAINT "unitNumber" FOREIGN KEY ("unitNumber") REFERENCES "metadata"."energy_export"("serialNumber");


--
-- PostgreSQL database dump complete
--

