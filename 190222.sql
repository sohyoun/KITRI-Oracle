--where
--비교연산자 
--급여를 5000이상 받는 사원의 사번, 이름, 급여,부서번호
select employee_id,first_name, salary, department_id
from employees
where salary>=5000;

--부서번호가 50이 아닌 사원의 사번, 이름, 부서번호
select employee_id,first_name, department_id
from employees
where department_id !=50;

select employee_id,first_name,department_id
from employees
where department_id ^=50;

select employee_id, first_name, department_id
from employees
where department_id <>50;

--데이터는 대소문자 구분함
--근무도시가 seattle인 지역의 지역번호, 우편번호, 도시
select location_id,postal_code,city
from locations
where city = 'Seattle';

--between
select employee_id,first_name,salary, department_id
from employees
where salary between 5000 and 12000;

--논리연산자
--and
--급여를 5000이상 12000미만 받는 사원의 사번, 이름, 급여, 부서번호
select employee_id, first_name, salary, department_id
from employees
where salary >= 5000 and salary <12000;

--or
--근무부서가 50,60,80인 사원의 사번,이름,부서번호
select employee_id, first_name, department_id
from employees
where department_id = 50 or department_id = 60 or department_id = 80;

--not A
--근무부서가 50,60,80이 아닌 사원의 사번, 이름, 부서번호
select employee_id,first_name,department_id
from employees
where department_id != 50 and department_id != 60 and department_id != 80 or department_id is null;

--A is null
--커미션을 받는 사원의 사번, 이름, 급여, 커미션포함급여
select employee_id, first_name,salary,salary*(1+commission_pct)
from employees
where commission_pct is not null;

--in
-- in (A, B, C) : A, B, C 중 하나라도 같은 것 / not in (A, B, C) : A, B, C 모두 아닌 것
--근무부서가 50,60,80인 사원의 사번,이름,부서번호
select employee_id,first_name,department_id
from employees
where department_id in (50,60,80);

--비교연산자 any (A, B, C) : A, B, C 중 하나라도 만족하는 것
--* 해당 column과 괄호 안의 변수를 앞의 비교연산자에 따라 비교. or을 여러번 써야 할 경우 사용!
--* 비교연산자에 =를 넣으면 in이랑 같은 결과 나옴. 굳이 any 쓸 것 없이 in 사용하면 됨
--급여가 3000이상이거나 , 8000이상이거나 5000이상인 사원의 사번,이름,급여
select employee_id,first_name,salary
from employees
where salary>= any(3000,8000,5000);

--비교연산자 all (A, B, C) : A, B, C 모두 만족하는 것
--해당 column과 괄호 안의 변수를 앞의 비교연산자에 따라 비교. and를 여러번 써야 할 경우 사용!
--급여가 3000이상이고 8000이상이고 5000이상인 사원의 사번,이름,급여
select employee_id,first_name,salary
from employees
where salary >=all(3000,8000,5000);

-- like A : A 같은
--   와일드카드 문자 - % : 0개 이상의 문자 ('sh%' 처럼 앞에 문자열이 와도 상관없음)
--                 -  _ : 1개의 문자
--이름이 'S'로 시작하는 사원의 사번,이름
select employee_id,first_name
from employees
where first_name like 'S%';

--이름에 'e'를 포함하고 있는 사원의 사번,이름
select employee_id,first_name
from employees
where first_name like '%e%';

--이름이 'y'로 끝나느 사원의 사번,이름
select employee_id,first_name
from employees
where first_name like '%y';

--이름의 끝에서 세번째가 'e'인 사원의 사번,이름
select employee_id,first_name
from employees
where first_name like '%e__';

--와일드카드 문자를 사용할 때는 = 연산자를 사용하지 않음
--이름 끝에서 두번째가 'e'인 사원의 사번,이름
select employee_id,first_name
from employees
where first_name = '%e_';

--날짜의 산술연산
-- sysdate : 시스템 날짜 (시간도 포함임)
-- to_char(sysdate, 'yy.mm.dd hh24:mi:ss') : 시간까지 출력되도록하는 함수
--현재 시간, 3일후, 3시간 후
select sysdate,to_char(sysdate,'yy.mm.dd.hh24:mi:ss')"현재 시간",
        to_char(sysdate + 3,'yy.mm.dd hh24:mi:ss')"3일후",
        to_char(sysdate + 3/24,'yy.mm.dd hh24:mi:ss')"3시간 후",
        to_char(sysdate - 3,'yy.mm.dd hh24:mi:ss')"3일전",
        to_char(sysdate - 3/1440,'yy.mm.dd hh24:mi:ss')"3분전"
from dual;

--응용_근속년수 구하기
--* 근속년수 구하기
select to_char(sysdate,'yyyy')-to_char(hire_date,'yyyy')근속년수
from employees;

--order by
--기본형태
--    order by colNumber | colName | alias [asc | desc]        * asc : 오름차순 / desc : 내림차순 (기본값 : asc)
--컬럼을 숫자로 지칭하는 경우에는 컬럼이 추가되는 경우 바로 반영되지 않기에 잘 쓰지 않음. 가장 많이 쓰이는 건 컬럼 이름
--모든 사원의 사번,이름,급여
--단 급여순정렬
select employee_id,first_name,salary
from employees
order by salary desc;

--별칭(alias)으로 사용할 수도 있음
select department_id did, employee_id,first_name,salary sal
from employees
order by did,sal desc;

-- colName/ colNumber 를 컴마로 연결하여 정렬 조건을 여러개로 추가할 수 있음
--부서번호 사번,이름,급여
--부서별 급여순으로 정렬
select department_id,employee_id,first_name,salary
from employees
order by department_id,salary desc;