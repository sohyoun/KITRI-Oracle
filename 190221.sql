--sql: db�ȿ� �ִ� �����͵��� ����, ����, �Է� �� ��
--rdbms: ������ �����ͺ��̽� ���� �ý���
--------------------------------------------------------------
--�˻���
--����)Ǯ����
--select 
--from 
--where 
--group by
--having
--order by
--------------------------------------------------------------
--�ܼ��˻�
--��� ����� �������
select *
from employees;

--����� ���, �̸�, �޿�
select employee_id,first_name,salary
from employees;

--�μ���ȣ(employees table ����)
select department_id
from employees;

--test table
select 1+1,10-5,2*10,10/3
from dual;

--���,�̸�,�޿�,200�λ�޿�
select employee_id,first_name,salary,salary+200
from employees;

--���,�̸�,�޿�,Ŀ�̼����Ա޿�
select employee_id,first_name,salary,salary+salary*commission_pct
from employees;
--**database null�� �˼����� ��� ���̴�.
--�׷��⿡ Ŀ�̼��� null�� row�� Ŀ�̼� ���� �޿� ���� null�� ���´�.

--���,�̸�,�޿�,Ŀ�̼����Ա޿�
select employee_id,first_name,salary,commission_pct,salary+salary*nvl(commission_pct,0)
from employees;

--��Ī����� ���,�̸�,�޿�,Ŀ�̼����Ա޿�
select employee_id ���,first_name �̸�,salary "�޿�",salary+salary*nvl(commission_pct,0)"Ŀ�̼� ���Ա޿�"
from employees;

--���,�̸�(Ǯ����)
select employee_id,first_name || last_name name
from employees;

--����� 100�� ����� �̸��� Stecen King �Դϴ�. (info)
select '�����' || employee_id || '�� ����� �̸���' || first_name ||' '||last_name||'�Դϴ�.' info
from employees;

-------------------
--����
--jobs���̺��� ���� �̸��� �ּұ޿�,�ִ�޿�,��ձ޿��� ����ϰ� ��ձ޿��� ��Ī�� ��� �޿��� �Ͻÿ�.
--��ձ޿��� �ּұ޿��� �ִ�޿��� ��հ����� �Ѵ�.
select job_title,min_salary,max_salary,(min_salary+max_salary)/2 "��� �޿�"
from jobs;

--locations ���̺��� ��ü�ּҸ� ����ϰ� ��Ī�� �ּҷ� �Ͻÿ�. 
--��ü�ּ� : street_address,city,country_ID
select street_address||', '||city||', '||country_id �ּ�
from locations;










