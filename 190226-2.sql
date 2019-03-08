--���� �ռ� ������ ������ Ǯ���� �Ѱ谡 �߻��ϰ� �ȴ�.
--���,�̸�,�μ���ȣ,�μ��̸�
--employees ���̺��� �μ��̸��� ���� ������ departments ���̺��� ������ ���ؾ��Ѵ�.
select employee_id,first_name,department_id
from employees;
select department_id,department_name
from departments;

--cross join�� �ߺ��ǰ� ���������� ���� data�� ���´�.
--employees,departments�� ��ġ�� �Ǹ� �ߺ��� �Ǿ� �������� data�� ������ �ʴ´�.
--īŸ�þ� ���δ�Ʈ�� �ȴ�.�� employees�� departmentsƩ���� ������ �� ��ŭ�� data�� �����ȴ�.
select *
from employees,departments
order by employee_id;
--���� Equl JOIN�� �ʿ��ϰ� �ȴ�.

--Equl Join(naturl join):=���� ���ϴ°�
--table�� 2���̻� join�Ѵٸ� table������ �ּ� n-1���� ������ �ɾ���Ѵ�
--'.'�� database���� in�̳� have�� ���� �����ִ�. employees���̺� �ִ� department_id
--�Ʒ��� ����� �� 19���� Ʃ���� ���´�. ���� 20������ 1���� department�� ����.
--primaryŰ�� ����ũ�ϰ� null�� ������ �ȵȴ�. ���� employees���̺��� employee_id�� �����̸Ӹ�Ű�̴�.
select *
from employees,departments
where employees.department_id=departments.department_id
order by employees.employee_id;

--join�� �Ҷ��� �׳� �Ӽ����� �̸��� ���� �Ǹ� ��ȣ���� �� �ֱ� �빮��
--employees.employee_id ó�� table�̸��� �� �ٿ��ִ� ���� ����.
--���̺� �̸��� ��Ī�� �־� e.employee_id ������ �ڵ带 ���� �� �ִ�.
select e.employee_id,e.first_name,d.department_id,d.department_name
from employees e,departments d
where e.department_id=d.department_id
order by e.employee_id;

--'Seattle'�� �ٹ��ϴ� ����� ���,�̸�,�μ��̸�,�����̸�
select e.employee_id,e.first_name,d.department_name,l.city
from employees e,locations l,departments d
where e.department_id=d.department_id
and d.location_id=l.location_id
and lower(l.city)=lower('seattle');
--*City���� Seattle�� ���� �빮���̱� ������ lower�� ������Ѵ�. ���� �� ���ִ� ���� ����.

--'europe'�� �ٹ��ϴ� ����̸�,�μ��̸�,�����̸�
select e.first_name,d.department_name,l.city
from employees e,departments d,locations l,countries c,regions r
where e.department_id=d.department_id
and d.location_id = l.location_id
and l.country_id = c.country_id
and c.region_id=r.region_id
and lower(r.region_name)=lower('europe');

--�������� d.department_id�� �ƴ϶� e.department_id�̾���Ѵ�.
--10,80,90,�� �μ��� �ٹ����� ����� ã�� ���̱� ����
--10,80,90�� �μ��� �ٹ����� �����
--���,�̸�,��å�̸�,�μ��̸�
select e.employee_id,e.first_name,j.job_title,d.department_name
from employees e, departments d,jobs j
where e.job_id=j.job_id
and e.department_id=d.department_id
and e.department_id in(10,80,90);

--self join
--������� �μ��̸�,���,�̸�,�Ŵ������,�Ŵ����̸�
select d.department_name,e.employee_id,e.first_name,e.manager_id,employees.first_name
from employees e,departments d,employees
where e.department_id=d.department_id
and employees.employee_id=e.manager_id
order by d.department_name;

--����
--�ּҿ����� 10000�� �Ѵ� ��å�� ����� �����ȣ,�̸�,����,��å�̸�,�μ��̸�
select e.employee_id,e.first_name,e.salary,j.job_title,d.department_name
from employees e, jobs j,departments d
where e.department_id=d.department_id
and e.job_id=j.job_id
and j.min_salary>10000;

--���,�̸�,�Ŵ������,�Ŵ����̸�,�Ŵ����� ��å
--��Ī�� �Ŵ�����å���� �Ͻÿ�
select e.employee_id,e.first_name,e.manager_id,em.first_name �Ŵ����̸�,j.job_title �Ŵ�����å
from employees e,employees em,jobs j
where em.employee_id=e.manager_id
and em.job_id=j.job_id;

--��������
--'toronto'�� ��ġ�� �μ��� �ٹ��ϴ� ����� 8���� �Ի��� �����
--���,�̸�,�μ���,��å�̸�,�Ŵ����̸��� ���
select e.employee_id,e.first_name,d.department_name,j.job_title,em.first_name
from employees e,departments d, jobs j, employees em,locations l
where e.department_id=d.department_id
and e.job_id=j.job_id
and d.location_id=l.location_id
and e.manager_id=em.employee_id
and lower(l.city) = lower('toronto')
and to_char(e.hire_date,'mm')='08';

--1995�� ������ �Ի��� ��� �� 5000������ �޿��� �޴� �����
--���,�̸�,��å�̸�,�޿�,�ٹ����ø� ����϶�
select e.employee_id,e.first_name,j.job_title,e.salary,l.city 
from employees e, jobs j,departments d,locations l
where e.department_id=d.department_id
and e.job_id=j.job_id
and d.location_id=l.location_id
and to_number(to_char(e.hire_date,'yyyy'),'9999')<1995
and e.salary<=5000;