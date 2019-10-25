ALTER TABLE public.plants_centre
    ADD CONSTRAINT "unitNumber" FOREIGN KEY ("unitNumber")
    REFERENCES public.meta_plants_centre ("serialNumber") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
