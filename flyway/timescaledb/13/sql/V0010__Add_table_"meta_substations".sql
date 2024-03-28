CREATE TABLE public.meta_substations
(
    "serialNumber" serial NOT NULL,
    "substationName" character varying NOT NULL,
    PRIMARY KEY ("serialNumber")
)
WITH (
    OIDS = FALSE
);
