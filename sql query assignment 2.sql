use sakila;

-- Find out the number of documentaries with deleted scenes.
select count(*) from film_category fc
join category c on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
where c.name = 'Documentary' and f.special_features like '%deleted scenes%';  

-- Find out the number of sci-fi movies rented by the store managed by Jon Stephens.
select count(distinct i.film_id) from rental r
join staff_list sl on sl.ID = r.staff_id
join inventory i on i.inventory_id = r.inventory_id
join film_list fl on fl.FID = i.film_id
where sl.ID=2 and fl.category='Sci-Fi';

-- Find out the total sales from Animation movies.
select sum(amount) from rental r join payment p on r.rental_id = p.rental_id
join inventory i on r.inventory_id = i.inventory_id
join film_category fc on i.film_id = fc.film_id
join category c on fc.category_id=c.category_id
where c.category_id=(
  select category_id from category 
  where name='Animation'
);

-- Find out the top 3 rented category of movies by “PATRICIA JOHNSON”.
select c.name,count(*) from  rental r 
join inventory i on (r.inventory_id = i.inventory_id)
join film_category fc on (i.film_id=fc.film_id) 
join category c on (fc.category_id = c.category_id)
where r.customer_id = ( 
  select customer_id from customer 
  where first_name='PATRICIA' and last_name='JOHNSON'
)
group by c.name order by count(*) DESC LIMIT 3;

-- Find out the number of R rated movies rented by “SUSAN WILSON”.
select count(*) from  rental r 
inner join inventory i on (r.inventory_id = i.inventory_id)
inner join film f on (i.film_id=f.film_id) 
where f.rating='R' 
and r.customer_id in ( 
  select customer_id from customer 
  where first_name='SUSAN' and last_name='WILSON'
);
