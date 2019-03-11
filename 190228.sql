--부질의 (서브쿼리)
--부서이름이 it에 근문하는 사원의 사번, 이름, 급여
select e.employee_id,e.first_name,e.salary
from employees e, departments d
where e.department_id=d.department_id
and d.department_name='IT';

--join의 단점: 카타시안 프로덕트를 해서 데이터를 뽑기 때문에 크기가 너무 커서 버겁다.
--밑의 예제에서 뽑아야하는 것은 다 employees테이블에 있는데 굳이 join을 해야할까?
--따라서 'IT'부서의 부서id는 60임으로 employees테이블에서 부서 id가 60인 사람을 뽑으면 된다.
select department_id
from departments
where department_name='IT';

select employee_id,first_name,salary 
from employees
where department_id=60;

--이것을 합치는 것을 쿼리안에 쿼리를 넣는 '서브쿼리'이다.
--select from은 select의 위치에 맞추는 것이 좋다.
--단일열 부질의
select employee_id,first_name,salary
from employees
where department_id=(select department_id
                     from departments
                     where department_name='IT');

--'Seattle'에 근무하는 사원의 사번,이름,급여
--'Seattle에 근무하는 부서가 여러개이기 대문에 =이 아닌 in을 써야한다.
select employee_id,first_name,salary
from employees
where department_id in(select department_id
                       from departments
                       where location_id =(select location_id
                                           from locations
                                           where lower(city)=lower('Seattle')));
                                
--**'seattle'에 근무하는 부서가 여러개이기 때문에 = 이 아닌 in을 써야한다.
--**주의할점 : where절에 쓴 서브쿼리에 가져온 데이터를 화면에 뿌릴 순 없다.주쿼리의 from에 쓴 것만 쓸 수 있음.

--예제)서브쿼리를 쓸 수 없는 경우
--다음과 같이 두개의 테이블에 있는 정보를 출력해야하면 join을 써야한다.
--지역번호가 1700인 부서에서 일하는 사원의
--사번,이름,부서번호,부서이름
select e.employee_id,e.first_name,e.department_id,d.department_name
from employees e,departments d
where e.department_id=d.department_id
and d.location_id=1700;
--**이처럼  모든 서브쿼리가 join을 대체할 수 없다.

---인라인 뷰(인라인 View) : 가상의 table
select department_id,department_name
from departments
where location_id=1700;

--인라인뷰를 이용하여 from 절에 서브쿼리를 쓸 수 있다.
--join으로 풀 수 밖에 없었던 위의 예제를 from절에 서브쿼리를 써서 풀 수 있다.
--from절의 부질의
select e.department_id,e.first_name,e.department_id,d.department_name
from employees e,(select department_id,department_name
                  from departments
                  where location_id=1700)d
where e.department_id=d.department_id;
--**가상의 table d랑 employees랑 join한 것

--'Kevin'보다 급여를 많이 받는 사원의 사번,이름,급여
select employee_id,first_name,salary
from employees
where salary>(select salary
              from employees
              where lower(first_name)=lower('kevin'));
              
--50번 부서에 있는 사원들 보다 급여를 많이 받는 사원의 사번,이름,급여
select employee_id,first_name,salary
from employees
where salary > all(select salary
               from employees
               where department_id=50);
               
--부서에 근무하는 사원들의 평균급여보다 많이 받는 사원의 사번,이름,급여
select employee_id,first_name,salary
from employees 
where salary>(select avg(salary)
              from employees
              where department_id is not null);
--employee중 부서가 없는 사람은 제외해야하기 때문에 department_id is not null을 붙여야한다.        

--부서번호가 20번의 평균급여보다 크고
--부서장인 사원으로 부서번호가 20이 아닌 사원의
--사번,이름,급여,부서번호
select e.employee_id,e.first_name,e.salary,e.department_id
from (select employee_id,first_name,salary,department_id
      from employees
      where salary>(select avg(salary)
                    from employees
                    where department_id=20))e
     ,departments d
where e.employee_id=d.manager_id
and d.department_id<>20;

--select절의 부질의
--select 절에 쓰는 서브쿼리는 꼭 단일 행 단일 열이어야한다.
--20번 부서의 평균급여
--50번 부서의 급여총합
--80번 부서의 인원수
--select 절에 쓰는 서브쿼리는 꼭 단일 행 단일 열이어야 한다.
select
(select avg(salary) from employees where department_id=20)avg20,
(select sum(salary) from employees where department_id=50)sum50,
(select count(employee_id) from employees where department_id=80)count50
from dual;

--case,decode 안에도 서브쿼리를 사용 할 수 있다.
--모든 사원의 사번,이름,급여,등급,부서이름
--단 A는 1등금,B는 2등급 ~F는 6등급
select e.employee_id,e.first_name,e.salary,d.department_name,
        decode ((
        select grade_level
        from job_grades
        where e.salary between lowest_sal and highest_sal),
            'A','1등급',
            'B','2등급',
            'C','3등급',
            'D','4등급',
            'E','5등급',
            '6등급')등급
from employees e,departments d
where e.department_id=d.department_id(+);

--문제
--들어온지 30년 넘은 사원의 사원번호와 부서의 이름을 구하시오
select e.employee_id,d.department_name
from departments d,employees e
where d.department_id=e.department_id
and e.employee_id in(select employee_id
                     from employees
                     where to_char(sysdate,'yyyy')-to_char(hire_date,'yyyy')>30);
                     
--united kingdom사는 매니저인 사원의 사원번호와 도시이름을 구하시오.
select e.employee_id,l.city
from employees e,departments d,locations l
where e.employee_id in(select distinct manager_id
                        from employees
                        where manager_id is not null)
and e.department_id=d.department_id
and d.location_id = l.location_id
and l.country_id=(select country_id from countries where country_name='United Kingdom');

--조원문제
--'Southlake'에 근무하는 사원의
--사번,이름,부서번호,부서이름
select e.employee_id,e.first_name,e.department_id,d.department_name
from employees e, departments d
where e.department_id=d.department_id
and d.location_id=(select location_id from locations where city='Southlake');

select e.employee_id,e.first_name,e.department_id,d.department_name
from employees e,(select department_id,department_name
                  from departments
                  where location_id =(select location_id
                                      from locations
                                      where city ='Southlake')) d
where e.department_id=d.department_id;

--'Executive'부서에 속한 사원 중에서 직무 변동이 없었던 사원들의
--사원번호,이름,급여,급여 등급을 출력하라
--단, join은 1회만 사용한다.
select e.employee_id,e.first_name,e.salary,
        (select jg.grade_level
        from job_grades jg
        where e.salary between jg.lowest_sal and jg.highest_sal)급여등급
from employees e, departments d
where e.department_id =d.department_id
and d.department_name='Executive'
and e.employee_id not in(select distinct jh.employee_id
                         from job_history jh);