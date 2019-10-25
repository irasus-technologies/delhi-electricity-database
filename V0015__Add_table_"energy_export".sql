CREATE TABLE public.energy_export
(
    "timestamp" timestamp without time zone NOT NULL,
    "unitNumber" smallint NOT NULL,
    "power" real NOT NULL,
    "serialNumber" bigserial NOT NULL,
    PRIMARY KEY ("serialNumber")
)
WITH (
    OIDS = FALSE
);

ALTER TABLE public.energy_export
    OWNER to postgres;
