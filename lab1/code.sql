DROP TABLE IF EXISTS people CASCADE;
DROP TABLE IF EXISTS ts CASCADE;
DROP TABLE IF EXISTS typedtp CASCADE;
DROP TABLE IF EXISTS dtp CASCADE;
DROP TABLE IF EXISTS affecteddrivers CASCADE;
DROP TABLE IF EXISTS affectedothers CASCADE;


CREATE TABLE IF NOT EXISTS people
(
    id_person SERIAL PRIMARY KEY,
    person_name CHARACTER VARYING(64) NOT NULL,
    sex CHARACTER VARYING(3) NOT NULL,
	birthdate DATE NOT NULL,
    passport CHARACTER VARYING(10),
    drive_license CHARACTER VARYING(10)
);

;--ALTER TABLE people ADD CONSTRAINT valid_sex CHECK(sex = 'муж' or sex = 'жен');
;--INSERT INTO people VALUES (2005, 'Белозеров Валерьян Фадеевич','муж','1998-06-17','7679764144','3136461566');

CREATE TABLE IF NOT EXISTS typedtp
(
    id_typedtp SERIAL PRIMARY KEY,
	description CHARACTER VARYING(256)
);

CREATE TABLE IF NOT EXISTS ts
(
    id_ts SERIAL PRIMARY KEY,
	id_person INT NOT NULL REFERENCES people(id_person),
	type_ts CHARACTER VARYING(64) NOT NULL,
    brand CHARACTER VARYING(64),
	model CHARACTER VARYING(64),
    release_year CHARACTER VARYING(4),
    register_number CHARACTER VARYING(10),
	color CHARACTER VARYING(64)
);

CREATE TABLE IF NOT EXISTS dtp
(
    id_dtp SERIAL PRIMARY KEY,
	date_dtp DATE NOT NULL,
	time_dtp TIME NOT NULL,
    region_dtp CHARACTER VARYING(64) NOT NULL,
	city_dtp CHARACTER VARYING(64),
    type_dtp INT[] NOT NULL
);

CREATE TABLE IF NOT EXISTS affecteddrivers
(
	id_affecteddrivers SERIAL PRIMARY KEY,
    id_dtp INT NOT NULL REFERENCES dtp(id_dtp),
	id_person INT NOT NULL REFERENCES people(id_person),
	id_ts INT NOT NULL REFERENCES ts(id_ts),
    type_driver CHARACTER VARYING(30) NOT NULL,
	state_health CHARACTER VARYING(5) NOT NULL,
    guilt CHARACTER VARYING(9) NOT NULL
);

CREATE TABLE IF NOT EXISTS affectedothers
(
    id_affectedothers SERIAL PRIMARY KEY,
	id_dtp INT NOT NULL REFERENCES dtp(id_dtp),
	id_person INT NOT NULL REFERENCES people(id_person),
    type_person CHARACTER VARYING(30) NOT NULL,
	state_health CHARACTER VARYING(5) NOT NULL,
    guilt CHARACTER VARYING(9) NOT NULL
);

copy people(person_name, sex, birthdate, passport, drive_license) from 'C:\DB\lab1\people.csv' delimiter ',' csv;
copy ts(id_person, type_ts, brand, model, release_year, register_number, color) from 'C:\DB\lab1\ts.csv' delimiter ',' csv;
copy typedtp(description) from 'C:\DB\lab1\typeDTP.csv' delimiter ',' csv;
copy dtp(date_dtp, time_dtp, region_dtp, city_dtp, type_dtp) from 'C:\DB\lab1\dtp.csv' delimiter ',' csv;
copy affecteddrivers(id_dtp, id_person, id_ts, type_driver, state_health, guilt) from 'C:\DB\lab1\affectedDrivers.csv' delimiter ',' csv;
copy affectedOthers(id_dtp, id_person, type_person, state_health, guilt) from 'C:\DB\lab1\affectedOthers.csv' delimiter ',' csv;





