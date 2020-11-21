-- 1.Получить список женщин отсортированных по имени
-- 1.Предикат сравнения
SELECT *
FROM people
WHERE sex = 'жен'
ORDER BY person_name

-- 2.Получить список дтп, произошедших между '2018-02-01' и '2018-02-28'
-- 2. between 
SELECT *
FROM dtp
WHERE date_dtp BETWEEN '2018-02-01' AND '2018-02-28'

-- 3.Получить список дтп в название региона которых присутствует слово 'Республика'
SELECT *
FROM dtp 
WHERE region_dtp LIKE '%Республика%'

--Инструкция SELECT, использующая предикат IN с вложенным подзапросом.
-- 4.Получить список ТС являющиеся автомобилем АУДИ, владельцем который является мужчина
SELECT id_ts, id_person, brand
FROM ts
WHERE id_ts IN
(
 SELECT ts.id_ts
 FROM people join ts on ts.id_person = people.id_person
 WHERE sex = 'муж' AND brand = 'Audi'
)

-- 5.Получить список людей, которые никто никогда не попадали в аварию водителями
SELECT id_person, person_name
FROM people
WHERE not EXISTS
(
 SELECT *	
 FROM affecteddrivers
 where  people.id_person = affecteddrivers.id_person
)

-- Инструкция SELECT, использующая предикат сравнения с квантором.
-- 6. Получить список легковых машин, год выпуска которых новее любого года выпуска брэнда Audi
SELECT id_ts, type_ts, brand, release_year
FROM ts
WHERE release_year > ALL
(
  SELECT release_year
  FROM ts
  WHERE ts.brand = 'Audi'
) AND ts.type_ts = 'легковой автомобиль'

-- Инструкция SELECT, использующая агрегатные функции в выражениях столбцов.
-- 7. Получить средний год выпуска легковых машин
SELECT SUM(year) / COUNT(*) AS avg_year
FROM(
	SELECT cast(ts.release_year as int4) as year
	from ts
	where ts.type_ts = 'легковой автомобиль'
) as TotTS

-- 8. Получить максимальный, минимальный, средний год выпуска легковых машин
SELECT MIN(year) as min_year, MAX(year) as max_year, AVG(year) as avg_year
FROM(
	SELECT cast(ts.release_year as int4) as year
	from ts
	where ts.type_ts = 'легковой автомобиль'
) as TotTS 

-- 9. Получить список у кого нет прав
SELECT id_person, person_name,
CASE drive_license
WHEN 'NULL' THEN 'Прав нет'
ELSE  'Права есть'
END AS driveLicense
FROM people

-- 10. Получить список людей кому больше 18
SELECT id_person, birthdate,
CASE WHEN DATE_PART('year', current_date) - DATE_PART('year', birthdate) > 18 THEN 'Больше'
ELSE  'Меньше'
END AS more18
FROM people

-- 11. Создание локальный таблицы
SELECT id_person, sex
INTO temp 
FROM people
where passport = 'NULL'

-- 12. Полуть список имен водителей попавших в ДТП в Республике Мордовия 
select people.id_person, people.person_name, dtp_drivers.region_dtp, dtp_drivers.city_dtp
from people join 
(
	dtp join affecteddrivers 
	on dtp.id_dtp = affecteddrivers.id_dtp
) as dtp_drivers on dtp_drivers.id_person = people.id_person
where region_dtp = 'Республика Мордовия'
order by id_person


-- 13. Получить информацию об аварии самых старых водителей

select *
from dtp join (
    select *
    from people join affecteddrivers on people.id_person = affecteddrivers.id_person
    where birthdate = (
        select min(birthdate)
		from people join affecteddrivers on people.id_person = affecteddrivers.id_person
    )
) as p on dtp.id_dtp = p.id_dtp

-- 14. Вывести даты в которых произошло дтп
SELECT date_dtp
FROM dtp
GROUP BY date_dtp
Order by date_dtp


-- 15. Вывести даты в которых произошло дтп больше чем 3
SELECT date_dtp, COUNT(*)
FROM dtp
GROUP BY date_dtp
HAVING COUNT(*) > 3
Order by date_dtp


-- 16. Вставка человека
INSERT INTO people VALUES (2001, 'Куликов Дмитрий Алексеевич','муж','2001-02-08','8914358556','3136461567');


--17 Многострочная инструкция INSERT, выполняющая вставку в таблицу результирующего набора данных вложенного подзапроса.
INSERT INTO people (id_person, person_name, sex, birthdate, passport, drive_license)
select id_person+2001 as id, person_name, sex, birthdate, passport, drive_license
from people
where passport = 'NULL'


-- 18. Обновим права у человека
UPDATE people
SET drive_license = '1111111111'
WHERE id_person > 2000



-- 19. Обновим день рождение у человека
 
UPDATE people
SET birthdate = 
(
SELECT MAX(birthdate)
FROM people
)
where id_person > 2000


--20 Простая инструкция DELETE.
DELETE from people
WHERE id_person = 2001;


--21 Инструкция DELETE с вложенным коррелированным подзапросом в предложении WHERE.
DELETE from people
WHERE id_person IN
(
	SELECT id_person
	FROM people
	WHERE id_person > 2000
)

-- 22. Среднее число аварий человека, который был водителем и виновен
WITH CTE (person_id, NumberOfAccident)
AS
(
 SELECT people.id_person, count(*) as total
 FROM people join affecteddrivers on people.id_person = affecteddrivers.id_person
 WHERE affecteddrivers.guilt = 'виновен'
 GROUP BY people.id_person
)
SELECT AVG(NumberOfAccident)
FROM CTE
*/

/*
with recursive rec(id_ts, brand, year) as
(
        select id_ts, brand, year
		from 
		(
			select id_ts, brand, cast(ts.release_year as int4) as year
			from ts
    		where type_ts = 'легковой автомобиль' 
		) as tmp
		where year = 
		(
			select min(year)
			from 
			(
				select id_ts, brand, cast(ts.release_year as int4) as year
				from ts
    			where type_ts = 'легковой автомобиль' 
			) as tmp
		) 

      union all

        select rec.id_ts, rec.brand, rec.year + 30
        from rec
)

select *
from rec

*/

DROP TABLE IF EXISTS family CASCADE;

CREATE TABLE IF NOT EXISTS family
(
	id_parent INT NOT NULL REFERENCES people(id_person),
	id_child INT NOT NULL REFERENCES people(id_person)
);

INSERT INTO people VALUES (2020, 'Куликов Борис Петрович','муж','1950-02-08', 'NULL','NULL');
INSERT INTO people VALUES (2021, 'Куликова Ирина Борисовна','жен','1976-02-08', 'NULL','NULL');
INSERT INTO people VALUES (2022, 'Куликов Алексей Борисович','муж','1975-02-08', 'NULL','NULL');
INSERT INTO people VALUES (2023, 'Куликов Дмитрий Алексеевич','муж','2001-02-08', 'NULL','NULL');

INSERT INTO family VALUES (2020, 2021);
INSERT INTO family VALUES (2020, 2022);
INSERT INTO family VALUES (2022, 2023);


with recursive rec(id_parent, id_child) as
    (
       select id_parent, id_child
	   from family
       where id_parent = 2020

        union all

        select family.id_parent, family.id_child
        from rec, family
		where rec.id_child = family.id_parent
    )

select id_parent
from rec 
group by id_parent


--24 Оконные функции. Использование конструкций MIN/MAX/AVG OVER()
with cte(brand, releaseYear)
as
(
	select brand, cast(ts.release_year as int4) as year
	from ts
	where ts.type_ts = 'легковой автомобиль'
)
select brand, releaseYear,  
	min(releaseYear) over (partition by brand), max(releaseYear) over (partition by brand),
	avg(releaseYear) over (partition by brand)
from cte

--25 оконные функции для устранения дублей
select * 
from (
	select person_name, sex, birthdate, row_number() over (partition by people.id_person) as row
	from affecteddrivers join people on affecteddrivers.id_person = people.id_person
)as tmp
where row = 1;
