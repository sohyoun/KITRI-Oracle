-- Case 복습
--사번,이름,부서번호,직원유형
--부서번호 60 개발자
--        90 임원진
--        나머지 비개발자
select employee_id,first_name,department_id,
    case
        when department_id = 60
        then '개발자'
        when department_id = 90
        then '임원진'
        else '비개발자'
    end 직원유형
from employees;

--decode는 equal 비교만 가능하다. ~이상~이하 같은 것은 불가능.
--하지만 훨씬 간단함.
--마지막 '비개발자' 값은 default 값이다.
select employee_id,first_name,department_id,
    decode(department_id,
            60,'개발자',
            90,'임원진',
            '비개발자')직원유형
from employees
order by department_id;


--그룹함수
--회사의 총 사원수, 급여총합,급여평균,최고급여,최저급여
--count():총갯수,sum():합,avg():평균,max():최고값,min():최저값
--stddev():표준편차값,valance():분산값
--**무조건 하나만 나온다.
select count(employee_id),sum(salary),avg(salary),max(salary),min(salary)
from employees;

--그룹함수는 where절에 쓸 수없다. 나중에 서브쿼리를 배우면 가능
--평균급여보다 많이 받는 사원의 사번,이름,급여
select employee_id,first_name,salary
from employees
where salary>avg(salary);