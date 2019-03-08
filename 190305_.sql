-- 테이블 생성

--------------------- * 일반적으로 8의 배수를 사용함
---------------------- * 테이블의 이름이나 컬럼의 이름은 숫자로 시작할 수 없음
---------------------- * 특수문자는 _ 이외에는 사용하지 말 것
---------------------- * 제약조건이 많은 테이블은 권장되지 않음
---------------------- * 테이블을 만들고 지울때에도 순서가 있음

-- 회원 (필수입력 정보) member
--  이름              name            varchar2(30)
--  아이디            id              varchar2(16)
--  비밀번호          pass            varchar2(16)
--  나이              age             numbere(3)
--  이메일아이디      emailid         varchar2(30)
--  이메일도메인      emaildomain     varchar2(30)
--  가입일            joindate        date

-- 회원 상세정보 (부가입력 정보) member_detail
--  아이디            id              varchar2(16)
--  우편번호          zipcode         varchar2(5)   ----------- number로 잡으면 01247의 경우 1247이 되어버림
--  일반주소          address         varchar2(100)
--  상세주소          address_detail  varchar2(100)
--  전화번호1         tel1            varchar2(3)
--  전화번호2         tel2            varchar2(4)
--  전화번호3         tel3            varchar2(4)

create table member
(
    name varchar2(30) not null, ----- 나중에 관리할 일이 적어서 굳이 이름을 설정할 필요가 없기 때문에 컬럼에 바로 제약조건 입력한 것임
    id varchar2(16),
    pass varchar2(16) not null,
    age number(3) check (age < 150),
    emailid varchar2(30),
    emaildomain varchar2(30),
    joindate date default sysdate,   ----------- 기본값 설정
    constraint member_id_pk primary key (id)    ---- 위의 컬럼명 데이터타입 옆에다가 primary key라고 입력해도 되지만,
);                                           ----------- 그러면 primary key 이름이 자동으로 지정이 되어버리기에 따로 이름을 지정해 주는거임

create table member_detail
(
    id varchar2(16),
    zipcode varchar2(5),
    address varchar2(100),
    address_detail varchar2(100),
    tel1 varchar2(3),
    tel2 varchar2(4),
    tel3 varchar2(4),
    constraint member_detail_id_fk foreign key (id) references member (id)  -- fk제약조건을 걸었기 때문에 위 테이블 생성하기 전에 먼저 생성하면 에러 남
);




-- 테이블 삭제

drop table member;

drop table member_detail;


-- subquery로 테이블 만들기    -- dba가 db 테스트 할 때 정도나 사용함. 그냥 이런게 있다고 알아둘 것

create table emp_all
as
    select *
    from employees;    ---- 테이블 복사한거랑 마찬가지. 근데 테이블 복사는 사용할 일이 적음


create table emp_blank
as
    select *
    from employees
    where 1=0;      ---- 기존 테이블 구조만 가져와서 테이블 생성


create table emp_50
as
    select e.employee_id eid, e.first_name name, e.salary sal, d.department_name dname  -- 테이블 생성시 별칭이 컬럼이름이 됨
    from employees e, departments d
    where e.department_id = d.department_id(+)
            and e.department_id = 50;

select *
from emp_50;



-- 데이터 조작어 DML

-- insert
insert into member
values ('정현정', 'kitri', '1234', 31, '8972hj', 'gmail.com', sysdate);    -- 컬럼 순서대로 데이터 입력

insert into member
values ('hong', '홍길동', '25', 123, '8972hj', 'gmail.com', sysdate);

insert into member (id, name, age, pass, emailid, emaildomain, joindate)    -- 컬럼 순서 지정
values ('hong', '홍길동', '25', 123, '8972hj', 'gmail.com', sysdate);

insert into member (id, name, age, pass, emailid, emaildomain, joindate)    -- 값의 수가 적어서 에러
values ('hong', '홍길동', 123, sysdate);

insert into member (id, name, pass, joindate) 
values ('hong', '홍길동', 123, sysdate);   --- primary key 제약조건 위배 에러

insert into member (id, name, pass, joindate)   -- 값을 지정 안하면 null 값이 입력됨
values ('hong2', '홍길동', 123, sysdate);

select *
from member_detail;

insert into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
values ('kitri', '25085', '서울시 금천구 독산4동', '1018-12', '010', '3761', '6984');

insert into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
values ('kitri4', '25085', '서울시 금천구 독산4동', '1018-12', '010', '3761', '6984');   -- foreign key 제약조건 위배 에러



select *
from member m, member_detail d
where m.id = d.id;


--- 한번에 여러개 테이블에 insert 하기 : insert all

insert into member (id, name, age, pass, emailid, emaildomain, joindate)
values ('oracle', '오라클', '30', a12345678, 'oracle', 'oracle.com', sysdate);

insert into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
values ('oracle', '25085', '서울시 구로구 오라클밸리', '오라클 연구소', '010', '1234', '5678');

insert all
    into member (id, name, age, pass, emailid, emaildomain, joindate)
    values ('oracle', '오라클', '30', a12345678, 'oracle', 'oracle.com', sysdate)
    into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
    values ('oracle', '25085', '서울시 구로구 오라클밸리', '오라클 연구소', '010', '1234', '5678');  -- 에러발생



insert all
    into member (id, name, age, pass, emailid, emaildomain, joindate)
    values ('oracle', '오라클', '30', 'a123456', 'oracle', 'oracle.com', sysdate)
    into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
    values ('oracle', '25085', '서울시 구로구 오라클밸리', '오라클 연구소', '010', '1234', '5678')
select * from dual;


insert all
    into member (id, name, age, pass, emailid, emaildomain, joindate)
    values ('oracle2', '오라클2', '34', 'a1234536', 'oracl4e', 'oracl5e.com', sysdate)
    into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
    values ('oracle2', '25032', '서울시 구로구 오라클밸리4', '오라클 연구3소', '010', '4234', '5658')
select * from dual;


select *
from member;


-- update



-- delete

--------
commit;

