SELECT title, special_features 
FROM film 
WHERE rating LIKE 'PG-13%'; 

SELECT DISTINCT length 
FROM film ORDER BY `length` ; 

SELECT title, rental_rate, replacement_cost 
FROM film 
WHERE replacement_cost BETWEEN 20 AND 24;

SELECT f.title,f.special_features  ,c.name ,f.rating 
FROM  film f, category c 
WHERE special_features LIKE 'Behind the scenes%';

SELECT f.title, a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id 
JOIN film f ON fa.film_id = f.film_id 
WHERE title LIKE '%ZOOLANDER FICTION%';

SELECT  s.store_id, a.address, c.city, c2.country
FROM store s 
JOIN address a ON s.address_id = a.address_id 
JOIN city c ON a.city_id = c.city_id 
JOIN country c2 ON c.country_id = c2.country_id 
WHERE s.store_id LIKE 1;

SELECT f1.title,f2.title , f1.rating
FROM film f1, film f2 
WHERE f1.rating = f2.rating ;
