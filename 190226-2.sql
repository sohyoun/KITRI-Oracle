--들어가기 앞서 다음의 문제를 풀려면 한계가 발생하게 된다.
--사번,이름,부서번호,부서이름
--employees 테이블에는 부서이름이 없기 때문에 departments 테이블에서 일일히 비교해야한다.
select employee_id,first_name,department_id
from employees;
select department_id,department_name
from departments;

--cross join은 중복되고 정상적이지 못한 data가 나온다.
--employees,departments를 합치게 되면 중복이 되어 정상적인 data가 나오지 않는다.
--카타시안 프로덕트가 된다.즉 employees와 departments튜플이 곱해진 수 만큼의 data가 생성된다.
select *
from employees,departments
order by employee_id;
--따라서 Equl JOIN이 필요하게 된다.

--Equl Join(naturl join):=으로 비교하는것
--table을 2개이상 join한다면 table갯수의 최소 n-1개의 조건을 걸어야한다
--'.'는 database에서 in이나 have의 뜻을 갖고있다. employees테이블에 있는 department_id
--아래의 결과로 총 19개의 튜플이 나온다. 원래 20개지만 1명은 department가 없다.
--primary키는 유니크하고 null이 나오면 안된다. 따라서 employees테이블에서 employee_id는 프라이머리키이다.
select *
from employees,departments
where employees.department_id=departments.department_id
order by employees.employee_id;

--join을 할때는 그냥 속성들의 이름을 쓰게 되면 모호해질 수 있기 대문에
--employees.employee_id 처럼 table이름을 다 붙여주는 것이 좋다.
--테이블 이름에 별칭을 주어 e.employee_id 식으로 코드를 줄일 수 있다.
select e.employee_id,e.first_name,d.department_id,d.department_name
from employees e,departments d
where e.department_id=d.department_id
order by e.employee_id;

--'Seattle'에 근무하는 사원의 사번,이름,부서이름,도시이름
select e.employee_id,e.first_name,d.department_name,l.city
from employees e,locations l,departments d
where e.department_id=d.department_id
and d.location_id=l.location_id
and lower(l.city)=lower('seattle');
--*City에서 Seattle이 앞이 대문자이기 때문에 lower를 써줘야한다. 양쪽 다 써주는 것이 좋음.

--'europe'에 근무하는 사원이름,부서이름,도시이름
select e.first_name,d.department_name,l.city
from employees e,departments d,locations l,countries c,regions r
where e.department_id=d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id=r.region_id
and lower(r.region_name)=lower('europe');

--마지막에 d.department_id가 아니라 e.department_id이어야한다.
--10,80,90,번 부서에 근무중인 사원을 찾는 것이기 때문
--10,80,90번 부서에 근무중인 사원의
--사번,이름,직책이름,부서이름
select e.employee_id,e.first_name,j.job_title,d.department_name
from employees e, departments d,jobs j
where e.job_id=j.job_id
and e.department_id=d.department_id
and e.department_id in(10,80,90);

--self join
--모든사원의 부서이름,사번,이름,매니저사번,매니저이름
select d.department_name,e.employee_id,e.first_name,e.manager_id,employees.first_name
from employees e,departments d,employees
where e.department_id=d.department_id
and employees.employee_id=e.manager_id
order by d.department_name;

--문제
--최소연봉이 10000이 넘는 직책의 사원의 사원번호,이름,연봉,직책이름,부서이름
select e.employee_id,e.first_name,e.salary,j.job_title,d.department_name
from employees e, jobs j,departments d
where e.department_id=d.department_id
and e.job_id=j.job_id
and j.min_salary>10000;

--사번,이름,매니저사번,매니저이름,매니저의 직책
--별칭을 매니저직책으로 하시오
select e.employee_id,e.first_name,e.manager_id,em.first_name 매니저이름,j.job_title 매니저직책
from employees e,employees em,jobs j
where em.employee_id=e.manager_id
and em.job_id=j.job_id;

--조원문제
--'toronto'에 위치한 부서에 근무하는 사원중 8월에 입사한 사람의
--사번,이름,부서명,직책이름,매니저이름을 출력
select e.employee_id,e.first_name,d.department_name,j.job_title,em.first_name
from employees e,departments d, jobs j, employees em,locations l
where e.department_id=d.department_id
and e.job_id=j.job_id
and d.location_id=l.location_id
and e.manager_id=em.employee_id
and lower(l.city) = lower('toronto')
and to_char(e.hire_date,'mm')='08';

--1995년 이전에 입사한 사원 중 5000이하의 급여를 받는 사원의
--사원,이름,직책이름,급여,근무도시를 출력하라
select e.employee_id,e.first_name,j.job_title,e.salary,l.city 
from employees e, jobs j,departments d,locations l
where e.department_id=d.department_id
and e.job_id=j.job_id
and d.location_id=l.location_id
and to_number(to_char(e.hire_date,'yyyy'),'9999')<1995
and e.salary<=5000;