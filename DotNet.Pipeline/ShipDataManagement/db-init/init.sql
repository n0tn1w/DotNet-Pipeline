-- public.stats definition

-- Drop table

-- DROP TABLE public.stats;

CREATE TABLE public.stats (
	id int4 GENERATED ALWAYS AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 2147483647 START 1 CACHE 1 NO CYCLE) NOT NULL,
	red int4 NULL,
	blue int4 NULL,
	CONSTRAINT stats_pkey PRIMARY KEY (id)
);

insert into stats (red, blue) values(0, 0) 

