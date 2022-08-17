-- David Quiroga Aventuroso 7C:
CREATE OR REPLACE VIEW list_of_customers AS
  SELECT c.customer_id, 
    CONCAT(c.first_name, ' ', c.last_name), 
    a.address, 
    a.postal_code, 
    a.phone, 
    c2.city, 
    c3.country,
    CASE
  		WHEN c.active = 1 THEN 'active'
  		ELSE 'inactive'
  	END AS status
  FROM customer c
  	INNER JOIN address a USING(address_id)
  	INNER JOIN city c2 USING(city_id)
  	INNER JOIN country c3 USING(country_id);


CREATE OR REPLACE VIEW film_details AS
	SELECT f.film_id,
		   f.title,
           f.description,
           c.name,
           f.length,
           f.rating,
           f.replacement_cost,
           group_concat(
           concat(a.first_name,' ',a.last_name)
           ) AS 'Actores'
	FROM film f 
    INNER JOIN film_category USING(film_id)
    INNER JOIN category c USING(category_id)
    INNER JOIN film_actor USING(film_id)
    INNER JOIN actor a USING(actor_id)
	GROUP BY f.film_id, c.name;
    

CREATE OR REPLACE VIEW sales_by_film_category AS
SELECT
    ca.name,
    COUNT(r.rental_id) AS total_rental
FROM film
    INNER JOIN film_category USING(film_id)
    INNER JOIN category ca USING(category_id)
    INNER JOIN inventory USING(film_id)
    INNER JOIN rental r USING(inventory_id)
GROUP BY ca.name;


CREATE OR REPLACE VIEW actor_information AS
	SELECT a.actor_id, 
    CONCAT_WS(" ", a.first_name, a.last_name) AS 'full name',
	(SELECT COUNT(f.film_id)
		FROM film f
			INNER JOIN film_actor fa USING(film_id)
			INNER JOIN actor a2 USING(actor_id)
		WHERE a2.actor_id = a.actor_id) AS 'amount of films he/she acted on'
	FROM actor a;

--Ejercicio 5:
SELECT VIEW_DEFINITION
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_NAME = 'actor_info';
    
   
select `a`.`actor_id` AS `actor_id`,`a`.`first_name` AS `first_name`,`a`.`last_name` AS `last_name`,
    group_concat(distinct concat(`c`.`name`,': ', (select group_concat(`f`.`title` order by `f`.`title` ASC separator ', ')
                from ((`sakila`.`film` `f` join `sakila`.`film_category` `fc` on( (`f`.`film_id` = `fc`.`film_id`)))
                        join `sakila`.`film_actor` `fa` on( (`f`.`film_id` = `fa`.`film_id`)))
                where ((`fc`.`category_id` = `c`.`category_id`)and(`fa`.`actor_id` = `a`.`actor_id`))))
        order by
            `c`.`name` ASC separator '; ') AS `film_info`
from (((`sakila`.`actor` `a` left join `sakila`.`film_actor` `fa` on((`a`.`actor_id` = `fa`.`actor_id`)))
            left join `sakila`.`film_category` `fc` on((`fa`.`film_id` = `fc`.`film_id`)))
        left join `sakila`.`category` `c` on((`fc`.`category_id` = `c`.`category_id`)))
group by
    `a`.`actor_id`,
    `a`.`first_name`,
    `a`.`last_name`;

-- MATERIALIZED VIEW:
-- Una vista materializada utiliza una aproximación diferente: el resultado de la consulta se almacena en una tabla caché real, que será actualizada de forma periódica a partir de las tablas originales.
