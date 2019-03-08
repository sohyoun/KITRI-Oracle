-- ���̺� ����

--------------------- * �Ϲ������� 8�� ����� �����
---------------------- * ���̺��� �̸��̳� �÷��� �̸��� ���ڷ� ������ �� ����
---------------------- * Ư�����ڴ� _ �̿ܿ��� ������� �� ��
---------------------- * ���������� ���� ���̺��� ������� ����
---------------------- * ���̺��� ����� ���ﶧ���� ������ ����

-- ȸ�� (�ʼ��Է� ����) member
--  �̸�              name            varchar2(30)
--  ���̵�            id              varchar2(16)
--  ��й�ȣ          pass            varchar2(16)
--  ����              age             numbere(3)
--  �̸��Ͼ��̵�      emailid         varchar2(30)
--  �̸��ϵ�����      emaildomain     varchar2(30)
--  ������            joindate        date

-- ȸ�� ������ (�ΰ��Է� ����) member_detail
--  ���̵�            id              varchar2(16)
--  �����ȣ          zipcode         varchar2(5)   ----------- number�� ������ 01247�� ��� 1247�� �Ǿ����
--  �Ϲ��ּ�          address         varchar2(100)
--  ���ּ�          address_detail  varchar2(100)
--  ��ȭ��ȣ1         tel1            varchar2(3)
--  ��ȭ��ȣ2         tel2            varchar2(4)
--  ��ȭ��ȣ3         tel3            varchar2(4)

create table member
(
    name varchar2(30) not null, ----- ���߿� ������ ���� ��� ���� �̸��� ������ �ʿ䰡 ���� ������ �÷��� �ٷ� �������� �Է��� ����
    id varchar2(16),
    pass varchar2(16) not null,
    age number(3) check (age < 150),
    emailid varchar2(30),
    emaildomain varchar2(30),
    joindate date default sysdate,   ----------- �⺻�� ����
    constraint member_id_pk primary key (id)    ---- ���� �÷��� ������Ÿ�� �����ٰ� primary key��� �Է��ص� ������,
);                                           ----------- �׷��� primary key �̸��� �ڵ����� ������ �Ǿ�����⿡ ���� �̸��� ������ �ִ°���

create table member_detail
(
    id varchar2(16),
    zipcode varchar2(5),
    address varchar2(100),
    address_detail varchar2(100),
    tel1 varchar2(3),
    tel2 varchar2(4),
    tel3 varchar2(4),
    constraint member_detail_id_fk foreign key (id) references member (id)  -- fk���������� �ɾ��� ������ �� ���̺� �����ϱ� ���� ���� �����ϸ� ���� ��
);




-- ���̺� ����

drop table member;

drop table member_detail;


-- subquery�� ���̺� �����    -- dba�� db �׽�Ʈ �� �� ������ �����. �׳� �̷��� �ִٰ� �˾Ƶ� ��

create table emp_all
as
    select *
    from employees;    ---- ���̺� �����ѰŶ� ��������. �ٵ� ���̺� ����� ����� ���� ����


create table emp_blank
as
    select *
    from employees
    where 1=0;      ---- ���� ���̺� ������ �����ͼ� ���̺� ����


create table emp_50
as
    select e.employee_id eid, e.first_name name, e.salary sal, d.department_name dname  -- ���̺� ������ ��Ī�� �÷��̸��� ��
    from employees e, departments d
    where e.department_id = d.department_id(+)
            and e.department_id = 50;

select *
from emp_50;



-- ������ ���۾� DML

-- insert
insert into member
values ('������', 'kitri', '1234', 31, '8972hj', 'gmail.com', sysdate);    -- �÷� ������� ������ �Է�

insert into member
values ('hong', 'ȫ�浿', '25', 123, '8972hj', 'gmail.com', sysdate);

insert into member (id, name, age, pass, emailid, emaildomain, joindate)    -- �÷� ���� ����
values ('hong', 'ȫ�浿', '25', 123, '8972hj', 'gmail.com', sysdate);

insert into member (id, name, age, pass, emailid, emaildomain, joindate)    -- ���� ���� ��� ����
values ('hong', 'ȫ�浿', 123, sysdate);

insert into member (id, name, pass, joindate) 
values ('hong', 'ȫ�浿', 123, sysdate);   --- primary key �������� ���� ����

insert into member (id, name, pass, joindate)   -- ���� ���� ���ϸ� null ���� �Էµ�
values ('hong2', 'ȫ�浿', 123, sysdate);

select *
from member_detail;

insert into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
values ('kitri', '25085', '����� ��õ�� ����4��', '1018-12', '010', '3761', '6984');

insert into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
values ('kitri4', '25085', '����� ��õ�� ����4��', '1018-12', '010', '3761', '6984');   -- foreign key �������� ���� ����



select *
from member m, member_detail d
where m.id = d.id;


--- �ѹ��� ������ ���̺� insert �ϱ� : insert all

insert into member (id, name, age, pass, emailid, emaildomain, joindate)
values ('oracle', '����Ŭ', '30', a12345678, 'oracle', 'oracle.com', sysdate);

insert into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
values ('oracle', '25085', '����� ���α� ����Ŭ�븮', '����Ŭ ������', '010', '1234', '5678');

insert all
    into member (id, name, age, pass, emailid, emaildomain, joindate)
    values ('oracle', '����Ŭ', '30', a12345678, 'oracle', 'oracle.com', sysdate)
    into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
    values ('oracle', '25085', '����� ���α� ����Ŭ�븮', '����Ŭ ������', '010', '1234', '5678');  -- �����߻�



insert all
    into member (id, name, age, pass, emailid, emaildomain, joindate)
    values ('oracle', '����Ŭ', '30', 'a123456', 'oracle', 'oracle.com', sysdate)
    into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
    values ('oracle', '25085', '����� ���α� ����Ŭ�븮', '����Ŭ ������', '010', '1234', '5678')
select * from dual;


insert all
    into member (id, name, age, pass, emailid, emaildomain, joindate)
    values ('oracle2', '����Ŭ2', '34', 'a1234536', 'oracl4e', 'oracl5e.com', sysdate)
    into member_detail (id, zipcode, address, address_detail, tel1, tel2, tel3)
    values ('oracle2', '25032', '����� ���α� ����Ŭ�븮4', '����Ŭ ����3��', '010', '4234', '5658')
select * from dual;


select *
from member;


-- update



-- delete

--------
commit;

