--1. Получить владельца транспортного средства
create or replace function ownerTs(id_ts int) returns varchar
as $$
ppl = plpy.execute("select id_ts, person_name from ts join people on ts.id_person = people.id_person")
for row in ppl:
	if row['id_ts'] == id_ts:
		return row['person_name']
return 'None such ts'
$$ language plpython3u;

select * from ownerTs(1);

--2. Получить количество тс определенного типа
create or replace function countTypeTs(type_ts varchar) returns int
as $$
ppl = plpy.execute("select * from ts")
count = 0
for ts in ppl:
	if ts['type_ts'] == type_ts:
		count += 1
return count
$$ language plpython3u;

select * from countTypeTs('поезд');

-- 3.Возвращает все дтп произошедшие в регионе за определенный период
create or replace function getDtpRegionByDate (region_dtp varchar, from_date_dtp varchar, to_date_dtp varchar) 
returns table (	id_dtp int, date_dtp varchar, time_dtp varchar, region_dtp varchar, city_dtp varchar, type_dtp varchar)
as $$
ppl = plpy.execute("select * from dtp")
res = []
for row in ppl:
	if row['region_dtp'] == region_dtp and row['date_dtp'] >= from_date_dtp and row['date_dtp'] <= to_date_dtp :
		res.append(row)
return res
$$ language plpython3u;

select * from getDtpRegionByDate('Республика Мордовия', '2018-01-01', '2018-12-31');


-- 4. Добавляет нового человека в базу

create or replace procedure addPerson(id int, name varchar, sex varchar, birthdate date, passport varchar, drive_license varchar) as
$$
row = plpy.prepare("insert into people(id_person, person_name, sex, birthdate, passport, drive_license) values($1, $2, $3, $4, $5, $6)", ["int", "varchar", "varchar", "date", "varchar", "varchar"])
plpy.execute(row, [id, name, sex, birthdate, passport, drive_license])
$$ language plpython3u;

call addPerson(6000, 'Куликов Дмитрий Алексеевич', 'муж', '2001-02-08', 'NULL', 'NULL');

select * from people where id_person = 6000


--5. Нельзя удалить и обновить данные у типов дтп
create or replace function funcDisableDeleteUpdateToTypedtpView() returns trigger
as $$
	if TD["event"] == "DELETE":
	    return "SKIP"
	elif TD["event"] == "UPDATE":
		return "SKIP"
$$ language plpython3u;

CREATE TRIGGER disableDeleteUpdateTypedtpView
INSTEAD OF delete or update ON typedtp_view
FOR EACH ROW
EXECUTE PROCEDURE funcDisableDeleteUpdateToTypedtpView();


DELETE from typedtp_view
WHERE id_typedtp = 1;

UPDATE typedtp_view
SET description = 'чушь'
WHERE id_typedtp = 1;



--6.
-- тип параметров дтп, включающий в себя
create type dtpDateRegion as (
  id_dtp int,
  date_dtp date,
  region_dtp varchar
);

-- Вывод дтп по типу Data-Region

create or replace function getDtpOnTypeDataRegion() returns setof dtpDateRegion 
as $$
tmp = plpy.prepare("select id_dtp, date_dtp, region_dtp from dtp")
cr = plpy.execute(tmp)
return cr
$$ language plpython3u;

select * from getDtpOnTypeDataRegion();