
select *
from member m, member_detail d
where m.id=d.id;
--모든 테이블 이름과 타입 등을 검색
select * from tab;


--insert
select *
from emp_blank;
--내가 입력하고 싶은 것은 values를 쓰고
--기존에 있는 데이터를 쓰고 싶다면 select 절을 이용
select *
from employees
where department_id=80;

insert into emp_blank
select *
from employees
where department_id=80;

--100번 사원의 사번,이름,이메일,고용날짜,직책,부서번호
--emp_blank 삽입
insert into emp_blank (employee_id,first_name,last_name,email,hire_date,job_id,department_id)
select employee_id,first_name,last_name,email,hire_date,job_id,department_id
from employees 
where employee_id=100;
--기존에 있는 table을 가져오게 되면 그 테이블의 제약조건도 그대로 가져오게 된다.
--select해서 data 가져오는 것은 상관없음

select *
from emp_blank;

------------------------------------------------------
--휴지통비우기:drop table을 하고도 남아있는 찌꺼지 지우기
purge recyclebin;

commit;
rollback;
--update
--update,delete는 조심해서 다뤄야한다. 잘못하면 모든 row의 값이 바뀔 수 있음.
update member
set pass = 9876;;----이렇게 하면 모든 비번이 다 바뀜

update member
set pass = 9876
where id='oracle2';

--'oracle2'의 비번을 1234로 나이 25변경
--두개 이상을 바꾸고 싶다면 ,로 연결
update member
set pass = '1234',age=25
where id='oracle2';

--'oracle2'의 비번을 5678로 나이는 아이디가 oracle인 사람과 같게 변경
--서브쿼리는 update에 사용 가능하다
update member
set pass = '5678',age =(select age from member where id='oracle')
where id='oracle2';

--예제
update member
set pass = 87654321 
where id in (select id from member_detail where address like '%구로%');

select *
from member;
--id는 못바꾼다.
--member 테이블에서 id를 바꾸려 한다면 member_detail에서 id를 참조하고 있기 때문에 바꾸지 못한다.
--반대로 member_detail에서 바꾸려 한다면 member_detail은 member의 id 값을 참조하고 있는데 그 밖의 값으로 바꾸려 한다면 바꾸지 못한다.
--id가 참조하고 있지 않고 혼자만 있다면 변경 가능 but primary key는 바꾸지 않는 것이 좋다.
commit;

-------------------------------------------------------------------------------
--delete
delete member; --오류남 delete는 삭제에 순서가 있다.

delete member_detail;
delete member; --이렇게는 지울 수 있지만 모든 데이터가 지워진다.
rollback;
--where 절을 사용하여 지울 수 있다.
delete member_Detail
where id='oracle2';
delete member
where id ='oracle2';

select *
from member;
--delete 절에도 서브쿼리가 가능하다.
--delete [from] member; 식으로 from을 집어넣어도 됨
--insert all은 있지만 update all,delete all은 안됨

-----------------------------------------------------------------------------
--merge 
--table을 생성할 때는 drop을 먼저 해주는 것이 좋음.
drop table product;

create table product
(
    pid number,
    pname varchar2(10),
    cnt number,
    price number,
    constraint product_pid_pk primary key(pid)
);

insert into product(pid,pname,cnt,price)
values ('100','새우깡',100,1500);

insert into product(pid,pname,cnt,price)
values ('200','꼬북칩',80,2700);

insert into product(pid,pname,cnt,price)
values ('300','빼빼로',120,1000);

select *
from product;

--merge는 알아서 검색도 해주고 update,insert도 할 수 있다.

--상품 코드가 400인 자갈치(1200원) 150개 입고
--using 다음에는 서브쿼리,테이블이름, 뷰이름이 나올 수 있다
merge into product
using dual
on (pid=400)
when matched then --이 조건이 만족한다면
update  --update 다음엔 테이블 이름 나올 필요 없다.
set cnt = cnt + 150
when not matched then
insert (pid,pname,cnt,price)--insert into table이름 할 필요 없다
values(400,'자갈치',150,1200);

--상품 코드가 100인 새우깡(1500원) 50개 입고
merge into product
using dual
on (pid=100)
when matched then --이 조건이 만족한다면
update  --update 다음엔 테이블 이름 나올 필요 없다.
set cnt = cnt + 50
when not matched then
insert (pid,pname,cnt,price)--insert into table이름 할 필요 없다
values(100,'새우깡',50,1500);

select *
from product;

commit;


-----------------------------------------------------------------------------------------------------------
select *
from product;

update product
set cnt=800
where pid=100;
rollback;
commit;
--------------------------------------------------------------------
insert into product
values(101,'조개깡',150,1500);

insert into product
values(102,'문어깡',250,1500);

insert into product
values(103,'고래깡',55,1500);

savepoint a;

insert into product
values(104,'한우깡',58,1500);

insert into product
values(105,'돼지깡',120,1500);

savepoint b;

insert into product
values(106,'버섯깡',120,1500);

insert into product
values(107,'차돌깡',220,1500);

select *
from product;


--rollback은 최종적으로 한 commit 다음까지 되돌아간다.
--savepoint 깃발
--rollback할때 어디까지 갈 지 가능
rollback to b;
--commit 전까지 돌아가는게 아니라 savepoin b로 돌아간다
--완벽히 완료됬다고 생각했을 때는 commit을 한다.
--commit,rollback,savepoint 세가지를 두고 트렌젝션 한다고 한다.



-----------------------------------------------------------
--sequence : 일련번호 생성할때 씀
create sequence product_pid_seq  -------table이름_프라이머리키_seq : 시퀀스이름
start with 1 increment by 1;

delete product;

commit;

insert into product (pid,pname,cnt,price)
values (product_pid_seq.nextval,'이름',10,1000);-----다음값을 얻어와라

select *
from product;

select product_pid_seq.nextval
from dual;
--다음 숫자가 궁금할때
--다시 insert 하면 4가 아니라 5로 넘어간다.
--sequence는 실행시킨 순간 숫자가 올라가버린다.

select max(pid)+1 from product;

rollback;
insert into product (pid,pname,cnt,price)
values (product_pid_seq.nextval,'이름',10,1000);

select *
from product;
--sequence는 data가 아니다 object 다. 따라서 sequence는 다시 rollback이 안된다. 전진가능 후진불가능
--트렌젝션은 dml에서만 된다. create로 만든것은 트렌젝션으로 처리가 안된다.

select product_pid_seq.nextval,product_pid_seq.nextval,product_pid_seq.currval
from dual;

select product_pid_seq.currval,product_pid_seq.nextval,product_pid_seq.currval
from dual;

