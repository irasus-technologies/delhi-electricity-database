ALTER TABLE edata.discoms
    ADD CONSTRAINT min_power CHECK (power >= 0)
    NOT VALID;

ALTER TABLE edata.frequency
    ADD CONSTRAINT min_frequency CHECK (frequency >= 45)
    NOT VALID;

ALTER TABLE edata.plants_centre
    ADD CONSTRAINT min_power CHECK (power >= 0)
    NOT VALID;

ALTER TABLE edata.plants_state
    ADD CONSTRAINT min_power CHECK (power >= 0)
    NOT VALID;

ALTER TABLE edata.states
    ADD CONSTRAINT min_power CHECK (power >= 0)
    NOT VALID;

ALTER TABLE edata.substations
    ADD CONSTRAINT min_power CHECK (power >= 0)
    NOT VALID;
