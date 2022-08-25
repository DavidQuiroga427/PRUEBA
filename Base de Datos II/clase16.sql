1--
INSERT INTO employees (employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
VALUES (1138,'Julio','gonzales','x1138',NULL,'1',NULL,'secretario');


2--
UPDATE employees SET employeeNumber = employeeNumber - 20;


UPDATE employees SET employeeNumber = employeeNumber + 20;


3--
ALTER TABLE employees 
ADD age TINYINT,
ADD CONSTRAINT ageCheck CHECK(age >= 16 and age <= 70);

4 / 5--

select * FROM employees;

ALTER TABLE employees 
ADD lastUpdate DATETIME;
ALTER TABLE employees
ADD lastUpdateUser VARCHAR(30);

CREATE TRIGGER employees_before_update
	BEFORE UPDATE ON employees
	FOR EACH ROW
BEGIN
	SET NEW.lastUpdate = NOW();
	SET NEW.lastUpdateUser = SESSION_USER();
END;

INSERT INTO employees (employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
VALUES (1138,'Julio','gonzales','x1138','ademail@email.com','1',NULL,'secretario');
UPDATE employees set lastName = 'Alberto', firstName = 'Garzon' WHERE employeeNumber = 1138;
UPDATE employees set lastName = 'gonzales', firstName = 'Julio' WHERE employeeNumber = 1138;




6--

CREATE TABLE `film_text` (
  `film_id` smallint(6) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`film_id`),
  FULLTEXT KEY `idx_title_description` (`title`,`description`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE DEFINER=`user`@`%` TRIGGER `ins_film` AFTER INSERT ON `film` FOR EACH ROW BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END

CREATE DEFINER=`user`@`%` TRIGGER `upd_film` AFTER UPDATE ON `film` FOR EACH ROW BEGIN
    IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id)
    THEN
        UPDATE film_text
            SET title=new.title,
                description=new.description,
                film_id=new.film_id
        WHERE film_id=old.film_id;
    END IF;
  END

CREATE DEFINER=`user`@`%` TRIGGER `del_film` AFTER DELETE ON `film` FOR EACH ROW BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END
