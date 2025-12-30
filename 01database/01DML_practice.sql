# 데이터베이스 목록 조회 show databases; (ctrl+enter로 실행)
show databases;

# 데이터베이스 열기 (excel 파일 더블 클릭하기, 명령어는 대문자가 원칙)
use sakila;

# 테이블 목록 조회 show tables;
show tables;

# 테이블에서 원하는 자료 조회하기 select (컬럼명 or *) from 테이블명;
select * from film;

# film 테이블에서 title과 release_year 컬럼만 보고 싶을 때
select title, release_year from film;

# 컬럼 별명, 별칭 주기 (as로 사용하지만 생략해도 가능함)
select title as 영화제목, rental_rate 대여요금 from film;

# 특정 조건을 만족하는 행만 출력하기 where절
# select 컬럼명 from 테이블명 where 조건
# 문자 조건: where 컬럼명 = "조건"
# rating이 PG인 행만 조회
select * from film where rating="PG";

# 숫자 조건 where 컬럼명 = < <= >= 숫자
# rental_rate가 3 초과인 행 조회
select * from film where rental_rate > 3;

# 2가지 이상의 조건을 만족하는 행 조회 and, or
# film 테이블에서 rental_rate가 2 이상이고 rating이 PG-13인 행 조회 (~이고 = and)
select * from film where rental_rate >=2 and rating="PG-13";

# film 테이블에서 rating이 'PG' 혹은 'G'인 행 조회 (~혹은 ~또는 ~이거나 = or)
select * from film where rating="PG" or rating="G";

# 부정조건: ~가 아닌 경우 <>, !=
# film 테이블에서 rating이 'PG'가 아닌 행 조회
select * from film where rating != 'PG';
select * from film where rating <> 'PG';

# 컬럼끼리 비교하기 
# replacement_cost가 rental_rate보다 큰 영화만 조회
select title, rental_rate, replacement_cost 
from film 
where replacement_cost > rental_rate;

# 사칙연산으로 계산한 결과를 조건에 넣을 수 있음
# replacement_cost - rental_rate가 >= 10인 행만 조회
select title, rental_rate, replacement_cost 
from film 
where (replacement_cost-rental_rate) >= 10;

# 날짜 조건 주기 (날짜도 문자처럼 따옴표로 감싸서 조건 줌)
# rental_rate가 2005-07-01 보다 큰 행만 조회
select * from rental where rental_date >= "2005-07-01";

# between 시작과 끝 값을 포함하는 범위로 조회할 때 (이상, 이하인 경우만 가능)
# rental_rate >=2 and rental_rate <= 4 (2,3,4)
# rental_rate가 2 이상 4 이하인 데이터 조회
select * from film where rental_rate >= 2 and rental_rate <= 4;
select * from film where rental_rate between 2 and 4;

# in 여러 값 중에서 하나라도 같으면 포함되는 조건 (or를 여러 번 쓴 것과 같음) 
# rating이 'PG', 'G', 'PG-13'일 경우 조회
select * from film where rating = 'PG' or rating = 'G' or rating = "PG-13";
select * from film where rating in ('PG', 'G', "PG-13");

# like 문자열에 특정 글자가 포함되어 있는지 확인하는 기능 
# description 컬럼에서 drama가 포함된 행을 조회
# like "%단어%", like "%단어", like"단어%"
select * from film where description like "%drama%";
select * from film where description like "A Epic%";
select * from film where description like "%India";

# null 조회/ 값이 없는 경우 찾기 is null(where original_language_id=null 이렇게 하면 조회 안됨)
select * from film where original_language_id is null;
# null이 아닌 것만 조회: is not null
select * from film where original_language_id is not null;

# 순서 정렬하기(order by), 제한된 숫자의 행만 보기 (limit)
# 정렬 (order by asc 오름차순, order by desc 내림차순)
# rental_rate컬럼을 기준으로 내림차순 정렬 
select * from film order by rental_rate desc;
select * from film order by rental_rate asc; # asc 생략해도 기본적으로 오름차순으로 정렬해줌

# 두 개 이상의 기준으로 정렬하고 싶을 때 
# rating을 기준으로 오름차순 정렬한 것을 rental_rate 기준으로 내림차순해서 보기
select * from film order by rating asc, rental_rate desc;

# 전체 데이터에서 임의의 10행을 추출할 때 rand(), limit 10
# film 테이블에서 10개의 데이터를 무작위 추출하세요.
select * from film order by rand() limit 10;

# film 데이터를 3개만 출력 limit 3
select * from film limit 3;

# 중복 값을 한번만 출력하는 기능 distinct
select distinct rating from film;

# 집계함수 (개수, 평균, 최대, 최소)
# count 개수 
# sum 합계
# avg 평균
# max 최대
# min 최소
# 영화의 개수 구하기 count
select count(*) as 영화수 from film;
  
# rental_rate의 평균, 최고, 최소 요금 계산하기
select 
avg(rental_rate) as 평균요금,
max(rental_rate) as 최고요금,
min(rental_rate) as 최저요금
from film;

select * from payment;
# payment 테이블의 amount 총합
select sum(amount) as 총결제금액 from payment;

# group by, having
# group by는 같은 값끼리 묶는 기능, 같은 종류끼리 묶어서 통계를 보고 싶을 때 
# 영화 등급이 같은 영화의 수를 세고 싶을 때 
select rating, count(*) as 영화수 from film group by rating;
select *, count(*) as 영화수 from film group by rating;  # 오류남 WHY? rating으로 묶었으니까 묶은 컬럼을 앞쪽에 꼭 같이 써줘야 함

# having: group by를 한 결과에서 원하는 조건을 줄 때 (where는 group by를 하지 않았을 때 조건을 줌)
select rating, count(*) as 영화수 from film group by rating having count(*) >= 200;

# join: 서로 다른 테이블을 하나의 결과처럼 연결하는 방법
# 공통된 컬럼을 기준으로 연결 (공통된 컬럼은 보통 primary key, foreign key로 연결되어 있음)
# inner(합치는 테이블 양쪽에 모두 있는 데이터만 합침)
# left(합치는 테이블 중 왼쪽 테이블을 기준으로 왼쪽에 있는 것만 오른쪽에서 가져옴)
# right(합치는 테이블 중 오른쪽 테이블을 기준으로 오른쪽에 있는 것만 왼쪽에서 가져옴)
# full outer join (양쪽 테이블을 모두 합침)

select * from customer;
select * from rental;

# customer 테이블과 rental 테이블을 합쳐서 이름, 성, 대여일 조회
select c.customer_id, c.first_name, c.last_name, r.rental_date 
from customer c # left table
inner join rental r  # right table
on c.customer_id = r.customer_id;

select c.customer_id, c.first_name, c.last_name, r.rental_date 
from customer c # left table
left join rental r  # right table
on c.customer_id = r.customer_id;

select c.customer_id, c.first_name, c.last_name, r.rental_date 
from customer c # left table
right join rental r  # right table
on c.customer_id = r.customer_id;

# 테이블 합친 후 조건 주어 필터링 하기
# 2005-07-01보다 최근인 자료만 필터링
select c.customer_id, c.first_name, c.last_name, r.rental_date 
from customer c # left table
inner join rental r  # right table
on c.customer_id = r.customer_id
where r.rental_date >= "2005-07-01";

# join 이후 고객별 대여 횟수 구하기
select c.customer_id, count(r.rental_id) as 대여횟수
from customer c 
left join rental r 
on c.customer_id = r.customer_id
group by c.customer_id
having count(r.rental_id) >= 10
order by 대여횟수 desc;

# 서브쿼리
# 평균 대여 요금보다 비싼 영화만 보기
select avg(rental_rate) as 대여요금 from film;
select title, rental_rate from film where rental_rate>2.98;
select title, rental_rate from film where rental_rate > (select avg(rental_rate) as 대여요금 from film); # where절에는 집계함수 쓸 수 없음.

# 서브쿼리 실행 결과가 여러개일 때 IN, ANY, ALL을 사용 
# 영화 category가 'Comedy' 또는 'Action' 장르의 제목 보기 
select * from film;
select * from category;
select * from film_category;

select title from film where film_id 
in (select film_id from film_category 
	where category_id in (select category_id from category where name in ('Comedy', 'Action')));




