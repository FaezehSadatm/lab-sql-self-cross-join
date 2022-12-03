use sakila;

#1. Get all pairs of actors that worked together.
select a1.actor_id, a1.first_name, a1.last_name, fa1.film_id, a2.actor_id, a2.first_name, a2.last_name from actor a1
join film_actor fa1 on a1.actor_id = fa1.actor_id
join film_actor fa2
on fa1.actor_id <> fa2.actor_id
and fa1.film_id = fa2.film_id
join actor a2 on fa2.actor_id = a2.actor_id;

#2. Get all pairs of customers that have rented the same film more than 3 times.
select r1.customer_id, count(r1.customer_id) over (partition by i1.film_id) ,i1.film_id, r2.customer_id, count(r2.customer_id) over (partition by i1.film_id)
from rental r1
join inventory i1 on r1.inventory_id = i1.inventory_id
join inventory i2 
on i1.film_id = i2.film_id
join rental r2 on i2.inventory_id = r2.inventory_id
where r1.customer_id <> r2.customer_id
order by r1.customer_id;

#3. Get all possible pairs of actors and films.
select * from film f
cross join film_actor fa on f.film_id = fa.film_id
cross join actor a on fa.actor_id = a.actor_id;