-- Ejercicio 1
SELECT
    CONCAT(c.first_name, ' ', c.last_name) AS 'Name',
    ad.address,
    ci.city
FROM customer c
    INNER JOIN store sto USING(store_id)
    INNER JOIN address ad ON sto.address_id = ad.address_id
    INNER JOIN city ci USING(city_id)
    INNER JOIN country co USING(country_id)
WHERE co.country = 'Argentina';

-- Ejercicio 2
SELECT
    f.title,
    l.name,
    f.rating,
    CASE
        WHEN f.rating LIKE 'G' THEN 'All ages admitted'
        WHEN f.rating LIKE 'PG' THEN 'Some material may not be suitable for children'
        WHEN f.rating LIKE 'PG-13' THEN 'Some material may be inappropriate for children under 13'
        WHEN f.rating LIKE 'R' THEN 'Under 17 requires accompanying parent or adult guardian'
        WHEN f.rating LIKE 'NC-17' THEN 'No one 17 and under admitted'
    END 'Rating Text'
FROM film f
INNER JOIN language l USING(language_id);

-- Ejercicio 3
SELECT  CONCAT(ac.first_name, ' ', ac.last_name) AS 'actor',
        f.title AS 'film',
        f.release_year AS 'release_year'
FROM film f
INNER JOIN film_actor USING(film_id)
INNER JOIN actor ac USING(actor_id)
WHERE CONCAT(first_name, ' ', last_name) LIKE TRIM(UPPER('AUDREY BAILEY'));

-- Ejercicio 4
SELECT  f.title,
        r.rental_date,
        c.first_name AS 'customer_name',
        CASE
            WHEN r.return_date IS NOT NULL THEN 'Yes'
            ELSE 'No'
        END 'Returned'
FROM rental r
INNER JOIN inventory i USING(inventory_id)
INNER JOIN film f USING(film_id)
INNER JOIN customer c USING(customer_id)
WHERE MONTH(r.rental_date) = '05' OR MONTH(r.rental_date) = '06'
ORDER BY r.rental_date;

-- Ejercicio 5. 

-- CAST: Esta funcion convierte un valor cualquiera en el tipo de datos especificado.

-- CONVERT: Esta función convierte un valor en el tipo de datos o juego de caracteres especificado.

-- Diferencias:
-- La función CONVERT también le permite convertir un juego de caracteres de datos en otro juego de caracteres mientras que la función CAST no se puede utilizar para cambiar los caracteres.

-- Ejemplos:

-- Función CAST.
-- Comparar entre estas consultas
SELECT last_update FROM film LIMIT 10;

SELECT CAST(last_update AS DATE) FROM film LIMIT 10;

-- CONVERT
-- Convertir estas consultas
SELECT rental_date FROM rental LIMIT 10;

SELECT CONVERT(rental_date, TIME) FROM rental LIMIT 10;

-- Ejercicio 6
--NO ESTAN EN MySQL:
--NVL: Devuelve el valor de la primera expresión en la lista que no sea nulo.

--ISNULL: evalúa una expresión para ver si es nula. Si la expresión es nula, isNull devuelve "true"

-- Ejemplos:

-- IFNULL
SELECT address_id, address, IFNULL(address2, "Alternative value") FROM address LIMIT 10;

-- COALESCE
SELECT address_id, address, COALESCE(address2, "Alternative value") FROM address LIMIT 10;
