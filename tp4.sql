
/*1*/
SELECT f1.title, f1.rating
	FROM film f1
	WHERE f1.`length` <= ALL (SELECT f2.`length`
		FROM film f2
		WHERE f1.film_id <> f2.film_id);

/*2*/
SELECT f1.title, f1.rating
	FROM film f1
	WHERE f1.`length` < ALL (SELECT f2.`length`
		FROM film f2
		WHERE f1.film_id <> f2.film_id);

/*3*/
SELECT first_name, last_name,
	(SELECT DISTINCT(amount)
          FROM payment p
         WHERE customer.customer_id = p.customer_id
           AND amount <= ALL (SELECT amount
                                FROM payment p2
                               WHERE customer.customer_id = p2.customer_id))
			AS min_amount
	FROM customer
	order by min_amount;

/*3 Other way*/
SELECT first_name, last_name,
	(SELECT MIN(amount)
          FROM payment p
         WHERE customer.customer_id = p.customer_id)
	AS min_amount
FROM customer
order by min_amount;

/*4*/
SELECT first_name, last_name,
	(SELECT CONCAT(MIN(amount), ' - ', MAX(amount))
          FROM payment p
         WHERE customer.customer_id = p.customer_id)
	AS min_max_amount
FROM customer
order by min_max_amount;
