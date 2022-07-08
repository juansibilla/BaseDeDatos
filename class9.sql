#1) Get the amount of cities per country in the database. Sort them by country, country_id.

select country.country_id, country, count(city)
from country
	join city on country.country_id = city.country_id
group by country.country_id, country
order by country.country_id, country;

#2) Get the amount of cities per country in the database.
# Show only the countries with more than 10 cities, order from the highest amount of cities to the lowest

select country.country_id, country, count(city) as cities
from country
	join city on country.country_id = city.country_id
group by country.country_id, country
having cities > 10
order by cities desc;

#3) Generate a report with customer (first, last) name, address, 
#total films rented and the total money spent renting films.
# Show the ones who spent more money first.

select first_name, last_name, address,
	(select count(*)
	from rental 
	where customer.customer_id = rental.customer_id) as total_films_rented,
	(select sum(amount)
    from payment
    where customer.customer_id = payment.customer_id) as total_money_spent
from customer 
	join address on customer.address_id = address.address_id
order by total_money_spent desc;

#4) Which film categories have the larger film duration (comparing average)?
#Order by average in descending order

select `name`,
	(select avg(length)
	from film_category fc
		join film f on fc.film_id = f.film_id
	where c.category_id = fc.category_id) as avg_films_length
from category c
order by avg_films_length desc;

#5) Show sales per film rating

select f.rating, COUNT(p.payment_id) as total_sales
from film f
	join inventory i on i.film_id = f.film_id
	join rental r on r.inventory_id = i.inventory_id
	join payment p on p.rental_id = r.rental_id 
group by rating;

/*select rating,
	(select sum(amount)
    from payment p
		join rental r on p.rental_id = r.rental_id
        join inventory i on r.inventory_id = i.inventory_id
	where f.film_id = i.film_id) as total_sales
from film f
group by rating, total_sales;*/
