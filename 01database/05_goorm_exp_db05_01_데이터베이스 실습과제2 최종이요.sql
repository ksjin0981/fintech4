# 문제 1
select s.student_id, s.student_name, s.height, s.department_id, d.department_name 
from student s
inner join department d
on s.department_id = d.department_id;

# 문제 2
select professor_id 
from professor
where professor_name = '가교수';

# 문제 3
select d.department_name, count(p.professor_id)
from department d
inner join professor p
on d.department_id = p.department_id
group by department_name;

# 문제 4
select s.student_id, s.student_name, s.height, d.department_id, d.department_name
from student s
inner join department d
on s.department_id = d.department_id
where department_name = '정보통신학';

# 문제 5
select p.professor_id, p.professor_name, p.department_id, d.department_name
from professor p
inner join department d 
on p.department_id = d.department_id
where department_name='정보통신학';

# 문제 6
select s.student_name, d.department_name
from student s
inner join department d
on s.department_id = d.department_id
where s.student_name like '아%';

# 문제 7
select count(student_id)
from student
where height between 180 and 190;

# 문제 8
select d.department_name, max(s.height), avg(s.height)
from student s
inner join department d
on s.department_id = d.department_id
group by d.department_name;

# 문제 9
select student_name from student 
where department_id = (select department_id from student where student_name = '다길동');

# 문제 10
select s.student_name, c.course_name 
from course c
inner join   student_course sc
on c.course_id = sc.course_id
inner join student s
on sc.student_id = s.student_id
where c.start_date like '2016/11%';

# 문제 11
select s.student_name 
from course c
inner join   student_course sc
on c.course_id = sc.course_id
inner join student s
on sc.student_id = s.student_id
where c.course_name='데이터베이스 입문';

# 문제 12
select count(s.student_id)
from student_course sc
inner join student s
on sc.student_id = s.student_id
inner join professor p
on s.department_id = p.department_id
where p.professor_name='빌게이츠';










