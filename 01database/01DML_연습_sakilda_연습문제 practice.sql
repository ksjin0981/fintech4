select * from actor;
select first_name, last_name from actor;
select title from film;
select first_name, last_name, email from customer;
select * from payment;
select * from film where rating='PG';
select * from film where rental_rate>3;
select * from film where rental_rate>=2 and rating='PG-13';
select * from film where rating='PG' or rating='G';
select title, rental_rate from film where rental_rate between 2 and 4;
select title, rating from film where rating in ('PG', 'PG-13', 'G');
select * from customer where email is null;
select title from film where title like "%LOVE%";
select title from film where title like "A%";
select title from film where title like "%MAN";
select * from customer where last_name like "% %";
select * from actor where first_name like "%JO%";
select title, rental_rate from film order by rental_rate desc;
select title, rating, rental_rate from film order by rating asc, rental_rate desc;
select title, rental_rate from film order by rental_rate desc limit 5;
select * from actor limit 10;
select customer_id, first_name, last_name from customer order by first_name asc limit 20;
select title, rental_rate from film order by rental_rate asc limit 3;
select distinct rating from film; #
select count(*) as 영화수 from film;
select avg(rental_rate) as 평균대여요금 from film;
select max(rental_rate) as 가장비싼대여요금 from film;
select min(rental_rate) as 가장저렴한대여요금 from film;
select sum(amount) as 총결제금액 from payment;
select avg(amount) as 결제금액평균 from payment;
select rating, count(*) as 영화개수 from film group by rating;
select rating, avg(rental_rate) as 평균대여요금 from film group by rating;
select rating, count(*) as 영화수 from film group by rating having count(*) >= 200; #
select staff_id, sum(amount) as 총결제금액 from payment group by staff_id; #
select staff_id, sum(amount) from payment group by staff_id having sum(amount)>=5000;
select customer_id, count(*) as 결제횟수 from payment group by customer_id;
select customer_id, count(*) as 결제횟수 from payment group by customer_id having count(*)>=30;
select customer_id, sum(amount) as 총결제금액 from payment group by customer_id;













