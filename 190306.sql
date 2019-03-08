
select *
from member m, member_detail d
where m.id=d.id;
--��� ���̺� �̸��� Ÿ�� ���� �˻�
select * from tab;


--insert
select *
from emp_blank;
--���� �Է��ϰ� ���� ���� values�� ����
--������ �ִ� �����͸� ���� �ʹٸ� select ���� �̿�
select *
from employees
where department_id=80;

insert into emp_blank
select *
from employees
where department_id=80;

--100�� ����� ���,�̸�,�̸���,��볯¥,��å,�μ���ȣ
--emp_blank ����
insert into emp_blank (employee_id,first_name,last_name,email,hire_date,job_id,department_id)
select employee_id,first_name,last_name,email,hire_date,job_id,department_id
from employees 
where employee_id=100;
--������ �ִ� table�� �������� �Ǹ� �� ���̺��� �������ǵ� �״�� �������� �ȴ�.
--select�ؼ� data �������� ���� �������

select *
from emp_blank;

------------------------------------------------------
--���������:drop table�� �ϰ� �����ִ� ��� �����
purge recyclebin;

commit;
rollback;
--update
--update,delete�� �����ؼ� �ٷ���Ѵ�. �߸��ϸ� ��� row�� ���� �ٲ� �� ����.
update member
set pass = 9876;;----�̷��� �ϸ� ��� ����� �� �ٲ�

update member
set pass = 9876
where id='oracle2';

--'oracle2'�� ����� 1234�� ���� 25����
--�ΰ� �̻��� �ٲٰ� �ʹٸ� ,�� ����
update member
set pass = '1234',age=25
where id='oracle2';

--'oracle2'�� ����� 5678�� ���̴� ���̵� oracle�� ����� ���� ����
--���������� update�� ��� �����ϴ�
update member
set pass = '5678',age =(select age from member where id='oracle')
where id='oracle2';

--����
update member
set pass = 87654321 
where id in (select id from member_detail where address like '%����%');

select *
from member;
--id�� ���ٲ۴�.
--member ���̺��� id�� �ٲٷ� �Ѵٸ� member_detail���� id�� �����ϰ� �ֱ� ������ �ٲ��� ���Ѵ�.
--�ݴ�� member_detail���� �ٲٷ� �Ѵٸ� member_detail�� member�� id ���� �����ϰ� �ִµ� �� ���� ������ �ٲٷ� �Ѵٸ� �ٲ��� ���Ѵ�.
--id�� �����ϰ� ���� �ʰ� ȥ�ڸ� �ִٸ� ���� ���� but primary key�� �ٲ��� �ʴ� ���� ����.
commit;

-------------------------------------------------------------------------------
--delete
delete member; --������ delete�� ������ ������ �ִ�.

delete member_detail;
delete member; --�̷��Դ� ���� �� ������ ��� �����Ͱ� ��������.
rollback;
--where ���� ����Ͽ� ���� �� �ִ�.
delete member_Detail
where id='oracle2';
delete member
where id ='oracle2';

select *
from member;
--delete ������ ���������� �����ϴ�.
--delete [from] member; ������ from�� ����־ ��
--insert all�� ������ update all,delete all�� �ȵ�

-----------------------------------------------------------------------------
--merge 
--table�� ������ ���� drop�� ���� ���ִ� ���� ����.
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
values ('100','�����',100,1500);

insert into product(pid,pname,cnt,price)
values ('200','����Ĩ',80,2700);

insert into product(pid,pname,cnt,price)
values ('300','������',120,1000);

select *
from product;

--merge�� �˾Ƽ� �˻��� ���ְ� update,insert�� �� �� �ִ�.

--��ǰ �ڵ尡 400�� �ڰ�ġ(1200��) 150�� �԰�
--using �������� ��������,���̺��̸�, ���̸��� ���� �� �ִ�
merge into product
using dual
on (pid=400)
when matched then --�� ������ �����Ѵٸ�
update  --update ������ ���̺� �̸� ���� �ʿ� ����.
set cnt = cnt + 150
when not matched then
insert (pid,pname,cnt,price)--insert into table�̸� �� �ʿ� ����
values(400,'�ڰ�ġ',150,1200);

--��ǰ �ڵ尡 100�� �����(1500��) 50�� �԰�
merge into product
using dual
on (pid=100)
when matched then --�� ������ �����Ѵٸ�
update  --update ������ ���̺� �̸� ���� �ʿ� ����.
set cnt = cnt + 50
when not matched then
insert (pid,pname,cnt,price)--insert into table�̸� �� �ʿ� ����
values(100,'�����',50,1500);

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
values(101,'������',150,1500);

insert into product
values(102,'�����',250,1500);

insert into product
values(103,'����',55,1500);

savepoint a;

insert into product
values(104,'�ѿ��',58,1500);

insert into product
values(105,'������',120,1500);

savepoint b;

insert into product
values(106,'������',120,1500);

insert into product
values(107,'������',220,1500);

select *
from product;


--rollback�� ���������� �� commit �������� �ǵ��ư���.
--savepoint ���
--rollback�Ҷ� ������ �� �� ����
rollback to b;
--commit ������ ���ư��°� �ƴ϶� savepoin b�� ���ư���
--�Ϻ��� �Ϸ��ٰ� �������� ���� commit�� �Ѵ�.
--commit,rollback,savepoint �������� �ΰ� Ʈ������ �Ѵٰ� �Ѵ�.



-----------------------------------------------------------
--sequence : �Ϸù�ȣ �����Ҷ� ��
create sequence product_pid_seq  -------table�̸�_�����̸Ӹ�Ű_seq : �������̸�
start with 1 increment by 1;

delete product;

commit;

insert into product (pid,pname,cnt,price)
values (product_pid_seq.nextval,'�̸�',10,1000);-----�������� ���Ͷ�

select *
from product;

select product_pid_seq.nextval
from dual;
--���� ���ڰ� �ñ��Ҷ�
--�ٽ� insert �ϸ� 4�� �ƴ϶� 5�� �Ѿ��.
--sequence�� �����Ų ���� ���ڰ� �ö󰡹�����.

select max(pid)+1 from product;

rollback;
insert into product (pid,pname,cnt,price)
values (product_pid_seq.nextval,'�̸�',10,1000);

select *
from product;
--sequence�� data�� �ƴϴ� object ��. ���� sequence�� �ٽ� rollback�� �ȵȴ�. �������� �����Ұ���
--Ʈ�������� dml������ �ȴ�. create�� ������� Ʈ���������� ó���� �ȵȴ�.

select product_pid_seq.nextval,product_pid_seq.nextval,product_pid_seq.currval
from dual;

select product_pid_seq.currval,product_pid_seq.nextval,product_pid_seq.currval
from dual;

