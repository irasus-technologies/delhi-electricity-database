CREATE TABLE public.meta_plants_centre
(
    "serialNumber" serial NOT NULL,
    "plantName" character varying NOT NULL,
    "fuel" character varying NOT NULL,
    "town_district" character varying NOT NULL,
    "stateName" character varying NOT NULL,
    "utilityName_EG" character varying NOT NULL,
    "utilityName_fuel" character varying NOT NULL,
    "water" character varying NOT NULL,
    PRIMARY KEY ("serialNumber")
)
WITH (
    OIDS = FALSE
);
