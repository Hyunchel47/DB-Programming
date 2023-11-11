-- 1�� ����
CREATE TABLE STUDENT2019 (
stdno NUMBER(10) PRIMARY KEY,
name VARCHAR(10) NOT NULL,
grade NUMBER(3) DEFAULT 1,
kor NUMBER(5) NOT NULL,
eng NUMBER(5) NOT NULL,
math NUMBER(5) NOT NULL,
toeic NUMBER(5) NOT NULL
);

insert into STUDENT2019 values(201695112, '������', 1, 60, 90, 70, 300);
insert into STUDENT2019 values(201695109, '�ڹ̰�', 1, 60, 50, 50, 400);
insert into STUDENT2019 values(201695107, '�̵���', 1, 60, 70, 80, 700);
insert into STUDENT2019 values(201395114, '������', 2, 90, 80, 40, 500);
insert into STUDENT2019 values(201395101, '������', 2, 90, 90, 90, 900);
insert into STUDENT2019 values(201295111, '�̸���', 3, 80, 80, 70, 500);
insert into STUDENT2019 values(201295105, '������', 4, 50, 60, 70, 700);
insert into STUDENT2019 values(201095125, '������', 4, 90, 90, 90, 900);
insert into STUDENT2019 values(201995090, '����ö', 3, 100, 100, 100, 900);

-- 2�� ����
SELECT stdno "�й�", name "�̸�", grade "�г�", toeic, ROUND((kor+eng+math)/3, 1) "��ռ���", ROUND(((kor+eng+math)/3 * 0.8) + (toeic / 10 * 0.2), 0) "����"
FROM STUDENT2019
ORDER BY "��ռ���" DESC;

-- 3�� ����
-- ������� ����ΰǺ�(�޿�(sal) + ����(comm))�� ���� ���� �μ��� �Ҽӵ� ��������
-- �����ȣ, �̸�, �޿�(sal)+����(comm), ����, �μ����� ����Ͻÿ�
-- ��, ����(�޿�+����)�� NULL�� ǥ���ϸ� �ȵ�. �μ���ȣ�� �ƴϰ� �μ����� ����ؾ���
SELECT empno "�����ȣ", ename "�̸�", sal + NVL(comm, 0) "����", job "����", dname "�μ���"
FROM emp JOIN dept USING (deptno)
WHERE deptno = (SELECT deptno
                FROM emp
                GROUP BY deptno
                HAVING MAX(sal + NVL(comm, 0)) > 4000 );

-- 4�� ����
-- �л��� �й�, �̸�, Ű, ������, ǥ��ü��, ������(��/��ü��/����)�� ����ض�
-- ǥ��ü���� Ű���� 110�� �����̶�� ���� / ���� �����԰� ǥ��ü�ߺ��� 20%�̻�, 10~20%�� ��ü��, �� ���ϴ� ����
-- ������ = ((���� ü�� - ǥ�� ü��)/ǥ�� ü��) * 100(%)
SELECT studno, name, height, weight, height-110 "ǥ��ü��",
        CASE WHEN ((weight - (height-110))/(height-110)) * 100 >= 20 THEN '��'
             WHEN ((weight - (height-110))/(height-110)) * 100 >= 10 THEN '��ü��'
             ELSE '����' END "������"
FROM student;

--======================================================================
SELECT ename, deptno, dname, sal, comm, NVL(sal + comm, 0) "����ΰǺ�"
FROM emp join dept USING (deptno)
ORDER BY deptno
;

select deptno,dname, MAX(sal + NVL(comm, 0)) "����ΰǺ�"
from emp join dept using(deptno)
group by deptno, dname
order by "����ΰǺ�" DESC;

select * from STUDENT2019;
select * from emp;
select * from student;