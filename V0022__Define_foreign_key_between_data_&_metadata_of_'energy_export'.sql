ALTER TABLE public.energy_export
    ADD CONSTRAINT "unitNumber" FOREIGN KEY ("unitNumber")
    REFERENCES public.meta_energy_export ("serialNumber") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
