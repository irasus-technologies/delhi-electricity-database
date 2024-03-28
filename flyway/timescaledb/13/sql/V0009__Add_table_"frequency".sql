CREATE TABLE public.frequency
(
    "timestamp" timestamp without time zone NOT NULL,
    frequency real NOT NULL,
    "serialNumber" bigserial NOT NULL,
    PRIMARY KEY ("serialNumber")
)
WITH (
    OIDS = FALSE
);
