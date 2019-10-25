ALTER TABLE public.energy_import
    ADD CONSTRAINT "unitNumber" FOREIGN KEY ("unitNumber")
    REFERENCES public.meta_energy_import ("serialNumber") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
