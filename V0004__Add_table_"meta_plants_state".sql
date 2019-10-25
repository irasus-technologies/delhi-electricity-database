CREATE TABLE public.meta_plants_state
(
    "serialNumber" serial NOT NULL,
    "plantName" character varying NOT NULL,
    PRIMARY KEY ("serialNumber")
)
WITH (
    OIDS = FALSE
);

ALTER TABLE public.meta_plants_state
    OWNER to postgres;
