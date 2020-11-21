DROP TABLE IF EXISTS department CASCADE;
DROP TABLE IF EXISTS employee CASCADE;
DROP TABLE IF EXISTS medicament CASCADE;
DROP TABLE IF EXISTS empmed CASCADE;

CREATE TABLE IF NOT EXISTS department
(
	id SERIAL NOT NULL PRIMARY KEY,
	description CHARACTER VARYING(64) NOT NULL,
	phone CHARACTER VARYING(11) NOT NULL,
	id_manager int not null
);
insert into departments values(1, "ИУ1", "89271939171", 1);
insert into departments values(2, "ИУ2", "89271939172", 2);
insert into departments values(3, "ИУ3", "89271939173", 3);
insert into departments values(4, "ИУ4", "89271939174", 4);
insert into departments values(5, "ИУ5", "89271939175", 5);
insert into departments values(6, "ИУ6", "89271939176", 6);
insert into departments values(7, "ИУ7", "89271939177", 7);
insert into departments values(8, "ИУ8", "89271939178", 8);
insert into departments values(9, "ИУ9", "89271939179", 9);
insert into departments values(10, "ИУ10", "89271939110", 10);

CREATE TABLE IF NOT EXISTS employee
(
	id SERIAL NOT NULL PRIMARY KEY,
	post CHARACTER VARYING(64) NOT NULL,
	person_name CHARACTER VARYING(64) NOT NULL,
	id_department int not null,
	wages int not null
);

insert into employee values(1, "Заведующий", "Петров", 1, 100);
insert into employee values(2, "Заведующий", "Петров", 1, 200);
insert into employee values(3, "Заведующий", "Петров", 1, 300);
insert into employee values(4, "Заведующий", "Петров", 1, 1400);
insert into employee values(5, "Заведующий", "Петров", 1, 100);
insert into employee values(6, "Заведующий", "Петров", 1, 100);
insert into employee values(7, "Заведующий", "Петров", 1, 100);
insert into employee values(8, "Заведующий", "Петров", 1, 100);
insert into employee values(9, "Заведующий", "Петров", 1, 100);
insert into employee values(10, "Заведующий", "Петров", 1, 100);
insert into employee values(1, "Заведующий", "Петров", 1, 100);

ALTER TABLE employee ADD CONSTRAINT fk_id_department
                  FOREIGN KEY (id_department) 
                  REFERENCES department(id);
				  
ALTER TABLE department ADD CONSTRAINT fk_id_manager
                  FOREIGN KEY (id_manager) 
                  REFERENCES employee(id);
				  
CREATE TABLE IF NOT EXISTS medicament
(
	id SERIAL NOT NULL PRIMARY KEY,
	medicament_name CHARACTER VARYING(64) NOT NULL,
	description CHARACTER VARYING(64) NOT NULL,
	wages int not null
);

CREATE TABLE IF NOT EXISTS empmed
(
	id_emp INT NOT NULL REFERENCES employee(id),
	id_med INT NOT NULL REFERENCES medicament(id)
);

insert into departments()

