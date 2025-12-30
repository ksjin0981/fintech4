use db명세서;

insert into currencies(`currency_code`, `currency_name`, `minor_unit`)
values ('KRW', 'Korean Won', 0),
	   ('USD', 'US Dollar', 2),
       ('JPY', 'Japanese Yen', 0),
       ('EUR', 'Euro', 2),
       ('GBP', 'Pound Sterling', 2),
       ('AUD', 'Australian Dollar', 2);
select * from currencies;

insert into users(`user_id`, `email`, `full_name`, `status`)
values ('1', 'alice@example.com ', 'Alice Kim', 1),
       ('2', 'bob@example.com ', 'Bob Lee', 1),
       ('3', 'carol@example.com ', 'Carol Park', 1),
       ('4', 'dave@example.com ', 'Dave Choi', 1),
       ('5', 'erin@example.com ', 'Erin Jung', 0),
       ('6', 'frank@example.com ', 'Frank Yoo', 1),
       ('7', 'grace@example.com ', 'Grace Han', 1),
       ('8', 'heidi@example.com ', 'Heidi Lim', 1);
select * from users;
desc users;

desc fx_holdings;
insert into fx_holdings(`user_id`, `currency_code`, `balance`)
values('1', 'KRW', 1200000.00000000),
      ('1', 'USD', 950.25000000),
      ('1', 'EUR', 210.00000000),
      ('2', 'KRW', 560000.00000000),
      ('2', 'JPY', 75000.00000000),
      ('3', 'USD', 1250.75000000),
      ('3', 'GBP', 80.00000000), 
      ('4', 'KRW', 330000.00000000),
      ('4', 'USD', 420.00000000),
      ('4', 'JPY', 12000.00000000),
      ('5', 'EUR', 500.00000000),
      ('5', 'AUD', 600.00000000),
      ('6', 'KRW', 980000.00000000),
      ('6', 'USD', 110.00000000),
      ('6', 'EUR', 45.50000000),
      ('7', 'JPY', 150000.0000000),
      ('7', 'GBP', 30.00000000),
      ('8', 'KRW', 250000.00000000),
      ('8', 'AUD', 120.00000000);
select * from fx_holdings;


# 문제 1
select fx.user_id, u.full_name,fx. currency_code, fx.balance
from fx_holdings fx
inner join users u
on fx.user_id=u.user_id
order by user_id asc, currency_code asc;

# 문제 2
select fx.currency_code, fx.balance 
from fx_holdings fx
inner join users u
on fx.user_id=u.user_id
where u.email='alice@example.com'
order by currency_code asc;

# 문제 3
select currency_code, sum(balance) as total_balance
from fx_holdings
order by currency_code asc;

# 문제 4
select fx.user_id, full_name, count(fx.currency_code) as 보유통화수, sum(fx.balance) as 잔액합계
from users u
inner join fx_holdings fx
on u.user_id = fx.user_id
group by fx.user_id;

# 문제 5
select u.full_name, fx.balance
from users u
inner join fx_holdings fx
on u.user_id = fx.user_id
where fx.currency_code='KRW'
order by balance desc
limit 5;

# 문제 6
select u.full_name, fx.balance
from fx_holdings fx
inner join users u 
on fx.user_id = u.user_id
where currency_code='USD'
order by balance desc;

# 문제 7
select u.user_id, u.full_name, count(fx.currency_code) as 보유통화수
from users u
inner join fx_holdings fx
on u.user_id = fx.user_id
group by u.user_id, u.full_name
having count(fx.currency_code)>=2
order by count(fx.currency_code) desc, u.full_name asc;

# 문제 8
select u.full_name, fx.currency_code, fx.balance
from users u 
inner join fx_holdings fx
on u.user_id = fx.user_id
where status=0
order by full_name asc;

# 문제 9
select c.currency_code, c.currency_name, fx.balance
from currencies c 
inner join fx_holdings fx
on c.currency_code = fx.currency_code
inner join users u
on fx.user_id = u.user_id
where u.email='alice@example.com'
order by c.currency_code asc;

# 문제 10
select c.currency_code, count(*) as holder_count, sum(fx.balance) as total_balance
from currencies c
inner join fx_holdings fx
on c.currency_code = fx.currency_code
group by fx.currency_code
order by fx.currency_code asc;









      