--non equi join
--between and
--모든 사원의 사번,이름,급여,급여등급
select e.employee_id,e.first_name,e.salary,jg.grade_level
from employees e,job_grades jg
where e.salary between jg.lowest_sal and jg.highest_sal;

--outer join
--모든 사원의 사번, 이름, 부서번호, 부서이름
--모든 사원이라고 했으나 19명 밖에 나오지 않았다. 1명이 department_id가 null이기 때문
--e.department_id는 foreign key이다. 따라서 d.department_id에 있는 값 밖에 나올 수 없다. 하지만 예외로 null은 허용된다.
--d.department_id는 primary key이다. 따라서 null이 허용될 수 없다.
--그렇기 때문에 department_id가 null인 한 명이 나오지 않는 것이다.
select e.employee_id,e.first_name,d.department_id,d.department_name
from employees e,departments d
where e.department_id=d.department_id;

--join을 하면 null인 튜플이 안나오는 경우 (+)을 붙여 null인 튜플도 나올 수 있게 한다.
--부서가 마지정일 경우 부서이름을 '대기발령중'으로 출력
--d.department_id에 없는 null값을 추가시키기 위해 join할 때 (+)을 붙인다.
--이것을 outter join이라고 한다.
select e.employee_id,e.first_name,d.department_id,nvl(d.department_name,'대기발령중')
from employees e,departments d
where e.department_id=d.department_id(+);

--모든 사원의 사번,이름,상관사번,상관이름
--단 상관이 없을 경우 상관이름에 '사장'으로 출력
select e.employee_id,e.first_name,e.manager_id,nvl(em.first_name,'사장')
from employees e, employees em
where e.manager_id=em.manager_id(+);

--모든 사원의 사번,이름,상관사번,상관이름,부서이름
--단 상관이 없을 경우 상관 이름에 '사장'으로 출력
--단 부서가 미지정일 경우 부서이름을 '대기발령중'을 ㅗ출력
select e.employee_id,e.first_name,e.manager_id,nvl(em.first_name,'사장'),nvl(d.department_name,'대기발령중')
from employees e, employees em,departments d
where e.manager_id=em.manager_id(+)
and e.department_id=d.department_id(+);

---------------------------------------------------------------------------------
--ANSI JOIN
--cross join
--oracle
select *
from employees,departments;

--ansi
select *
from employees cross join departments;

--inner join
--oracle
--사번,이름,부서이름
select e.employee_id,e.first_name,d.department_name
from employees e, departments d
where e.department_id=d.department_id;

--ansi
select e.employee_id,e.first_name,d.department_name
from employees e inner join departments d
on e.department_id=d.department_id;

--조건걸기 : 그냥 and써서 on절에 써도 되지만 where절에 쓰는 것이 좋음
select e.employee_id,e.first_name,d.department_name
from employees e inner join departments d
on e.department_id=d.department_id
where e.department_id=50;

--using : ~를 사용해서 조인한다
select e.employee_id,e.first_name,d.department_name
from employees e inner join departments d
using(department_id)      --join할때 컬럼이름이 같은 경우 using 사용
where department_id=50; --using쓴 컬럼은 e. d.같은 식별자 쓰면 안됨.

--natural join : inner join중 하나
--             : 두 테이블의 이름이 같은 컬럼을 자동으로 찾아 조인해줌
--같은 이름의 컬럼이 하나 이상 이면 모든 같은 컬럼을 조인한다.
--employees와 departments는 department_id와 manager_id 두개의 컬럼 이름이 같다.
--따라서 두 테이블 사이에 같은 이름의 컬럼이 하나일때만 쓰는 것이 좋다.
select e.employee_id,e.first_name,d.department_name
from employees e natural join departments d
where department_id=50;

--여러 테이블 join
--oracle
--'seattle'에 근무하는 사번,이름,부서이름,도시
select e.employee_id,e.first_name,d.department_name,l.city
from employees e, departments d, locations l
where e.department_id=d.department_id
and d.location_id=l.location_id
and l.city = 'Seattle';

--ansi
--3개 이상의 테이블을 조인하려면 순차적으로 join/on을 반복하면 된다
--하지만 순서가 바뀌면 안됨으로 순서에 유의해야한다.
select e.employee_id,e.first_name,d.department_name,l.city
from employees e
join departments d
on e.department_id=d.department_id
join locations l
on d.location_id = l.location_id
where l.city='Seattle';

--outter join
--oracle
--모든 사원의 사번,이름,부서번호,부서이름
select e.employee_id,e.first_name,e.department_id,d.department_name
from employees e, departments d
where e.department_id=d.department_id(+);
--모든 부서에 근무하는 사원의 사번,이름,부서번호,부서이름
--부서가 기준이기 때문에 select에서 부서번호를 d.department_id로 뽑고 outter join도 부서기준
select e.employee_id,e.first_name,d.department_id,d.department_name
from employees e,departments d
where e.department_id(+)=d.department_id;

--ansi : left / right outter join : 기준을 왼쪽/오른쪽에 두고 다 뿌려라
--왼쪽 테이블에 있는 것을 다 뿌려라
select e.employee_id,e.first_name,e.department_id,nvl(d.department_name,'대기발령중')
from employees e left outer join departments d
on e.department_id=d.department_id;
--오른쪽 테이블에 있는 것을 다 뿌려라
select e.employee_id,nvl(e.first_name,'사원없음'),e.department_id,d.department_name
from employees e right outer join departments d
on e.department_id=d.department_id;

--full outer join (ansi)
--ansi 두개를 outter 조인해주는 full outer join이 있다.
select e.employee_id,nvl(e.first_name,'사원없음'),d.department_id,nvl(d.department_name,'대기발령중')
from employees e full outer join departments d
on e.department_id=d.department_id;

--내가 만든 문제
--모든 국가의 사원의 사번, 이름,부서번호,도시,국가이름을 쓰시오 (oracle join)
select e.employee_id, e.first_name, d.department_id, l.city, c.country_name
from countries c, employees e, departments d,locations l
where e.department_id(+)=d.department_id
and d.location_id(+)=l.location_id
and l.country_id(+)=c.country_id
order by c.country_name;

--모든 사원의 사번,이름,커미션이 포함된 급여(커미션없으면 그냥 급여),매니저이름,급여수준 구하시오
--매니저가 없는 사람은 '사장'이라고 쓰시오
--급여수준은 5000미만이면 하, 10000미만이면 중, 10000이상이면 상이다. (ANSI join으로 쓰시오)
select e.employee_id,e.first_name,
e.salary+e.salary*nvl(e.commission_pct,0) 커미션포함급여 , nvl(em.first_name,'사장'),
    case 
        when e.salary<5000
        then '하'
        when e.salary<10000
        then '중'
        else '상'
    end 급여수준
from employees e left outer join employees em
on e.manager_id=em.employee_id;