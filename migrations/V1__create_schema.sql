CREATE SCHEMA IF NOT EXISTS bh;


CREATE TABLE bh.ped(
  id_ped bigserial NOT NULL,
  linha varchar(200) NULL,
  sentido int NULL,
  sequencia int NULL,
  localizacao geometry NOT NULL,
  CONSTRAINT ped_pk PRIMARY KEY (id_ped)
);
