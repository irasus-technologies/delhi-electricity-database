CREATE TABLE public.meta_discoms
(
    "serialNumber" serial NOT NULL,
    "utilityName" character varying NOT NULL,
    PRIMARY KEY ("serialNumber")
)
WITH (
    OIDS = FALSE
);

ALTER TABLE public.meta_discoms
    OWNER to postgres;
