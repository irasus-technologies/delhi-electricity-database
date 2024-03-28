ALTER TABLE public.meta_discoms
    ADD COLUMN abbreviation character varying (8);
ALTER TABLE public.meta_discoms
    ALTER COLUMN abbreviation SET NOT NULL;
