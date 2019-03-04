--round(수,자릿수) 반올림 : 자릿수는 소숫점 몇째자리까지 표현하는가.
--자릿수가 0이면 소숫점 0자리까지, 그럼으로 소숫점 첫째자리에서 반올림
--자릿수가 1이면 소숫점 첫째자리까지 표현
--자릿수가 -1이면 소숫점 -1자리까지, 즉 10의자리 까지 표현
select 1234.5438, round (1234.5438), round (1234.5438,0)
        , round (1234.5438,1), round (1234.5438,-1), round (1234.5438,-3)
from dual;
--trunc ( 수 , 자릿수 )내림
select 1234.5438, trunc (1234.5438), trunc (1234.5438,0)
        , trunc (1234.5438,1), trunc (1234.5438,-1)
        , trunc (1234.5438,3), trunc (1234.5438,-3)
from dual;
--floor ( 수 )소숫점 제거 
--trunc는 자릿수를 정해서 내림할수 있지만 floor는 소숫점 제거
select 1234.5438, trunc (1234.5438)
from dual;

--mod(수,수): 나머지연산
select 5+3,5-3,5*3,5/3,mod(5,3)
from dual;
--abs(수) : 절대값
select abs(5),abs(-5),abs(+5)
from dual;


--사원의 사번, 이름, 급여, 커미션포함급여
--커미션 포함 급여는 100의 자리 수로 표현(반올림)
select employee_id,first_name, salary, salary+salary*nvl(commission_pct,0), round(salary+salary*nvl(commission_pct,0),-2)
from employees;


--문자함수

select 'kiTRi',lower('kiTRi'),upper('kiTRi'),initcap('kiTRi'),length('kiTRi')
from dual;

-- full name
--concat은 두 문자열을 연결한다. 두개만 됨!
select employee_id, first_name||' '|| last_name fullname,
     concat(first_name,concat(' ',last_name))
from employees;
--database는 인자값은 1부터 시작!! (0부터 아님)
--substr ( , , )두개나 세개 가능, 한개 안됨 
--2부터 6개 써라(6까지 아님)
--인자값이 하나일때는 시작인덱스 부터 끝까지 얻어옴
--첫번째는 시작인덱스, 두번째는 얻어오는 문자의 갯수
--instr 
--인자값 하나일때는 인자값이 몇번째 자리에 있는지 출력
--인자값이 두개일때는 두번째 인자값의 자리로 부터 첫번째 인자값이 몇번째 있는지 출력
select 'hello oracle !!!',substr('hello oracle !!!',2,6),substr('hello oracle !!!',2),
        instr('hello oracle !!!', 'o'), instr('hello oracle !!!', 'o',6)
from dual;

-- '-'을 기준으로 앞숫자들을 zip1로, 뒷숫자들을 zip2로 묶어라
select '1234-56' zipcode, substr('1234-56',1,instr('1234-56','-')-1) zip1 ,substr('1234-56',instr('1234-56','-')+1) zip2
from dual;

--날짜함수
--sysdate : 오늘 날짜 
--sysdate+3/24 : 지금의 시간에 3시간 더함
--to_char(sysdate+3/24,'yyy-mm-dd hh24:mi:ss'): 지금시간에 3시간 더한것을 날짜시간으로 표현
select sysdate, sysdate+3, sysdate-3,sysdate+3/24, to_char(sysdate+3/24,'yyy-mm-dd hh24:mi:ss')
from dual;

--sysdate : 오늘 날짜 
--months_between(sysdate,sysdate+70): 첫번째~두번째 사이의 달은 몇달인가? 70일은 2.몇 달
--next_dat(sysdate,1) : 오늘 기준으로 일요일은 언제인가(1:일)
--add_months(sysdate,2) : 오늘로부터 2달 후는 언제인가
--last_day(sysdate) : 오늘을 기준으로 달의 마지막 날은 언제인가 (first_day는 없음)
select sysdate, months_between(sysdate,sysdate+28),
        next_day(sysdate,1),add_months(sysdate,2)
        ,last_day(sysdate)
from dual;

--to_char : 숫자를 문자로 바꿔줌
--yyyy:풀연도 , yy: 끝두자리연도
--mm: 달(숫자), mon:2월/JAU ,month:2월/JANUARY
--w:이번 달의 몇번째 주, ww:1년중 몇번째 주,
--d:요일(월:2), dd:한달중 몇번째 날, ddd:1년중 몇번째 날, dy:월/MON, day:월요일/MONDAY
--am/pm:오전/오후 시간, hh: 시간, hh24:24시간기준시간, mi:분, ss:초
select sysdate, to_char(sysdate,'yyyy yy mm mon month w ww d dd ddd day am hh hh24')
from dual;
select sysdate, to_char(sysdate,'mi ss')
from dual;

--round : 반올림, trunc: 내림
--union을 하면 위에 아래 코드 합쳐짐 순서는 마음대로임 위에코드에서 ;찍으면 안됨
select to_char(sysdate,'yyyy mm dd hh24:mi:ss'),
        to_char(round(sysdate),'yyyy mm dd hh24:mi:ss'),
        to_char(round(sysdate,'dd'),'yyyy mm dd hh24:mi:ss'),
        to_char(round(sysdate,'mm'),'yyyy mm dd hh24:mi:ss'),
        to_char(round(sysdate,'yy'),'yyyy mm dd hh24:mi:ss'),
        to_char(round(sysdate,'hh'),'yyyy mm dd hh24:mi:ss'),
        to_char(round(sysdate,'mi'),'yyyy mm dd hh24:mi:ss')
from dual
union
select to_char(sysdate,'yyyy mm dd hh24:mi:ss'),
        to_char(trunc(sysdate),'yyyy mm dd hh24:mi:ss'),
        to_char(trunc(sysdate,'dd'),'yyyy mm dd hh24:mi:ss'),
        to_char(trunc(sysdate,'mm'),'yyyy mm dd hh24:mi:ss'),
        to_char(trunc(sysdate,'yy'),'yyyy mm dd hh24:mi:ss'),
        to_char(trunc(sysdate,'hh'),'yyyy mm dd hh24:mi:ss'),
        to_char(trunc(sysdate,'mi'),'yyyy mm dd hh24:mi:ss')
from dual;

--변환함수
--숫자 3은 오른쪽정렬/문자'3'은 왼쪽정렬
--'3'+5
--오라클에서 +는 산술연산밖에 안됨. 문자열 더하는 것은 ||씀
--따라서 자동으로 숫자로 변환 -->'자동형변환'이라고 부름
select 'a',3,'3',3+5,'3'+5
from dual;
--숫자를 문자열로 바꾸기
--1000의자리마다 ,찍으려면 문자열로 만들어줘야함
--000,000,000.00으로 하면 자동으로 반올림되고 1000의 자리마다 ,가 찍히고 앞에 공백은 00이 된다. 
--999,999,999.99으로 하면 0으로 했을때와 같지만 공백이 00이 아니라 비어져있다.문자열 길이는 00으로 했을 때와 같다.
--앞에 L을 붙이면 원화(지역화폐)가 되고 $를 붙이면 달러가 됨
select 1123456.789,
        to_char(1123456.789,'000,000,000.00'),
        to_char(1123456.789,'999,999,999.99')
from dual;
--문자열을 숫자로 바꾸기
--'123,456.98'+3은 안됨->, 가 들어가면 문자열이기 때문
--to_number을 사용하여 문자열을 숫자로 바꿈
--to_number('123,456.98','000,000.00')에서 00을 앞의 숫자 자릿수와 똑같이 만들어주는 것이 좋음. 더 많거나 적으면 안됨
select '123,456.98',to_number('123,456.98','000,000.00')+3
from dual;

select sysdate,to_char(sysdate,'yy.mm.dd')
       ,to_char(sysdate,'am hh:mi:ss')
       ,to_char(sysdate,'hh24:mi:ss')
from dual;

--20190225142154>>날짜>>3일후 구하기
--숫자20190225142154를 to_char를 이용해 문자열로 바꾼다 **숫자에서 날짜로 바로 변환 불가능
--문자열을 to_date를 이용해 날짜로 바꾼다. 이때 년월날시분초를 지정
--여기에 +3을 해서 3일 후를 만든 후 to_char를 이용하여 원하는 문자열(시간표현)으로 만든다.
select 20190225142154,to_char(20190225142154,'00000000000000')
from dual;
select 20190225142154,to_date(to_char(20190225142154,'00000000000000'),'yyyymmddhh24miss')+3
from dual;
select 20190225142154,to_char(to_date(to_char(20190225142154,'00000000000000'),'yyyymmddhh24miss')+3,'yyyy.mm.dd hh24:mi:ss')
from dual;

--일반함수
--nvl,nvl2
--nvl(A,0)A의 null자리를 0으로 대체
--nvl2(A,1,0)A이 null이 아니면 1로, null이면 0으로 대체
select commission_pct,nvl(commission_pct,0),nvl2(commission_pct,1,0)
from employees;

--CASE:~라면/when/then/else/END\
--급여가 4000미만인 사원은 저연봉
--      10000미만은      평균연봉
--      10000이상은      고연봉
select employee_id,first_name,salary,
        case
            when salary<4000
            then '저연봉'
            when salary<10000
            then '평균연봉'
            else '고연봉'
        end
from employees
order by salary desc;
--**4000미만은 이미 처음에서 걸려졌기 때문에 두번째에서 4000<salary<10000이 아닌 그냥 <10000

--사원구분
--1980년도 입사  임원
--  90          평사원
--2000          신입사원
--사번,이름,입사일,사원구분
select employee_id, first_name,hire_date,
        case
            when to_number(to_char(hire_date,'yyyymmdd'),'00000000')>20000000
            then '신입사원'
            when to_number(to_char(hire_date,'yyyymmdd'),'00000000')>19900000
            then '평사원'
            when to_number(to_char(hire_date,'yyyymmdd'),'00000000')>19800000
            then '임원'
        end
from employees
order by hire_date;
--아스키코드값
select ascii('0'),ascii('A'),ascii('a'),chr(47)
from dual;

select case when 'abc'<'acd' then '작다'
            else '크다'
        end
from dual;

select  employee_id, first_name,hire_date,
        case
            when substr(to_char(trunc(hire_date,'yyyy'),'yyyy'),1,3)='198'
            then '임원'
        end
from employees;

select employee_id,first_name,hire_date,
        case
            when to_char(trunc(hire_date,'yyyy'),'yyyy')<1990
            then '임원'
        end
from employees;



--예제
--지역ID,국가ID,도시,대륙을 출력하시오.(북미(캐나다,미국)/서유럽(영국)/동유럽(독일))
--별칭을 위에 지정한 것으로 할 것
select location_id 지역ID,country_id 국가ID ,city 도시,
        case
            when country_id='US' or country_id='CA'
            then '북미'
            when country_id='UK'
            then '서유럽'
            else '동유럽'
        end 대륙
from locations;
--직원의 ID, 이름, 전화번호, 통신사를 출력하시오.
--직원의 전화번호가 5로 시작하면 통신사를 SKT, 6으로 시작하면 KT,0으로 시작하면 LG 로 지정하시오 
--또한 통신사 별로 정렬하시오
select employee_id,first_name,phone_number,
        case
            when substr(phone_number,1,3) like '5%'
            then 'SKT'
            when substr(phone_number,1,3) like '6%'
            then 'KT'
            else 'LG'
        end 통신사
from employees
order by phone_number;

-- 자기가 태어난 날부터 현재까지 몇일이 지났는지 계산해보기
select floor(months_between(sysdate,to_date(to_char(19950613,'00000000'),'yyyymmdd'))*30)
from dual;

-- 현재시각을 나타내야한다. 
--조건은('현재시각은 오전(오후) 00시 00분 00초 입니다.' 로 출력되어져야하고 12시 이전은 오후, 12시 이후는 오후 이다.
--매 20초, 40초 마다 '안녕하세요.' 라고 출력이 되야한다.)
select '현재시각은 '||to_char(sysdate,'am')||' '||to_char(sysdate,'hh')||'시'||' '
        ||to_char(sysdate,'mi')||'분'||' '||to_char(sysdate,'ss')||'초 입니다.' 현재시간,
        case
            when to_char(sysdate,'ss')='40' or to_char(sysdate,'ss')='20'
            then '안녕하세요.'
        end 안녕
from dual;
-- 문제1. 성과등급
-- 입사일이 1995년 이후인 사원들 중,
--	급여가 5000 미만인 사원은 C
--	급여가 10000 미만인 사원은 B
--	급여가 10000 이상인 사원은 A
-- 직원번호, 이름, 입사일, 급여, 성과등급을 출력하고, 성과등급을 내림차순으로 정렬하라
select employee_id,first_name,hire_date,salary,
        case
                     when salary<5000
                     then 'C'
                     when salary<10000
                     then 'B'
                     else 'A'
        end 성과등급
from employees
where to_char(hire_date,'yyyy')>=1995
order by 성과등급 desc;

-- 문제2. 근속년수가 올해로 20년 이상 25년 이하인 사람들에게 보너스를 지급할 예정이다. 다음과 같은 기준으로 보너스를 산정하라.
--	급여가 5000 미만인 사람은 30%
--	급여가 10000 미만인 사람은 20%
--	급여가 10000 이상인 사람은 10%
-- 급여는 커미션을 포함한 것으로 계산하며, 근속년수는 연단위로 계산한다(월,일은 고려하지 않음).
-- 직원번호, 이름, 입사일, 커미션을 포함한 급여, 보너스를 출력하고, 보너스를 내림차순으로 정렬하라.
select employee_id,first_name,hire_date,salary+salary*nvl(commission_pct,0)커미션포함급여,
        case
            when salary<5000
            then (salary+salary*nvl(commission_pct,0))*0.3
            when salary<10000
            then (salary+salary*nvl(commission_pct,0))*0.2
            else (salary+salary*nvl(commission_pct,0))*0.1
        end 보너스
from employees
where to_char(sysdate,'yyyy')-to_number(to_char(hire_date,'yyyy'),'0000') between 20 and 25;

--사원번호, 사원이름, 입사일,입사월 마지막날짜,입사일 다음 일요일의 날짜, 입사 후 100일의 날짜를 검색하라
select employee_id,first_name,hire_date,to_char(last_day(hire_date),'dd'),next_day(hire_date,1),hire_date+100
from employees;
--사원들의 이름을 풀네임으로 작성하라(concat이용하고 이름사이에 공백넣기)
select concat(first_name,concat(' ',last_name))
from employees;
--고용된 날짜가 사원들의 생년월일이라고 가정하고 사원들의 풀네임과 생년월일, 현재나이대(2019년 기준)를 구하시오. 
--나이대는 20대 30대 40대로 구성할 것, 그리고 별칭은 '나이대'로 설정
select concat(first_name,concat(' ',last_name)),hire_date,
        case 
            when 2019-to_char(hire_date,'yyyy')+1 <30
            then '20대'
            when 2019-to_char(hire_date,'yyyy')+1 <40
            then'30대'
            else '40대'
        end 나이대
from employees;