--РК2 ВАРИАНТ 2


DROP TABLE IF EXISTS TYPEWORK CASCADE;
DROP TABLE IF EXISTS EXECUTOR CASCADE;
DROP TABLE IF EXISTS CUSTOMER CASCADE;

DROP TABLE IF EXISTS TE CASCADE;
DROP TABLE IF EXISTS TC CASCADE;
DROP TABLE IF EXISTS EC CASCADE;

CREATE TABLE IF NOT EXISTS TYPEWORK
(
	id_work SERIAL NOT NULL PRIMARY KEY,
	name_work CHARACTER VARYING(64) NOT NULL,
	labor_expenditures INT NOT NULL,
	need_equipment CHARACTER VARYING(64) NOT NULL
);

INSERT INTO TYPEWORK VALUES(1,'вырубить дерево', 10, 'топор');
INSERT INTO TYPEWORK VALUES(2,'построить дом', 40, 'кирпич');
INSERT INTO TYPEWORK VALUES(3,'подмести двор', 20, 'метла');
INSERT INTO TYPEWORK VALUES(4,'помыть полы', 10, 'тряпка');
INSERT INTO TYPEWORK VALUES(5,'помыть посуду', 40, 'средство');
INSERT INTO TYPEWORK VALUES(6,'покрасить забор', 50, 'кисть');
INSERT INTO TYPEWORK VALUES(8,'покрасить дом', 10, 'кисть');
INSERT INTO TYPEWORK VALUES(9,'построить сарай', 40, 'кирпич');
INSERT INTO TYPEWORK VALUES(10,'побелить потолок', 20, 'кисть');
INSERT INTO TYPEWORK VALUES(11,'помыть полы', 20, 'тряпка');
INSERT INTO TYPEWORK VALUES(12,'помыть посуду', 30, 'средство');
INSERT INTO TYPEWORK VALUES(13,'вырубить дерево', 50, 'топор');

CREATE TABLE IF NOT EXISTS EXECUTOR
(
	id_executor SERIAL NOT NULL PRIMARY KEY,
	name_executor CHARACTER VARYING(64) NOT NULL,
	birthdate INT NOT NULL,
	experience INT NOT NULL,
	phone CHARACTER VARYING(11) NOT NULL
);

INSERT INTO EXECUTOR VALUES(1,'Петров Алексей Борисович', 1970, 10, '89271939100');
INSERT INTO EXECUTOR VALUES(2,'Иванов Андрей Викторович', 1971, 9, '89271939101');
INSERT INTO EXECUTOR VALUES(3,'Сидоров Геннадий Аристархович', 1972, 8, '89271939102');
INSERT INTO EXECUTOR VALUES(4,'Гарасев Никита Алексеевич', 1973, 7, '89271939103');
INSERT INTO EXECUTOR VALUES(5,'Петров Владлен Мирославович', 1974, 5, '89271939104');
INSERT INTO EXECUTOR VALUES(6,'Шукшин Анатолий Викторович', 1975, 3, '89271939105');
INSERT INTO EXECUTOR VALUES(7,'Лучников Дмитрий Геннадьевич', 1976, 10, '89271939106');
INSERT INTO EXECUTOR VALUES(8,'Картоган Виктор Павлович', 1977, 11, '89271939107');
INSERT INTO EXECUTOR VALUES(9,'Слесарев Аристарх Иларионович', 1978, 10, '89271939108');
INSERT INTO EXECUTOR VALUES(10,'Писарев Дмитрий Макарович', 1979, 8, '89271939109');
INSERT INTO EXECUTOR VALUES(11,'Водочкин Олег Иванович', 1980, 11, '89271939110');


CREATE TABLE IF NOT EXISTS CUSTOMER
(
	id_customer SERIAL NOT NULL PRIMARY KEY,
	name_customer CHARACTER VARYING(64) NOT NULL,
	birthdate INT NOT NULL,
	experience INT NOT NULL,
	phone CHARACTER VARYING(11) NOT NULL
);

INSERT INTO CUSTOMER VALUES(1,'Коннов Алексей Борисович', 1970, 10, '89271939200');
INSERT INTO CUSTOMER VALUES(2,'Белоусов Андрей Викторович', 1971, 9, '89271939201');
INSERT INTO CUSTOMER VALUES(3,'Рудаков Геннадий Аристархович', 1972, 8, '89271939202');
INSERT INTO CUSTOMER VALUES(4,'Чалый Никита Алексеевич', 1975, 7, '89271939203');
INSERT INTO CUSTOMER VALUES(5,'Дурачков Владлен Мирославович', 1974, 5, '89271939204');
INSERT INTO CUSTOMER VALUES(6,'Лазарев Анатолий Викторович', 1975, 3, '89271939205');
INSERT INTO CUSTOMER VALUES(7,'Леонов Дмитрий Геннадьевич', 1975, 10, '89271939206');
INSERT INTO CUSTOMER VALUES(8,'Пирожков Виктор Павлович', 1977, 11, '89271939207');
INSERT INTO CUSTOMER VALUES(9,'Дипломкин Аристарх Иларионович', 1978, 10, '89271939208');
INSERT INTO CUSTOMER VALUES(10,'Вахабов Дмитрий Макарович', 1979, 8, '89271939209');
INSERT INTO CUSTOMER VALUES(11,'Ролькин Олег Иванович', 1980, 11, '89271939210');


CREATE TABLE IF NOT EXISTS TC
(
	id_t INT NOT NULL REFERENCES TYPEWORK(id_work),
	id_c INT NOT NULL REFERENCES CUSTOMER(id_customer)
);

INSERT INTO TC VALUES(1,1);
INSERT INTO TC VALUES(1,2);
INSERT INTO TC VALUES(3,1);
INSERT INTO TC VALUES(4,5);
INSERT INTO TC VALUES(3,2);
INSERT INTO TC VALUES(1,2);
INSERT INTO TC VALUES(1,6);

INSERT INTO TC VALUES(2,1);
INSERT INTO TC VALUES(3,1);
INSERT INTO TC VALUES(1,5);

INSERT INTO TC VALUES(3,4);
INSERT INTO TC VALUES(3,5);
INSERT INTO TC VALUES(5,1);

INSERT INTO TC VALUES(2,8);
INSERT INTO TC VALUES(1,4);
INSERT INTO TC VALUES(3,7);

CREATE TABLE IF NOT EXISTS TE
(
	id_t INT NOT NULL REFERENCES TYPEWORK(id_work),
	id_e INT NOT NULL REFERENCES EXECUTOR(id_executor)
);

INSERT INTO TE VALUES(1,1);
INSERT INTO TE VALUES(1,2);
INSERT INTO TE VALUES(3,1);
INSERT INTO TE VALUES(4,5);
INSERT INTO TE VALUES(3,2);
INSERT INTO TE VALUES(1,2);
INSERT INTO TE VALUES(1,6);
INSERT INTO TE VALUES(2,1);
INSERT INTO TE VALUES(3,1);
INSERT INTO TE VALUES(1,5);

CREATE TABLE IF NOT EXISTS EC
(
	id_e INT NOT NULL REFERENCES EXECUTOR(id_executor),
	id_c INT NOT NULL REFERENCES CUSTOMER(id_customer)
);

INSERT INTO EC VALUES(1,1);
INSERT INTO EC VALUES(1,2);
INSERT INTO EC VALUES(3,1);
INSERT INTO EC VALUES(4,5);
INSERT INTO EC VALUES(3,2);
INSERT INTO EC VALUES(1,2);
INSERT INTO EC VALUES(1,6);
INSERT INTO EC VALUES(2,1);
INSERT INTO EC VALUES(3,1);
INSERT INTO EC VALUES(1,5);


-- 1. Предикат сравнения
-- Получить список исполнителей у которых стаж равен 10 и отсортировать по дате рождения
select *
from customer
where experience = 10
order by birthdate

-- 2. Использующую оконную функцию
-- Для каждой заданной групп видов работы вывести минимальные трудозатраты

select name_work, labor_expenditures, min(labor_expenditures) over (partition by name_work)
from typework

-- 3. коррелированный подзапров в from
-- Вывести работу, имена испольнителей(и стаж), которые занимаются ею со стажем больше 5 лет

select name_work, name_customer, experience
from typework join (
	select *
	from customer join tc on id_customer = id_c
	where experience > 5
) as customer_five_experience on typework.id_work = customer_five_experience.id_t 


--3 задание
select indexname from pg_indexes;
create or replace procedure index_info(tb_name varchar(64)) as
$$
	declare 
		cur cursor
		for select indexname from pg_indexes where tablename = $1;
		row record;
	begin
		open cur;
		loop 
			fetch cur into row;
			exit when not found;
			raise notice '{indexname: %}', row.indexname;
		end loop;
		close cur;
	end;
$$ language 'plpgsql';

call index_info('customer');

call index_info('typework');