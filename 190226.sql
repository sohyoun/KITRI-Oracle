-- Case ����
--���,�̸�,�μ���ȣ,��������
--�μ���ȣ 60 ������
--        90 �ӿ���
--        ������ �񰳹���
select employee_id,first_name,department_id,
    case
        when department_id = 60
        then '������'
        when department_id = 90
        then '�ӿ���'
        else '�񰳹���'
    end ��������
from employees;

--decode�� equal �񱳸� �����ϴ�. ~�̻�~���� ���� ���� �Ұ���.
--������ �ξ� ������.
--������ '�񰳹���' ���� default ���̴�.
select employee_id,first_name,department_id,
    decode(department_id,
            60,'������',
            90,'�ӿ���',
            '�񰳹���')��������
from employees
order by department_id;


--�׷��Լ�
--ȸ���� �� �����, �޿�����,�޿����,�ְ�޿�,�����޿�
--count():�Ѱ���,sum():��,avg():���,max():�ְ�,min():������
--stddev():ǥ��������,valance():�л갪
--**������ �ϳ��� ���´�.
select count(employee_id),sum(salary),avg(salary),max(salary),min(salary)
from employees;

--�׷��Լ��� where���� �� ������. ���߿� ���������� ���� ����
--��ձ޿����� ���� �޴� ����� ���,�̸�,�޿�
select employee_id,first_name,salary
from employees
where salary>avg(salary);