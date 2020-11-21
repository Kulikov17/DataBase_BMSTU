--1. Получить количество аварии с участием гужевого транспорта за определенный период
--1. скалярная функции
CREATE OR REPLACE FUNCTION countDtpСartage(from_date date, to_date date)
RETURNS bigint AS $$
begin
	return(
   		SELECT count(*) 
		from ts join 
		(
			dtp join affecteddrivers 
			on dtp.id_dtp = affecteddrivers.id_dtp
		) as dtp_drivers on dtp_drivers.id_ts = ts.id_ts
		WHERE type_ts = 'гужевой транспорт' and date_dtp BETWEEN $1 AND $2
	);
end;
$$ 
LANGUAGE 'plpgsql';

select countDtpСartage('2018-01-01', '2018-12-31');


--2. Получить дтп по региону
CREATE OR REPLACE FUNCTION getDtpByRegion(CHARACTER VARYING(64))
RETURNS SETOF dtp AS $$
begin
	return query(
   		SELECT * 
		from dtp
		WHERE region_dtp = $1
	);
end;
$$ 
LANGUAGE 'plpgsql';

select * from getDtpByRegion('Республика Мордовия');

-- то же самое но с названиями столбцов

CREATE OR REPLACE function getTableDtpByRegion(CHARACTER VARYING(64))
returns table (
	Iddtp INT,
	Datedtp DATE,
	Timedtp TIME,
    Region CHARACTER VARYING(64),
	City CHARACTER VARYING(64),
    Type_dtp INT[]
	)
    as $$
    begin
    	return query(
   		SELECT * 
		from dtp
		WHERE dtp.region_dtp = $1
	);
    end;
$$
language 'plpgsql';

select * from getTableDtpByRegion('Республика Мордовия');

-- 3.создание многооператорной функции получения поездов
CREATE OR REPLACE function getTrains()
returns setof ts
as $$
    declare
        typeTS CHARACTER VARYING(64);
    begin
     typeTS := 'поезд';
    return query (
		select *
            from ts
            where type_ts = typeTS
	);
    end
    $$ language 'plpgsql';

select * from getTrains();


-- 4. Рекурсивный вывод людей
CREATE OR REPLACE function recOutputPeople(int)
returns setof people
as $$
	begin
    return query (
		select *
    	from people
        where id_person = $1 
	);
    if ($1 > 0) then
        return query
        select *
        from recOutputPeople($1 - 1);
    end if;
    end;
    $$ language 'plpgsql';

select * from recOutputPeople(13);


--5. Хранимая процедура обновить ФИО человека с таким то id 

INSERT INTO people VALUES (2280, 'Крид Егор Витальевич','муж','1997-01-01','2222222222','3333333333');
INSERT INTO people VALUES (2281, 'Дурачкова Иона Зульхаровна','жен','1997-01-01','3333333333','2222222222');
INSERT INTO people VALUES (2282, 'Дурачков Платон Вольфович','муж','2001-01-01','4444444444','NULL');

CREATE OR REPLACE function updatePersonName(pid integer, pname CHARACTER VARYING(64)) returns void
as $$
    begin
    update people
    set person_name = pname
    where id_person = pid;
    end;
    $$ language 'plpgsql';

select * from updatePersonName(2280, 'Дурачков Иларион Векторович');

--6. Рекурсивную хранимую процедура изменить пол мужской на женский начиная с такого то id и до конца

create or replace function recUpdatePeopleSexBeginId(pid integer) returns void
as $$
    begin
    update people
    set sex = 'жен'
    where id_person = pid;
    if (pid<2282) then
         perform * from recUpdatePeopleSexBeginId(pid+1);
    end if;
    end;
    $$ language 'plpgsql';

select * from recUpdatePeopleSexBeginId(2280);


--7. Хранимую процедура с курсором изменить пол женский на мужской где id принадлежит [start_id; end_id]
create or replace function update_people_cursor(spid integer, epid integer) returns void
as $$
    declare
        row record;
        cur cursor for
        select * from people
        where id_person >= spid and id_person <= epid;
    begin
        open cur;
        loop
		    fetch cur into row;
		    exit when not found;
		    update people p
            set sex = 'муж'
            where p.id_person = row.id_person;
		end loop;
        close cur;
    end;
    $$ language 'plpgsql';

select * from update_people_cursor(2280, 2282)


SELECT datname FROM pg_database WHERE datistemplate = false and datname = 'medicine';
SELECT * FROM pg_indexes WHERE tablename = 'ts';

for SELECT * FROM pg_indexes WHERE tablename = $1;

create or replace procedure index_info(tb_name varchar(64)) as
$$
declare
	cur cursor
	for SELECT * FROM pg_indexes WHERE tablename = $1;
	row record;
begin
        open cur;
        loop
		    fetch cur into row;
		    exit when not found;
			raise notice '{func_name : %}', row.indexname;
		end loop;
        close cur;
    end;
    $$ language 'plpgsql';

call index_info('dtp');

for SELECT * FROM pg_indexes WHERE tablename = $1;

create or replace procedure table_size() as
$$
declare
	cur cursor
	for 
	SELECT table_name, pg_relation_size(cast(table_name as varchar)) as size FROM information_schema.tables
	WHERE table_schema NOT IN ('information_schema','pg_catalog');
	row record;
begin
        open cur;
        loop
		    fetch cur into row;
		    exit when not found;
			raise notice '{tab_name: %}{size: %}', row.table_name, row.size;
		end loop;
        close cur;
    end;
    $$ language 'plpgsql';

call table_size();

CREATE TRIGGER ChangeTypeDTP
INSTEAD OF INSERT ON typedtp
as 
begin
 raise notice 'Cant change';
end

insert into type_dtp (id_typedtp, description)
values(30, 'sasaas');
