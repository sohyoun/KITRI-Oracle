--non equi join
--between and
--��� ����� ���,�̸�,�޿�,�޿����
select e.employee_id,e.first_name,e.salary,jg.grade_level
from employees e,job_grades jg
where e.salary between jg.lowest_sal and jg.highest_sal;

--outer join
--��� ����� ���, �̸�, �μ���ȣ, �μ��̸�
--��� ����̶�� ������ 19�� �ۿ� ������ �ʾҴ�. 1���� department_id�� null�̱� ����
--e.department_id�� foreign key�̴�. ���� d.department_id�� �ִ� �� �ۿ� ���� �� ����. ������ ���ܷ� null�� ���ȴ�.
--d.department_id�� primary key�̴�. ���� null�� ���� �� ����.
--�׷��� ������ department_id�� null�� �� ���� ������ �ʴ� ���̴�.
select e.employee_id,e.first_name,d.department_id,d.department_name
from employees e,departments d
where e.department_id=d.department_id;

--join�� �ϸ� null�� Ʃ���� �ȳ����� ��� (+)�� �ٿ� null�� Ʃ�õ� ���� �� �ְ� �Ѵ�.
--�μ��� �������� ��� �μ��̸��� '���߷���'���� ���
--d.department_id�� ���� null���� �߰���Ű�� ���� join�� �� (+)�� ���δ�.
--�̰��� outter join�̶�� �Ѵ�.
select e.employee_id,e.first_name,d.department_id,nvl(d.department_name,'���߷���')
from employees e,departments d
where e.department_id=d.department_id(+);

--��� ����� ���,�̸�,������,����̸�
--�� ����� ���� ��� ����̸��� '����'���� ���
select e.employee_id,e.first_name,e.manager_id,nvl(em.first_name,'����')
from employees e, employees em
where e.manager_id=em.manager_id(+);

--��� ����� ���,�̸�,������,����̸�,�μ��̸�
--�� ����� ���� ��� ��� �̸��� '����'���� ���
--�� �μ��� �������� ��� �μ��̸��� '���߷���'�� �����
select e.employee_id,e.first_name,e.manager_id,nvl(em.first_name,'����'),nvl(d.department_name,'���߷���')
from employees e, employees em,departments d
where e.manager_id=em.manager_id(+)
and e.department_id=d.department_id(+);

---------------------------------------------------------------------------------
--ANSI JOIN
--cross join
--oracle
select *
from employees,departments;

--ansi
select *
from employees cross join departments;

--inner join
--oracle
--���,�̸�,�μ��̸�
select e.employee_id,e.first_name,d.department_name
from employees e, departments d
where e.department_id=d.department_id;

--ansi
select e.employee_id,e.first_name,d.department_name
from employees e inner join departments d
on e.department_id=d.department_id;

--���ǰɱ� : �׳� and�Ἥ on���� �ᵵ ������ where���� ���� ���� ����
select e.employee_id,e.first_name,d.department_name
from employees e inner join departments d
on e.department_id=d.department_id
where e.department_id=50;

--using : ~�� ����ؼ� �����Ѵ�
select e.employee_id,e.first_name,d.department_name
from employees e inner join departments d
using(department_id)      --join�Ҷ� �÷��̸��� ���� ��� using ���
where department_id=50; --using�� �÷��� e. d.���� �ĺ��� ���� �ȵ�.

--natural join : inner join�� �ϳ�
--             : �� ���̺��� �̸��� ���� �÷��� �ڵ����� ã�� ��������
--���� �̸��� �÷��� �ϳ� �̻� �̸� ��� ���� �÷��� �����Ѵ�.
--employees�� departments�� department_id�� manager_id �ΰ��� �÷� �̸��� ����.
--���� �� ���̺� ���̿� ���� �̸��� �÷��� �ϳ��϶��� ���� ���� ����.
select e.employee_id,e.first_name,d.department_name
from employees e natural join departments d
where department_id=50;

--���� ���̺� join
--oracle
--'seattle'�� �ٹ��ϴ� ���,�̸�,�μ��̸�,����
select e.employee_id,e.first_name,d.department_name,l.city
from employees e, departments d, locations l
where e.department_id=d.department_id
and d.location_id=l.location_id
and l.city = 'Seattle';

--ansi
--3�� �̻��� ���̺��� �����Ϸ��� ���������� join/on�� �ݺ��ϸ� �ȴ�
--������ ������ �ٲ�� �ȵ����� ������ �����ؾ��Ѵ�.
select e.employee_id,e.first_name,d.department_name,l.city
from employees e
join departments d
on e.department_id=d.department_id
join locations l
on d.location_id = l.location_id
where l.city='Seattle';

--outter join
--oracle
--��� ����� ���,�̸�,�μ���ȣ,�μ��̸�
select e.employee_id,e.first_name,e.department_id,d.department_name
from employees e, departments d
where e.department_id=d.department_id(+);
--��� �μ��� �ٹ��ϴ� ����� ���,�̸�,�μ���ȣ,�μ��̸�
--�μ��� �����̱� ������ select���� �μ���ȣ�� d.department_id�� �̰� outter join�� �μ�����
select e.employee_id,e.first_name,d.department_id,d.department_name
from employees e,departments d
where e.department_id(+)=d.department_id;

--ansi : left / right outter join : ������ ����/�����ʿ� �ΰ� �� �ѷ���
--���� ���̺� �ִ� ���� �� �ѷ���
select e.employee_id,e.first_name,e.department_id,nvl(d.department_name,'���߷���')
from employees e left outer join departments d
on e.department_id=d.department_id;
--������ ���̺� �ִ� ���� �� �ѷ���
select e.employee_id,nvl(e.first_name,'�������'),e.department_id,d.department_name
from employees e right outer join departments d
on e.department_id=d.department_id;

--full outer join (ansi)
--ansi �ΰ��� outter �������ִ� full outer join�� �ִ�.
select e.employee_id,nvl(e.first_name,'�������'),d.department_id,nvl(d.department_name,'���߷���')
from employees e full outer join departments d
on e.department_id=d.department_id;

--���� ���� ����
--��� ������ ����� ���, �̸�,�μ���ȣ,����,�����̸��� ���ÿ� (oracle join)
select e.employee_id, e.first_name, d.department_id, l.city, c.country_name
from countries c, employees e, departments d,locations l
where e.department_id(+)=d.department_id
and d.location_id(+)=l.location_id
and l.country_id(+)=c.country_id
order by c.country_name;

--��� ����� ���,�̸�,Ŀ�̼��� ���Ե� �޿�(Ŀ�̼Ǿ����� �׳� �޿�),�Ŵ����̸�,�޿����� ���Ͻÿ�
--�Ŵ����� ���� ����� '����'�̶�� ���ÿ�
--�޿������� 5000�̸��̸� ��, 10000�̸��̸� ��, 10000�̻��̸� ���̴�. (ANSI join���� ���ÿ�)
select e.employee_id,e.first_name,
e.salary+e.salary*nvl(e.commission_pct,0) Ŀ�̼����Ա޿� , nvl(em.first_name,'����'),
    case 
        when e.salary<5000
        then '��'
        when e.salary<10000
        then '��'
        else '��'
    end �޿�����
from employees e left outer join employees em
on e.manager_id=em.employee_id;