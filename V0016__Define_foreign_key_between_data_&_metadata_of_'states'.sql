ALTER TABLE public.states
    ADD CONSTRAINT "unitNumber" FOREIGN KEY ("unitNumber")
    REFERENCES public.meta_states ("serialNumber") MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;
