--������ (��������)
--�μ��̸��� it�� �ٹ��ϴ� ����� ���, �̸�, �޿�
select e.employee_id,e.first_name,e.salary
from employees e, departments d
where e.department_id=d.department_id
and d.department_name='IT';

--join�� ����: īŸ�þ� ���δ�Ʈ�� �ؼ� �����͸� �̱� ������ ũ�Ⱑ �ʹ� Ŀ�� ���̴�.
--���� �������� �̾ƾ��ϴ� ���� �� employees���̺� �ִµ� ���� join�� �ؾ��ұ�?
--���� 'IT'�μ��� �μ�id�� 60������ employees���̺��� �μ� id�� 60�� ����� ������ �ȴ�.
select department_id
from departments
where department_name='IT';

select employee_id,first_name,salary 
from employees
where department_id=60;

--�̰��� ��ġ�� ���� �����ȿ� ������ �ִ� '��������'�̴�.
--select from�� select�� ��ġ�� ���ߴ� ���� ����.
--���Ͽ� ������
select employee_id,first_name,salary
from employees
where department_id=(select department_id
                     from departments
                     where department_name='IT');

--'Seattle'�� �ٹ��ϴ� ����� ���,�̸�,�޿�
--'Seattle�� �ٹ��ϴ� �μ��� �������̱� �빮�� =�� �ƴ� in�� ����Ѵ�.
select employee_id,first_name,salary
from employees
where department_id in(select department_id
                       from departments
                       where location_id =(select location_id
                                           from locations
                                           where lower(city)=lower('Seattle')));
                                
--**'seattle'�� �ٹ��ϴ� �μ��� �������̱� ������ = �� �ƴ� in�� ����Ѵ�.
--**�������� : where���� �� ���������� ������ �����͸� ȭ�鿡 �Ѹ� �� ����.�������� from�� �� �͸� �� �� ����.

--����)���������� �� �� ���� ���
--������ ���� �ΰ��� ���̺� �ִ� ������ ����ؾ��ϸ� join�� ����Ѵ�.
--������ȣ�� 1700�� �μ����� ���ϴ� �����
--���,�̸�,�μ���ȣ,�μ��̸�
select e.employee_id,e.first_name,e.department_id,d.department_name
from employees e,departments d
where e.department_id=d.department_id
and d.location_id=1700;
--**��ó��  ��� ���������� join�� ��ü�� �� ����.

---�ζ��� ��(�ζ��� View) : ������ table
select department_id,department_name
from departments
where location_id=1700;

--�ζ��κ並 �̿��Ͽ� from ���� ���������� �� �� �ִ�.
--join���� Ǯ �� �ۿ� ������ ���� ������ from���� ���������� �Ἥ Ǯ �� �ִ�.
--from���� ������
select e.department_id,e.first_name,e.department_id,d.department_name
from employees e,(select department_id,department_name
                  from departments
                  where location_id=1700)d
where e.department_id=d.department_id;
--**������ table d�� employees�� join�� ��

--'Kevin'���� �޿��� ���� �޴� ����� ���,�̸�,�޿�
select employee_id,first_name,salary
from employees
where salary>(select salary
              from employees
              where lower(first_name)=lower('kevin'));
              
--50�� �μ��� �ִ� ����� ���� �޿��� ���� �޴� ����� ���,�̸�,�޿�
select employee_id,first_name,salary
from employees
where salary > all(select salary
               from employees
               where department_id=50);
               
--�μ��� �ٹ��ϴ� ������� ��ձ޿����� ���� �޴� ����� ���,�̸�,�޿�
select employee_id,first_name,salary
from employees 
where salary>(select avg(salary)
              from employees
              where department_id is not null);
--employee�� �μ��� ���� ����� �����ؾ��ϱ� ������ department_id is not null�� �ٿ����Ѵ�.        

--�μ���ȣ�� 20���� ��ձ޿����� ũ��
--�μ����� ������� �μ���ȣ�� 20�� �ƴ� �����
--���,�̸�,�޿�,�μ���ȣ
select e.employee_id,e.first_name,e.salary,e.department_id
from (select employee_id,first_name,salary,department_id
      from employees
      where salary>(select avg(salary)
                    from employees
                    where department_id=20))e
     ,departments d
where e.employee_id=d.manager_id
and d.department_id<>20;

--select���� ������
--select ���� ���� ���������� �� ���� �� ���� ���̾���Ѵ�.
--20�� �μ��� ��ձ޿�
--50�� �μ��� �޿�����
--80�� �μ��� �ο���
--select ���� ���� ���������� �� ���� �� ���� ���̾�� �Ѵ�.
select
(select avg(salary) from employees where department_id=20)avg20,
(select sum(salary) from employees where department_id=50)sum50,
(select count(employee_id) from employees where department_id=80)count50
from dual;

--case,decode �ȿ��� ���������� ��� �� �� �ִ�.
--��� ����� ���,�̸�,�޿�,���,�μ��̸�
--�� A�� 1���,B�� 2��� ~F�� 6���
select e.employee_id,e.first_name,e.salary,d.department_name,
        decode ((
        select grade_level
        from job_grades
        where e.salary between lowest_sal and highest_sal),
            'A','1���',
            'B','2���',
            'C','3���',
            'D','4���',
            'E','5���',
            '6���')���
from employees e,departments d
where e.department_id=d.department_id(+);

--����
--������ 30�� ���� ����� �����ȣ�� �μ��� �̸��� ���Ͻÿ�
select e.employee_id,d.department_name
from departments d,employees e
where d.department_id=e.department_id
and e.employee_id in(select employee_id
                     from employees
                     where to_char(sysdate,'yyyy')-to_char(hire_date,'yyyy')>30);
                     
--united kingdom��� �Ŵ����� ����� �����ȣ�� �����̸��� ���Ͻÿ�.
select e.employee_id,l.city
from employees e,departments d,locations l
where e.employee_id in(select distinct manager_id
                        from employees
                        where manager_id is not null)
and e.department_id=d.department_id
and d.location_id = l.location_id
and l.country_id=(select country_id from countries where country_name='United Kingdom');

--��������
--'Southlake'�� �ٹ��ϴ� �����
--���,�̸�,�μ���ȣ,�μ��̸�
select e.employee_id,e.first_name,e.department_id,d.department_name
from employees e, departments d
where e.department_id=d.department_id
and d.location_id=(select location_id from locations where city='Southlake');

select e.employee_id,e.first_name,e.department_id,d.department_name
from employees e,(select department_id,department_name
                  from departments
                  where location_id =(select location_id
                                      from locations
                                      where city ='Southlake')) d
where e.department_id=d.department_id;

--'Executive'�μ��� ���� ��� �߿��� ���� ������ ������ �������
--�����ȣ,�̸�,�޿�,�޿� ����� ����϶�
--��, join�� 1ȸ�� ����Ѵ�.
select e.employee_id,e.first_name,e.salary,
        (select jg.grade_level
        from job_grades jg
        where e.salary between jg.lowest_sal and jg.highest_sal)�޿����
from employees e, departments d
where e.department_id =d.department_id
and d.department_name='Executive'
and e.employee_id not in(select distinct jh.employee_id
                         from job_history jh);