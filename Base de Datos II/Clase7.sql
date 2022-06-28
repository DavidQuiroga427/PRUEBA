--Ejercicio 1--
select title, rating, length
from film
where length = (select min(length) from film)

--Ejercicio 2--
select title, rating, length
from film
where length < ALL (select min(length) from film)


--Ejercicio 3--
SELECT c.first_name as nombre,c.last_name as apellido, a.address as Direccion,
	(SELECT min(amount) FROM payment p WHERE c.customer_id = p.customer_id ) as Paga
FROM customer c
JOIN address a on c.address_id = a.address_id
ORDER BY c.first_name


--Ejercicio 4--
SELECT c.first_name as nombre,c.last_name as apellido, a.address as Direccion,
	(SELECT MIN(amount) FROM payment p WHERE c.customer_id = p.customer_id ) as Paga_Minima, 
    (SELECT MAX(amount) FROM payment p WHERE c.customer_id = p.customer_id ) AS paga_maxima
FROM customer c
JOIN address a on c.address_id = a.address_id
ORDER BY c.first_name
