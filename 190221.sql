--sql: db안에 있는 데이터들을 수정, 삭제, 입력 등 함
--rdbms: 관게형 데이터베이스 관리 시스템
--------------------------------------------------------------
--검색문
--형식)풀형식
--select 
--from 
--where 
--group by
--having
--order by
--------------------------------------------------------------
--단순검색
--모든 사원의 모든정보
select *
from employees;

--사원의 사번, 이름, 급여
select employee_id,first_name,salary
from employees;

--부서번호(employees table 기준)
select department_id
from employees;

--test table
select 1+1,10-5,2*10,10/3
from dual;

--사번,이름,급여,200인상급여
select employee_id,first_name,salary,salary+200
from employees;

--사번,이름,급여,커미션포함급여
select employee_id,first_name,salary,salary+salary*commission_pct
from employees;
--**database null은 알수없다 라는 뜻이다.
--그렇기에 커미션이 null인 row는 커미션 포함 급여 또한 null로 나온다.

--사번,이름,급여,커미션포함급여
select employee_id,first_name,salary,commission_pct,salary+salary*nvl(commission_pct,0)
from employees;

--별칭만들기 사번,이름,급여,커미션포함급여
select employee_id 사번,first_name 이름,salary "급여",salary+salary*nvl(commission_pct,0)"커미션 포함급여"
from employees;

--사번,이름(풀네임)
select employee_id,first_name || last_name name
from employees;

--사번이 100인 사원의 이름은 Stecen King 입니다. (info)
select '사번이' || employee_id || '인 사원의 이름은' || first_name ||' '||last_name||'입니다.' info
from employees;

-------------------
--문제
--jobs테이블에서 직무 이름과 최소급여,최대급여,평균급여를 출력하고 평균급여의 별칭을 평균 급여로 하시오.
--평균급여는 최소급여와 최대급여의 평균값으로 한다.
select job_title,min_salary,max_salary,(min_salary+max_salary)/2 "평균 급여"
from jobs;

--locations 테이블에서 전체주소를 출력하고 별칭을 주소로 하시오. 
--전체주소 : street_address,city,country_ID
select street_address||', '||city||', '||country_id 주소
from locations;










