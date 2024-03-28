CREATE TABLE public.meta_states
(
    "serialNumber" serial NOT NULL,
    "stateName" character varying NOT NULL,
    PRIMARY KEY ("serialNumber")
)
WITH (
    OIDS = FALSE
);
