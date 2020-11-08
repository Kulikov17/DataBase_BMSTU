DROP TABLE IF EXISTS table1 CASCADE;
DROP TABLE IF EXISTS table2 CASCADE;


CREATE TABLE IF NOT EXISTS table1
(
    id INT NOT NULL,
    var1 CHAR NOT NULL,
	valid_from_dttm DATE NOT NULL,
	valid_to_dttm DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS table2
(
    id INT NOT NULL,
    var2 CHAR NOT NULL,
	valid_from_dttm DATE NOT NULL,
	valid_to_dttm DATE NOT NULL
);

INSERT INTO table1 VALUES (1, 'A','2018-09-01','2018-09-15');
INSERT INTO table1 VALUES (1, 'B','2018-09-16','5999-12-31');
INSERT INTO table1 VALUES (2, 'A','2018-09-01','5999-12-31');
INSERT INTO table1 VALUES (3, 'A','2018-09-01','2018-09-20');
INSERT INTO table1 VALUES (3, 'B','2018-09-21','2018-09-25');
INSERT INTO table1 VALUES (3, 'C','2018-09-26','5999-12-31');

INSERT INTO table2 VALUES (1, 'A','2018-09-01','2018-09-18');
INSERT INTO table2 VALUES (1, 'B','2018-09-19','5999-12-31');
INSERT INTO table2 VALUES (3, 'A','2018-09-01','2018-09-24');
INSERT INTO table2 VALUES (3, 'B','2018-09-25','5999-12-31');

SELECT table1.id, 
	   table1.var1,
	   table2.var2, 
	   CASE WHEN table1.valid_from_dttm < table2.valid_from_dttm THEN table2.valid_from_dttm ELSE table1.valid_from_dttm END AS valid_from_dttm,
	   CASE WHEN table1.valid_to_dttm > table2.valid_to_dttm THEN table2.valid_to_dttm ELSE table1.valid_to_dttm END AS valid_to_dttm
FROM table1 FULL JOIN table2 ON
	table1.id = table2.id 
	AND table1.valid_from_dttm<=table2.valid_to_dttm
	AND table2.valid_from_dttm<=table1.valid_to_dttm