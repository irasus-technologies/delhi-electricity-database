CREATE TABLE public.meta_energy_export
(
    "serialNumber" serial NOT NULL,
    "transformerName" character varying NOT NULL,
    PRIMARY KEY ("serialNumber")
)
WITH (
    OIDS = FALSE
);
