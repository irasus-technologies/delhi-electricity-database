CREATE TABLE public.version_schema
(
    version character varying NOT NULL,
    "updatedAt" timestamp with time zone
)
WITH (
    OIDS = FALSE
);

ALTER TABLE public.version_schema
    ALTER COLUMN "updatedAt" SET DEFAULT NOW();

INSERT INTO public.version_schema(
    version)
    VALUES ('1.0.0');
