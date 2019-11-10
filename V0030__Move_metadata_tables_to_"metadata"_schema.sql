ALTER TABLE public.meta_discoms
    SET SCHEMA metadata;

ALTER TABLE metadata.meta_discoms
    RENAME TO discoms;

ALTER TABLE metadata.discoms
    RENAME CONSTRAINT meta_discoms_pkey TO discoms_pkey;

ALTER SEQUENCE metadata."meta_discoms_serialNumber_seq"
    RENAME TO "discoms_serialNumber_seq";

ALTER TABLE public.meta_energy_export
    SET SCHEMA metadata;

ALTER TABLE metadata.meta_energy_export
    RENAME TO energy_export;

ALTER TABLE metadata.energy_export
    RENAME CONSTRAINT meta_energy_export_pkey TO energy_export_pkey;

ALTER SEQUENCE metadata."meta_energy_export_serialNumber_seq"
    RENAME TO "energy_export_serialNumber_seq";

ALTER TABLE public.meta_energy_import
    SET SCHEMA metadata;

ALTER TABLE metadata.meta_energy_import
    RENAME TO energy_import;

ALTER TABLE metadata.energy_import
    RENAME CONSTRAINT meta_energy_import_pkey TO energy_import_pkey;

ALTER SEQUENCE metadata."meta_energy_import_serialNumber_seq"
    RENAME TO "energy_import_serialNumber_seq";

ALTER TABLE public.meta_plants_centre
    SET SCHEMA metadata;

ALTER TABLE metadata.meta_plants_centre
    RENAME TO plants_centre;

ALTER TABLE metadata.plants_centre
    RENAME CONSTRAINT meta_plants_centre_pkey TO plants_centre_pkey;

ALTER SEQUENCE metadata."meta_plants_centre_serialNumber_seq"
    RENAME TO "plants_centre_serialNumber_seq";

ALTER TABLE public.meta_plants_state
    SET SCHEMA metadata;

ALTER TABLE metadata.meta_plants_state
    RENAME TO plants_state;

ALTER TABLE metadata.plants_state
    RENAME CONSTRAINT meta_plants_state_pkey TO plants_state_pkey;

ALTER SEQUENCE metadata."meta_plants_state_serialNumber_seq"
    RENAME TO "plants_state_serialNumber_seq";

ALTER TABLE public.meta_states
    SET SCHEMA metadata;

ALTER TABLE metadata.meta_states
    RENAME TO states;

ALTER TABLE metadata.states
    RENAME CONSTRAINT meta_states_pkey TO states_pkey;

ALTER SEQUENCE metadata."meta_states_serialNumber_seq"
    RENAME TO "states_serialNumber_seq";

ALTER TABLE public.meta_substations
    SET SCHEMA metadata;

ALTER TABLE metadata.meta_substations
    RENAME TO substations;

ALTER TABLE metadata.substations
    RENAME CONSTRAINT meta_substations_pkey TO substations_pkey;

ALTER SEQUENCE metadata."meta_substations_serialNumber_seq"
    RENAME TO "substations_serialNumber_seq";
