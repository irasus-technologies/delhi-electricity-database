ALTER TABLE public.meta_states
    ADD COLUMN "stateCode" character varying (2);
ALTER TABLE public.meta_states
    ALTER COLUMN "stateCode" SET NOT NULL;
