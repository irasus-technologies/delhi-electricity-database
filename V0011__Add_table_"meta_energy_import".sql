CREATE TABLE public.meta_energy_import
(
    "serialNumber" serial NOT NULL,
    "feederName" character varying NOT NULL,
    PRIMARY KEY ("serialNumber")
)
WITH (
    OIDS = FALSE
);

ALTER TABLE public.meta_energy_import
    OWNER to postgres;
