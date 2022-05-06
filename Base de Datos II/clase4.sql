-- Actividad 1
SELECT f.title, f.special_features 
FROM film f
WHERE f.rating LIKE "%PG-13%";

-- Actividad 2
SELECT length 
FROM film 
GROUP BY length;

-- Actividad 3
SELECT title, rental_rate, replacement_cost 
FROM film
WHERE replacement_cost BETWEEN 20.00 AND 24.00;

-- Actividad 4

SELECT f.title, c.name AS 'category', f.rating 
FROM film f, film_category fc, category c
WHERE f.film_id = fc.film_id 
    AND fc.category_id = c.category_id
    AND f.special_features LIKE '%Behind the Scenes%';

-- Actividad 5

SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
    WHERE f.title LIKE '%ZOOLANDER FICTION%';

-- Actividad 6

SELECT a.address, ci.city, co.country
FROM store s
JOIN address a ON s.address_id = a.address_id 
JOIN city ci ON a.city_id = ci.city_id 
JOIN country co ON ci.country_id = co.country_id
    WHERE s.store_id = 1;

-- Actividad 7
SELECT ANY_VALUE(title), rating FROM film 
GROUP BY rating;

-- Actividad 8.
SELECT f.title, f.description, sta.first_name, sta.last_name 
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN store s ON i.store_id = s.store_id
JOIN staff sta ON s.manager_staff_id = sta.staff_id
    WHERE s.store_id = 2;
