Ejercicio 1

SELECT *
FROM film f
LEFT JOIN inventory i ON f.film_id = i.film_id
WHERE i.film_id IS NULL;
--------------------------------------------------------------------------------------------------------------------
Ejercicio 2

SELECT CONCAT(c.first_name, ' ',c.last_name) AS 'Nombre Completo', c.store_id, f.title, r.rental_date,r.return_date
from rental r '
inner join customer c using(customer_id)
inner join inventory i ON r.inventory_id = i.inventory_id
inner join film f ON i.film_id = f.film_id
ORDER BY c.store_id,c.last_name;
--------------------------------------------------------------------------------------------------------------------
Ejercicio 3

SELECT
    sto.store_id,
    CONCAT(
        sta.first_name,
        ' ',
        sta.last_name
    ) AS 'Nombre',
    COUNT(pay.payment_id) AS 'cantidad ventas',
    SUM(pay.amount) AS 'dinero ventas',
    CONCAT(co.country, ', ', ci.city) AS 'pais y ciudad'
FROM store sto
    INNER JOIN staff sta ON sto.manager_staff_id = sta.staff_id
    INNER JOIN payment pay ON sta.staff_id = pay.staff_id
    INNER JOIN address adr ON sto.address_id = adr.address_id
    INNER JOIN city ci ON adr.city_id = ci.city_id
    INNER JOIN country co ON ci.country_id = co.country_id
GROUP BY sto.store_id;
--------------------------------------------------------------------------------------------------------------------
