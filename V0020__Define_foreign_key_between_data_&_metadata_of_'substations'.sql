ALTER TABLE public.substations
    ADD CONSTRAINT "unitNumber" FOREIGN KEY ("unitNumber")
    REFERENCES public.meta_substations ("serialNumber") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
