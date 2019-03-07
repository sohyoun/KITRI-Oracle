--where
--�񱳿����� 
--�޿��� 5000�̻� �޴� ����� ���, �̸�, �޿�,�μ���ȣ
select employee_id,first_name, salary, department_id
from employees
where salary>=5000;

--�μ���ȣ�� 50�� �ƴ� ����� ���, �̸�, �μ���ȣ
select employee_id,first_name, department_id
from employees
where department_id !=50;

select employee_id,first_name,department_id
from employees
where department_id ^=50;

select employee_id, first_name, department_id
from employees
where department_id <>50;

--�����ʹ� ��ҹ��� ������
--�ٹ����ð� seattle�� ������ ������ȣ, �����ȣ, ����
select location_id,postal_code,city
from locations
where city = 'Seattle';

--between
select employee_id,first_name,salary, department_id
from employees
where salary between 5000 and 12000;

--��������
--and
--�޿��� 5000�̻� 12000�̸� �޴� ����� ���, �̸�, �޿�, �μ���ȣ
select employee_id, first_name, salary, department_id
from employees
where salary >= 5000 and salary <12000;

--or
--�ٹ��μ��� 50,60,80�� ����� ���,�̸�,�μ���ȣ
select employee_id, first_name, department_id
from employees
where department_id = 50 or department_id = 60 or department_id = 80;

--not A
--�ٹ��μ��� 50,60,80�� �ƴ� ����� ���, �̸�, �μ���ȣ
select employee_id,first_name,department_id
from employees
where department_id != 50 and department_id != 60 and department_id != 80 or department_id is null;

--A is null
--Ŀ�̼��� �޴� ����� ���, �̸�, �޿�, Ŀ�̼����Ա޿�
select employee_id, first_name,salary,salary*(1+commission_pct)
from employees
where commission_pct is not null;

--in
-- in (A, B, C) : A, B, C �� �ϳ��� ���� �� / not in (A, B, C) : A, B, C ��� �ƴ� ��
--�ٹ��μ��� 50,60,80�� ����� ���,�̸�,�μ���ȣ
select employee_id,first_name,department_id
from employees
where department_id in (50,60,80);

--�񱳿����� any (A, B, C) : A, B, C �� �ϳ��� �����ϴ� ��
--* �ش� column�� ��ȣ ���� ������ ���� �񱳿����ڿ� ���� ��. or�� ������ ��� �� ��� ���!
--* �񱳿����ڿ� =�� ������ in�̶� ���� ��� ����. ���� any �� �� ���� in ����ϸ� ��
--�޿��� 3000�̻��̰ų� , 8000�̻��̰ų� 5000�̻��� ����� ���,�̸�,�޿�
select employee_id,first_name,salary
from employees
where salary>= any(3000,8000,5000);

--�񱳿����� all (A, B, C) : A, B, C ��� �����ϴ� ��
--�ش� column�� ��ȣ ���� ������ ���� �񱳿����ڿ� ���� ��. and�� ������ ��� �� ��� ���!
--�޿��� 3000�̻��̰� 8000�̻��̰� 5000�̻��� ����� ���,�̸�,�޿�
select employee_id,first_name,salary
from employees
where salary >=all(3000,8000,5000);

-- like A : A ����
--   ���ϵ�ī�� ���� - % : 0�� �̻��� ���� ('sh%' ó�� �տ� ���ڿ��� �͵� �������)
--                 -  _ : 1���� ����
--�̸��� 'S'�� �����ϴ� ����� ���,�̸�
select employee_id,first_name
from employees
where first_name like 'S%';

--�̸��� 'e'�� �����ϰ� �ִ� ����� ���,�̸�
select employee_id,first_name
from employees
where first_name like '%e%';

--�̸��� 'y'�� ������ ����� ���,�̸�
select employee_id,first_name
from employees
where first_name like '%y';

--�̸��� ������ ����°�� 'e'�� ����� ���,�̸�
select employee_id,first_name
from employees
where first_name like '%e__';

--���ϵ�ī�� ���ڸ� ����� ���� = �����ڸ� ������� ����
--�̸� ������ �ι�°�� 'e'�� ����� ���,�̸�
select employee_id,first_name
from employees
where first_name = '%e_';

--��¥�� �������
-- sysdate : �ý��� ��¥ (�ð��� ������)
-- to_char(sysdate, 'yy.mm.dd hh24:mi:ss') : �ð����� ��µǵ����ϴ� �Լ�
--���� �ð�, 3����, 3�ð� ��
select sysdate,to_char(sysdate,'yy.mm.dd.hh24:mi:ss')"���� �ð�",
        to_char(sysdate + 3,'yy.mm.dd hh24:mi:ss')"3����",
        to_char(sysdate + 3/24,'yy.mm.dd hh24:mi:ss')"3�ð� ��",
        to_char(sysdate - 3,'yy.mm.dd hh24:mi:ss')"3����",
        to_char(sysdate - 3/1440,'yy.mm.dd hh24:mi:ss')"3����"
from dual;

--����_�ټӳ�� ���ϱ�
--* �ټӳ�� ���ϱ�
select to_char(sysdate,'yyyy')-to_char(hire_date,'yyyy')�ټӳ��
from employees;

--order by
--�⺻����
--    order by colNumber | colName | alias [asc | desc]        * asc : �������� / desc : �������� (�⺻�� : asc)
--�÷��� ���ڷ� ��Ī�ϴ� ��쿡�� �÷��� �߰��Ǵ� ��� �ٷ� �ݿ����� �ʱ⿡ �� ���� ����. ���� ���� ���̴� �� �÷� �̸�
--��� ����� ���,�̸�,�޿�
--�� �޿�������
select employee_id,first_name,salary
from employees
order by salary desc;

--��Ī(alias)���� ����� ���� ����
select department_id did, employee_id,first_name,salary sal
from employees
order by did,sal desc;

-- colName/ colNumber �� �ĸ��� �����Ͽ� ���� ������ �������� �߰��� �� ����
--�μ���ȣ ���,�̸�,�޿�
--�μ��� �޿������� ����
select department_id,employee_id,first_name,salary
from employees
order by department_id,salary desc;