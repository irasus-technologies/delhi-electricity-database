ALTER TABLE edata.discoms
    ADD CONSTRAINT spacetime_discoms UNIQUE ("timestamp", "unitNumber");

ALTER TABLE edata.energy_export
    ADD CONSTRAINT spacetime_energy_export UNIQUE ("timestamp", "unitNumber");

ALTER TABLE edata.energy_import
    ADD CONSTRAINT spacetime_energy_import UNIQUE ("timestamp", "unitNumber");

ALTER TABLE edata.frequency
    ADD CONSTRAINT duplicate_frequency UNIQUE ("timestamp");

ALTER TABLE edata.plants_centre
    ADD CONSTRAINT spacetime_plants_centre UNIQUE ("timestamp", "unitNumber");

ALTER TABLE edata.plants_state
    ADD CONSTRAINT spacetime_plants_state UNIQUE ("timestamp", "unitNumber");

ALTER TABLE edata.states
    ADD CONSTRAINT spacetime_states UNIQUE ("timestamp", "unitNumber");

ALTER TABLE edata.substations
    ADD CONSTRAINT spacetime_substations UNIQUE ("timestamp", "unitNumber");
