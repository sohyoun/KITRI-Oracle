--round(��,�ڸ���) �ݿø� : �ڸ����� �Ҽ��� ��°�ڸ����� ǥ���ϴ°�.
--�ڸ����� 0�̸� �Ҽ��� 0�ڸ�����, �׷����� �Ҽ��� ù°�ڸ����� �ݿø�
--�ڸ����� 1�̸� �Ҽ��� ù°�ڸ����� ǥ��
--�ڸ����� -1�̸� �Ҽ��� -1�ڸ�����, �� 10���ڸ� ���� ǥ��
select 1234.5438, round (1234.5438), round (1234.5438,0)
        , round (1234.5438,1), round (1234.5438,-1), round (1234.5438,-3)
from dual;
--trunc ( �� , �ڸ��� )����
select 1234.5438, trunc (1234.5438), trunc (1234.5438,0)
        , trunc (1234.5438,1), trunc (1234.5438,-1)
        , trunc (1234.5438,3), trunc (1234.5438,-3)
from dual;
--floor ( �� )�Ҽ��� ���� 
--trunc�� �ڸ����� ���ؼ� �����Ҽ� ������ floor�� �Ҽ��� ����
select 1234.5438, trunc (1234.5438)
from dual;

--mod(��,��): ����������
select 5+3,5-3,5*3,5/3,mod(5,3)
from dual;
--abs(��) : ���밪
select abs(5),abs(-5),abs(+5)
from dual;


--����� ���, �̸�, �޿�, Ŀ�̼����Ա޿�
--Ŀ�̼� ���� �޿��� 100�� �ڸ� ���� ǥ��(�ݿø�)
select employee_id,first_name, salary, salary+salary*nvl(commission_pct,0), round(salary+salary*nvl(commission_pct,0),-2)
from employees;


--�����Լ�

select 'kiTRi',lower('kiTRi'),upper('kiTRi'),initcap('kiTRi'),length('kiTRi')
from dual;

-- full name
--concat�� �� ���ڿ��� �����Ѵ�. �ΰ��� ��!
select employee_id, first_name||' '|| last_name fullname,
     concat(first_name,concat(' ',last_name))
from employees;
--database�� ���ڰ��� 1���� ����!! (0���� �ƴ�)
--substr ( , , )�ΰ��� ���� ����, �Ѱ� �ȵ� 
--2���� 6�� ���(6���� �ƴ�)
--���ڰ��� �ϳ��϶��� �����ε��� ���� ������ ����
--ù��°�� �����ε���, �ι�°�� ������ ������ ����
--instr 
--���ڰ� �ϳ��϶��� ���ڰ��� ���° �ڸ��� �ִ��� ���
--���ڰ��� �ΰ��϶��� �ι�° ���ڰ��� �ڸ��� ���� ù��° ���ڰ��� ���° �ִ��� ���
select 'hello oracle !!!',substr('hello oracle !!!',2,6),substr('hello oracle !!!',2),
        instr('hello oracle !!!', 'o'), instr('hello oracle !!!', 'o',6)
from dual;

-- '-'�� �������� �ռ��ڵ��� zip1��, �޼��ڵ��� zip2�� �����
select '1234-56' zipcode, substr('1234-56',1,instr('1234-56','-')-1) zip1 ,substr('1234-56',instr('1234-56','-')+1) zip2
from dual;

--��¥�Լ�
--sysdate : ���� ��¥ 
--sysdate+3/24 : ������ �ð��� 3�ð� ����
--to_char(sysdate+3/24,'yyy-mm-dd hh24:mi:ss'): ���ݽð��� 3�ð� ���Ѱ��� ��¥�ð����� ǥ��
select sysdate, sysdate+3, sysdate-3,sysdate+3/24, to_char(sysdate+3/24,'yyy-mm-dd hh24:mi:ss')
from dual;

--sysdate : ���� ��¥ 
--months_between(sysdate,sysdate+70): ù��°~�ι�° ������ ���� ����ΰ�? 70���� 2.�� ��
--next_dat(sysdate,1) : ���� �������� �Ͽ����� �����ΰ�(1:��)
--add_months(sysdate,2) : ���÷κ��� 2�� �Ĵ� �����ΰ�
--last_day(sysdate) : ������ �������� ���� ������ ���� �����ΰ� (first_day�� ����)
select sysdate, months_between(sysdate,sysdate+28),
        next_day(sysdate,1),add_months(sysdate,2)
        ,last_day(sysdate)
from dual;

--to_char : ���ڸ� ���ڷ� �ٲ���
--yyyy:Ǯ���� , yy: �����ڸ�����
--mm: ��(����), mon:2��/JAU ,month:2��/JANUARY
--w:�̹� ���� ���° ��, ww:1���� ���° ��,
--d:����(��:2), dd:�Ѵ��� ���° ��, ddd:1���� ���° ��, dy:��/MON, day:������/MONDAY
--am/pm:����/���� �ð�, hh: �ð�, hh24:24�ð����ؽð�, mi:��, ss:��
select sysdate, to_char(sysdate,'yyyy yy mm mon month w ww d dd ddd day am hh hh24')
from dual;
select sysdate, to_char(sysdate,'mi ss')
from dual;

--round : �ݿø�, trunc: ����
--union�� �ϸ� ���� �Ʒ� �ڵ� ������ ������ ��������� �����ڵ忡�� ;������ �ȵ�
select to_char(sysdate,'yyyy mm dd hh24:mi:ss'),
        to_char(round(sysdate),'yyyy mm dd hh24:mi:ss'),
        to_char(round(sysdate,'dd'),'yyyy mm dd hh24:mi:ss'),
        to_char(round(sysdate,'mm'),'yyyy mm dd hh24:mi:ss'),
        to_char(round(sysdate,'yy'),'yyyy mm dd hh24:mi:ss'),
        to_char(round(sysdate,'hh'),'yyyy mm dd hh24:mi:ss'),
        to_char(round(sysdate,'mi'),'yyyy mm dd hh24:mi:ss')
from dual
union
select to_char(sysdate,'yyyy mm dd hh24:mi:ss'),
        to_char(trunc(sysdate),'yyyy mm dd hh24:mi:ss'),
        to_char(trunc(sysdate,'dd'),'yyyy mm dd hh24:mi:ss'),
        to_char(trunc(sysdate,'mm'),'yyyy mm dd hh24:mi:ss'),
        to_char(trunc(sysdate,'yy'),'yyyy mm dd hh24:mi:ss'),
        to_char(trunc(sysdate,'hh'),'yyyy mm dd hh24:mi:ss'),
        to_char(trunc(sysdate,'mi'),'yyyy mm dd hh24:mi:ss')
from dual;

--��ȯ�Լ�
--���� 3�� ����������/����'3'�� ��������
--'3'+5
--����Ŭ���� +�� �������ۿ� �ȵ�. ���ڿ� ���ϴ� ���� ||��
--���� �ڵ����� ���ڷ� ��ȯ -->'�ڵ�����ȯ'�̶�� �θ�
select 'a',3,'3',3+5,'3'+5
from dual;
--���ڸ� ���ڿ��� �ٲٱ�
--1000���ڸ����� ,�������� ���ڿ��� ����������
--000,000,000.00���� �ϸ� �ڵ����� �ݿø��ǰ� 1000�� �ڸ����� ,�� ������ �տ� ������ 00�� �ȴ�. 
--999,999,999.99���� �ϸ� 0���� �������� ������ ������ 00�� �ƴ϶� ������ִ�.���ڿ� ���̴� 00���� ���� ���� ����.
--�տ� L�� ���̸� ��ȭ(����ȭ��)�� �ǰ� $�� ���̸� �޷��� ��
select 1123456.789,
        to_char(1123456.789,'000,000,000.00'),
        to_char(1123456.789,'999,999,999.99')
from dual;
--���ڿ��� ���ڷ� �ٲٱ�
--'123,456.98'+3�� �ȵ�->, �� ���� ���ڿ��̱� ����
--to_number�� ����Ͽ� ���ڿ��� ���ڷ� �ٲ�
--to_number('123,456.98','000,000.00')���� 00�� ���� ���� �ڸ����� �Ȱ��� ������ִ� ���� ����. �� ���ų� ������ �ȵ�
select '123,456.98',to_number('123,456.98','000,000.00')+3
from dual;

select sysdate,to_char(sysdate,'yy.mm.dd')
       ,to_char(sysdate,'am hh:mi:ss')
       ,to_char(sysdate,'hh24:mi:ss')
from dual;

--20190225142154>>��¥>>3���� ���ϱ�
--����20190225142154�� to_char�� �̿��� ���ڿ��� �ٲ۴� **���ڿ��� ��¥�� �ٷ� ��ȯ �Ұ���
--���ڿ��� to_date�� �̿��� ��¥�� �ٲ۴�. �̶� ������ú��ʸ� ����
--���⿡ +3�� �ؼ� 3�� �ĸ� ���� �� to_char�� �̿��Ͽ� ���ϴ� ���ڿ�(�ð�ǥ��)���� �����.
select 20190225142154,to_char(20190225142154,'00000000000000')
from dual;
select 20190225142154,to_date(to_char(20190225142154,'00000000000000'),'yyyymmddhh24miss')+3
from dual;
select 20190225142154,to_char(to_date(to_char(20190225142154,'00000000000000'),'yyyymmddhh24miss')+3,'yyyy.mm.dd hh24:mi:ss')
from dual;

--�Ϲ��Լ�
--nvl,nvl2
--nvl(A,0)A�� null�ڸ��� 0���� ��ü
--nvl2(A,1,0)A�� null�� �ƴϸ� 1��, null�̸� 0���� ��ü
select commission_pct,nvl(commission_pct,0),nvl2(commission_pct,1,0)
from employees;

--CASE:~���/when/then/else/END\
--�޿��� 4000�̸��� ����� ������
--      10000�̸���      ��տ���
--      10000�̻���      ����
select employee_id,first_name,salary,
        case
            when salary<4000
            then '������'
            when salary<10000
            then '��տ���'
            else '����'
        end
from employees
order by salary desc;
--**4000�̸��� �̹� ó������ �ɷ����� ������ �ι�°���� 4000<salary<10000�� �ƴ� �׳� <10000

--�������
--1980�⵵ �Ի�  �ӿ�
--  90          ����
--2000          ���Ի��
--���,�̸�,�Ի���,�������
select employee_id, first_name,hire_date,
        case
            when to_number(to_char(hire_date,'yyyymmdd'),'00000000')>20000000
            then '���Ի��'
            when to_number(to_char(hire_date,'yyyymmdd'),'00000000')>19900000
            then '����'
            when to_number(to_char(hire_date,'yyyymmdd'),'00000000')>19800000
            then '�ӿ�'
        end
from employees
order by hire_date;
--�ƽ�Ű�ڵ尪
select ascii('0'),ascii('A'),ascii('a'),chr(47)
from dual;

select case when 'abc'<'acd' then '�۴�'
            else 'ũ��'
        end
from dual;

select  employee_id, first_name,hire_date,
        case
            when substr(to_char(trunc(hire_date,'yyyy'),'yyyy'),1,3)='198'
            then '�ӿ�'
        end
from employees;

select employee_id,first_name,hire_date,
        case
            when to_char(trunc(hire_date,'yyyy'),'yyyy')<1990
            then '�ӿ�'
        end
from employees;



--����
--����ID,����ID,����,����� ����Ͻÿ�.(�Ϲ�(ĳ����,�̱�)/������(����)/������(����))
--��Ī�� ���� ������ ������ �� ��
select location_id ����ID,country_id ����ID ,city ����,
        case
            when country_id='US' or country_id='CA'
            then '�Ϲ�'
            when country_id='UK'
            then '������'
            else '������'
        end ���
from locations;
--������ ID, �̸�, ��ȭ��ȣ, ��Ż縦 ����Ͻÿ�.
--������ ��ȭ��ȣ�� 5�� �����ϸ� ��Ż縦 SKT, 6���� �����ϸ� KT,0���� �����ϸ� LG �� �����Ͻÿ� 
--���� ��Ż� ���� �����Ͻÿ�
select employee_id,first_name,phone_number,
        case
            when substr(phone_number,1,3) like '5%'
            then 'SKT'
            when substr(phone_number,1,3) like '6%'
            then 'KT'
            else 'LG'
        end ��Ż�
from employees
order by phone_number;

-- �ڱⰡ �¾ ������ ������� ������ �������� ����غ���
select floor(months_between(sysdate,to_date(to_char(19950613,'00000000'),'yyyymmdd'))*30)
from dual;

-- ����ð��� ��Ÿ�����Ѵ�. 
--������('����ð��� ����(����) 00�� 00�� 00�� �Դϴ�.' �� ��µǾ������ϰ� 12�� ������ ����, 12�� ���Ĵ� ���� �̴�.
--�� 20��, 40�� ���� '�ȳ��ϼ���.' ��� ����� �Ǿ��Ѵ�.)
select '����ð��� '||to_char(sysdate,'am')||' '||to_char(sysdate,'hh')||'��'||' '
        ||to_char(sysdate,'mi')||'��'||' '||to_char(sysdate,'ss')||'�� �Դϴ�.' ����ð�,
        case
            when to_char(sysdate,'ss')='40' or to_char(sysdate,'ss')='20'
            then '�ȳ��ϼ���.'
        end �ȳ�
from dual;
-- ����1. �������
-- �Ի����� 1995�� ������ ����� ��,
--	�޿��� 5000 �̸��� ����� C
--	�޿��� 10000 �̸��� ����� B
--	�޿��� 10000 �̻��� ����� A
-- ������ȣ, �̸�, �Ի���, �޿�, ��������� ����ϰ�, ��������� ������������ �����϶�
select employee_id,first_name,hire_date,salary,
        case
                     when salary<5000
                     then 'C'
                     when salary<10000
                     then 'B'
                     else 'A'
        end �������
from employees
where to_char(hire_date,'yyyy')>=1995
order by ������� desc;

-- ����2. �ټӳ���� ���ط� 20�� �̻� 25�� ������ ����鿡�� ���ʽ��� ������ �����̴�. ������ ���� �������� ���ʽ��� �����϶�.
--	�޿��� 5000 �̸��� ����� 30%
--	�޿��� 10000 �̸��� ����� 20%
--	�޿��� 10000 �̻��� ����� 10%
-- �޿��� Ŀ�̼��� ������ ������ ����ϸ�, �ټӳ���� �������� ����Ѵ�(��,���� ������� ����).
-- ������ȣ, �̸�, �Ի���, Ŀ�̼��� ������ �޿�, ���ʽ��� ����ϰ�, ���ʽ��� ������������ �����϶�.
select employee_id,first_name,hire_date,salary+salary*nvl(commission_pct,0)Ŀ�̼����Ա޿�,
        case
            when salary<5000
            then (salary+salary*nvl(commission_pct,0))*0.3
            when salary<10000
            then (salary+salary*nvl(commission_pct,0))*0.2
            else (salary+salary*nvl(commission_pct,0))*0.1
        end ���ʽ�
from employees
where to_char(sysdate,'yyyy')-to_number(to_char(hire_date,'yyyy'),'0000') between 20 and 25;

--�����ȣ, ����̸�, �Ի���,�Ի�� ��������¥,�Ի��� ���� �Ͽ����� ��¥, �Ի� �� 100���� ��¥�� �˻��϶�
select employee_id,first_name,hire_date,to_char(last_day(hire_date),'dd'),next_day(hire_date,1),hire_date+100
from employees;
--������� �̸��� Ǯ�������� �ۼ��϶�(concat�̿��ϰ� �̸����̿� ����ֱ�)
select concat(first_name,concat(' ',last_name))
from employees;
--���� ��¥�� ������� ��������̶�� �����ϰ� ������� Ǯ���Ӱ� �������, ���糪�̴�(2019�� ����)�� ���Ͻÿ�. 
--���̴�� 20�� 30�� 40��� ������ ��, �׸��� ��Ī�� '���̴�'�� ����
select concat(first_name,concat(' ',last_name)),hire_date,
        case 
            when 2019-to_char(hire_date,'yyyy')+1 <30
            then '20��'
            when 2019-to_char(hire_date,'yyyy')+1 <40
            then'30��'
            else '40��'
        end ���̴�
from employees;