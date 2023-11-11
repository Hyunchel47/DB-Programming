-- 1�� ����
CREATE TABLE ORDER2020 (
orderno VARCHAR2(5),    -- �ֹ���ȣ
bookno NUMBER(5),       -- ������ȣ
orderdate DATE NOT NULL,    -- �ֹ���¥
price NUMBER(6) DEFAULT 5000,   -- �ܰ�
volume NUMBER(3) DEFAULT 1,     -- ����
PRIMARY KEY (orderno, bookno)   -- ���� �⺻ Ű ����
);

insert into ORDER2020 values('A100', 1122, '2019-03-03', 9500, 2);
insert into ORDER2020 values('A100', 1234, '2019-03-03', 9000, 2);
insert into ORDER2020 values('A200', 2345, '2019-04-06', 7000, 3);
insert into ORDER2020 values('A200', 1122, '2019-04-06', 9500, 2);
insert into ORDER2020 values('A300', 1122, '2019-05-10', 9500, 4);
insert into ORDER2020 values('A300', 3456, '2019-05-10', 10000, 3);
insert into ORDER2020 values('A400', 2345, '2019-06-15', 7000, 2);
insert into ORDER2020 values('A400', 1122, '2019-06-15', 9500, 2);
-- �⺻���� ����Ͽ� ������ ���� (�ܰ��� ������ �⺻���� ����)
--INSERT INTO ORDER2020 (orderno, bookno, orderdate) VALUES ('A300', 1122, '2019-05-10');

-- 2�� ����
-- ORDER2020���� �ֹ��� �������� ���϶�.
-- ��³��� : �ֹ���ȣ, �Ǹž�, ��۷�, ������ / ��۷�� 2,500�� (5���� �̻� ����)
-- �ݾ��� õ�� ������ ����(,) ǥ��
SELECT orderno "�ֹ���ȣ", TO_CHAR(SUM(price * volume), '999,999') "�Ǹž�",
                CASE WHEN SUM(price * volume) >= 50000 THEN '����'
                     ELSE '2,500' END "��۷�",
                CASE WHEN SUM(price * volume) >= 50000 THEN TO_CHAR(SUM(price * volume), '999,999')
                ELSE TO_CHAR(SUM(price * volume + 2500), '999,999')
                END "�����"
FROM ORDER2020
GROUP BY orderno;

-- 3�� ����
-- '���׺���'�� �ٹ����� �ʴ� ������� ������� ���� ��տ����� ���
-- �������, ��տ����� ����϶� / ��, ��տ����� �Ҽ��� 1�ڸ� ǥ��
SELECT e.emp_type "�������", ROUND(AVG(pay), 1) "��տ���"
FROM emp2 e JOIN dept2 d
ON e.deptno = d.dcode
WHERE d.AREA NOT IN (SELECT d2.area
                    FROM dept2 d2
                    WHERE d2.AREA = '���׺���'
                    )
GROUP BY e.emp_type;

-- 4�� ����
-- professor ���̺� '��ǻ�������к�' �Ҽ� ������ �л����� ����϶�.
-- ��� : �й�, �̸�, �г�, ������
-- ���������� ���, ���г� ��, �й� ��
SELECT studno "�й�", name "�̸�", grade "�г�", dname "������"
FROM student s JOIN department d
ON s.deptno1 = d.deptno
--WHERE dname = '��ǻ�������к�'
ORDER BY "������" ,"�г�", "�й�";




--==============================================================================================
--==============================================================================================
alter session set nls_date_format='YYYY-MM-DD';
drop table ORDER2020;
select * from ORDER2020;
select * from tab;
select * from emp2;
select * from dept2;
select * from student;
select * from professor;
select * from department;

SELECT e.name, e.emp_type, ROUND(pay, 1), d.area
FROM emp2 e JOIN dept2 d
ON e.deptno = d.dcode
WHERE d.area != '���׺���'
ORDER BY e.emp_type desc;

SELECT EMP_TYPE, ROUND(AVG(PAY), 1) AS "��տ���"
FROM EMP2
WHERE DEPTNO NOT IN (
    SELECT DCODE
    FROM DEPT2
    WHERE DNAME = '���׺���'
) OR DEPTNO IS NULL
GROUP BY EMP_TYPE
ORDER BY EMP_TYPE;