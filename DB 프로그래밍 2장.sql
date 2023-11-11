-- ����1
SELECT studno || ',' || name ||'''s weight is ' || weight || 'kg, height is ' || height || 'cm' "����1��"
FROM student;
--����2
SELECT grade "�г�" , studno "�й�", 'weight is ' || weight || 'kg, height is ' || height || 'cm' "ü�߰� Ű"
FROM student
WHERE grade = 2 or grade = 3;

--==============================================================================================
-- 1. ���� �Լ�
-- INITCAP : �Է� ���� ù ���ڸ� �빮�ڷ� ��ȯ           INITCAR('abcd') -> Abcd
-- LOWER : �Է� ���� ���� �ҹ��ڷ� ��ȯ                  LOWER('ABCD') -> abcd   
-- UPPER : �Է� ���� ���� �빮�ڷ� ��ȯ                  UPPER('abcd') -> ABCD
-- LENGTH : �Էµ� ���ڿ��� ���� ���� ���               LENGTH('�ѱ�') -> 2
-- LENGTHB : �Էµ� ���ڿ��� ������ ����Ʈ ���� ���      LENGTHB('�ѱ�') -> 4
--==============================================================================================
------------------------------------------------------------------------------------------------
-- LENGTH / LENGTHB �Լ� :  �Էµ� ���ڿ��� ����(����Ʈ ��)�� ������ִ� �Լ�
-- LENGTH(�÷� or ���ڿ�) / LENGTHB(�÷� or ���ڿ�)
------------------------------------------------------------------------------------------------
SELECT ename, LENGTH(ename) "LENGTH", LENGTHB(ename) "LENGTHB"
FROM emp
WHERE deptno = 20;

-- �ѱ��� ���
SELECT '������' "NAME", LENGTH('������') "LENGTH",
                       LENGTHB('������') "LENGTHB"
FROM dual;


------------------------------------------------------------------------------------------------
-- CONCAT() �Լ� : ||�����ڿ� ������ ���
------------------------------------------------------------------------------------------------
SELECT CONCAT(ename, job)
FROM emp
WHERE deptno = 10;


------------------------------------------------------------------------------------------------
-- SUBSTR() �Լ� : �־��� ���ڿ����� Ư�� ������ ���ڸ� ��� �� ����ϴ� �Լ�
-- SUBSTR('���ڿ�' or �÷���, ������ġ, ��°���)
------------------------------------------------------------------------------------------------
SELECT SUBSTR('abcde', 3, 2) "3,2",     -- 3��°���� 2�� ����
       SUBSTR('abcde', -3, 2) "-3,2",   -- �ڿ������� 3��°���� 2�� ����
       SUBSTR('abcde', -3, 4) "-3,4"    -- �ڿ������� 3��°���� 4�� ���� -> ���ں������� 3���� ��µ�
FROM dual;

SELECT name, SUBSTR(jumin, 3, 4) "Birthday",    
             SUBSTR(jumin, 3, 4)-1 "Birthday -1"
FROM student
WHERE deptno1 = 101;

select name, birthday, jumin
from student
where deptno1 = 101;

select * from student;


------------------------------------------------------------------------------------------------
-- INSTR() �Լ� : �־��� ���ڿ��̳� �÷����� Ư�� ������ ��ġ�� ã���ִ� �Լ�
-- INSTR('���ڿ� or �÷�, ã�±���, ������ġ, ���°����(�⺻���� 1))
------------------------------------------------------------------------------------------------
select 'A-B-C-D', INSTR('A-B-C-D', '-', 1, 3) "INSTR"
from dual;
select 'A-B-C-D', INSTR('A-B-C-D', '-', 3, 1) "INSTR"
from dual;
select 'A-B-C-D', INSTR('A-B-C-D', '-', -1, 3) "INSTR"  -- ���̳ʽ�(-)�� �����ʿ��� �������� �ᱣ�� �˻�
from dual;   

-- Student ���̺��� tel �÷��� ����Ͽ� ������ȣ(deptno1)�� 201���� �л��� �̸�, ��ȭ��ȣ, ')'�� ������ ��ġ
select name, tel, INSTR(tel, ')')
from student
where deptno1 = 201;

SELECT name, tel, INSTR(tel, '3')
FROM student
WHERE deptno1 = 101;

-- SUBSTR/INSTR ���� ///�ſ��߿�!!!
SELECT name, tel, SUBSTR(tel, 1, INSTR(tel, ')')-1) "AREA1",
                  SUBSTR(tel, INSTR(tel, ')')+1, INSTR(tel, '-') - INSTR(tel, ')')-1) "AREA2",
                  SUBSTR(tel, INSTR(tel, ')')+1, INSTR(tel, '-')) "test",
                  SUBSTR(tel, INSTR(tel, '-')) "test2",
                  INSTR(tel, '-'),
                  INSTR(tel, '-') - INSTR(tel, ')')-1
FROM student
WHERE deptno1 = 201;


------------------------------------------------------------------------------------------------
-- REPLACE() �Լ� : �־��� ���ڿ� or �÷����� ����1�� ����2�� �ٲپ� ����ϴ� �Լ�
-- REPLACE('���ڿ�' or �÷���, '����1', '����2')
------------------------------------------------------------------------------------------------
SELECT ename, REPLACE(ename, SUBSTR(ename,1,2), '**') "REPLACE"
FROM emp
WHERE deptno = 10;

--REPLACE����
SELECT ename, REPLACE(ename, SUBSTR(ename,2,2), '--') "REPLACE"
FROM emp
WHERE deptno = 20;
--REPLACE����2
SELECT name, jumin, REPLACE(jumin, SUBSTR(jumin,7,7),'-/-/-/-') "REPLCACE"
FROM student
WHERE deptno1 = 101;
--REPLACE����3
SELECT name, tel, REPLACE(tel, SUBSTR(tel,5,3),'***') "REPLCACE"
FROM student
WHERE deptno1 = 102;
--REPLACE����4
SELECT name, tel, REPLACE(tel, SUBSTR(tel, INSTR(tel, '-')+1, 4), '****') "REPLACE"
FROM student
WHERE deptno1 = 101;

select * from emp;



--==============================================================================================
-- 2. ���� ���� �Լ�
--==============================================================================================
-- ROUND() �Լ� : �־��� ���ڸ� �ݿø��� �� ���
-- ROUND(����, ����� ���ϴ� �ڸ���)
------------------------------------------------------------------------------------------------
SELECT ROUND(987.654, 2) "ROUND1",      -- �Ҽ��� �ι�°(5)���� �ݿø�
       ROUND(987.654, 0) "ROUND2",      -- �Ҽ���(7)���� �ݿø�
       ROUND(987.654, -1) "ROUND3"      -- �Ҽ��� �� ��ĭ(8)���� �ݿø�
FROM dual;
------------------------------------------------------------------------------------------------
-- TRUNC() �Լ� : �־��� ���ڸ� ������ �� ���
-- TRUNC(����, ����� ���ϴ� �ڸ���)
------------------------------------------------------------------------------------------------
SELECT TRUNC(987.654, 2) "TRUNC1",
       TRUNC(987.654, 0) "TRUNC2",
       TRUNC(987.654, -1) "TRUNC3"
FROM dual;
------------------------------------------------------------------------------------------------
-- MOD(), CEIL(), FLOOR()�Լ�
------------------------------------------------------------------------------------------------
SELECT MOD(121, 10) "MOD",      -- ������ ���� ���ϴ� �Լ�
       CEIL(123.45) "CEIL",     -- �־��� ���ڰ� ���� ����� ū ������ ���ϴ� �Լ�
       FLOOR(123.45) "FLOOR"    -- �־��� �Լ��� ���� ����� ���� ������ ���ϴ� �Լ�
FROM dual;
------------------------------------------------------------------------------------------------
-- POWER() �Լ� : ����1�� ����2�� �¼��� �����ִ� �Լ�
-- POWER(����1, ����2)
------------------------------------------------------------------------------------------------
SELECT POWER(2, 3)
FROM dual;



--==============================================================================================
-- 3. ��¥ ���� �Լ���
-- ROUND => �־��� ��¥�� �ݿø�
-- TRUNC => �־��� ��¥�� ����
--==============================================================================================
-- SYSDATE �Լ�
-- ���� �ý����� �ð��� ����� �ִ� �Լ�
------------------------------------------------------------------------------------------------
SELECT SYSDATE FROM dual;

------------------------------------------------------------------------------------------------
-- MONTHS_BETWEEN �Լ�
-- �� ��¥�� �Է¹޾� �� ��¥ ������ ���� ���� ����ϴ� �Լ�
------------------------------------------------------------------------------------------------
SELECT MONTHS_BETWEEN('14/09/30', '14/08/31')
FROM dual;

------------------------------------------------------------------------------------------------
-- ADD_MONTHS() �Լ�
-- �־��� ��¥�� ���ڸ�ŭ�� ���� �߰��ϴ� �Լ�
------------------------------------------------------------------------------------------------
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 1)
FROM dual;

------------------------------------------------------------------------------------------------
-- NEXT_DAY() �Լ�
-- �־��� ��¥�� �������� ���ƿ��� ��¥ ���
------------------------------------------------------------------------------------------------
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��')
FROM dual;

------------------------------------------------------------------------------------------------
-- LAST_DAY() �Լ�
-- �־��� ��¥�� ���� ���� ������ ��¥ ���
------------------------------------------------------------------------------------------------
SELECT SYSDATE, LAST_DAY(SYSDATE), LAST_DAY('14/05/01')
FROM dual;


--==============================================================================================
-- 4. �� ��ȯ �Լ�
--==============================================================================================
------------------------------------------------------------------------------------------------
-- TO_CHAR() �Լ� : ��¥ -> ���ڷ� �� ��ȯ
-- TO_CHAR(���� ��¥, '���ϴ� ���')
------------------------------------------------------------------------------------------------
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY') "YYYY",    -- ������ 4�ڸ��� ǥ��
                TO_CHAR(SYSDATE, 'RRRR') "RRRR",    -- 2000�� ���� y2k���׷� ���� ������ ��¥ ǥ���/���� 4�ڸ� ǥ��
                TO_CHAR(SYSDATE, 'YY') "YY",        -- ������ ���� 2�ڸ��� ǥ�� ex)23
                TO_CHAR(SYSDATE, 'RR') "RR",        -- ������ ������ 2�ڸ��� ǥ��  ex) 23
                TO_CHAR(SYSDATE, 'YEAR') "YEAR",    -- ������ ���� �̸� ��ü�� ǥ��
                
                TO_CHAR(SYSDATE, 'MM') "MM",        -- ���� ���� 2�ڸ��� ǥ�� ex)10
                TO_CHAR(SYSDATE, 'MON') "MON",      -- ������� ����Ŭ�� ��� MONTH�� ����
                TO_CHAR(SYSDATE, 'MONTH') "MONTH",  -- ���� ���ϴ� �̸� ��ü�� ǥ��
                
                TO_CHAR(SYSDATE, 'DD') "DD",        -- ���� ���� 2�ڸ��� ǥ��
                TO_CHAR(SYSDATE, 'DAY') "DAY",      -- ���Ͽ� �ش��ϴ� ��Ī�� ǥ�� / ������� �ѱ۷� ǥ��
                TO_CHAR(SYSDATE, 'DDTH') "DDTH"     -- �� ��° �������� ǥ��
FROM dual;

-- �� ��ȯ �Լ� ���� : ��¥ ��ȯ�ϱ�1
SELECT studno, name, birthday
FROM student
WHERE TO_CHAR(birthday, 'MM') = '01';
-- �� ��ȯ �Լ� ���� : ��¥ ��ȯ�ϱ�2
SELECT empno, ename, hiredate
FROM emp
WHERE TO_CHAR(hiredate, 'MM') IN(1,2,3);    --WHERE TO_CHAR(hiredate, 'MM') BETWEEN 1 AND 3;
------------------------------------------------------------------------------------------------
-- TO_CHAR() �Լ� : ���� -> ���ڷ� �� ��ȯ
-- TO_CHAR(1234,'99999') => 1234         9�� ������ŭ �ڸ���
-- TO_CHAR(1234,'099999') => 001234      ���ڸ��� 0���� ä��
-- TO_CHAR(1234,'$9999') => $1234        $ǥ�ø� �ٿ��� ǥ��
-- TO_CHAR(1234,'9999.99') => 1234.00    �Ҽ��� ���ϸ� ǥ��
-- TO_CHAR(12345,'99,999') => 12,345     õ ���� ���� ��ȣ�� ǥ��
------------------------------------------------------------------------------------------------
-- ��� ��1 // 1�й� ���蹮�� + tax10% ���ϱ�
SELECT empno, ename, sal, comm, TO_CHAR((sal*12) + comm, '999,999') "SALARY",
                                TO_CHAR(((sal*12) + comm) * 0.1, '999,999')"TAX"
FROM emp;
-- ��� ��2 // 2�й� ���蹮��
SELECT name, pay, bonus, TO_CHAR((pay * 12) + bonus, '999,999') "TOTAL"
FROM professor;

-- �� ��ȯ �Լ� ����3
SELECT empno, ename, hiredate, '$' || sal "SAL", '$' || TO_CHAR((sal * 12) + comm, '999,999') "SALARY",
                                                 '$' || TO_CHAR(((sal * 12) + comm) + ((sal * 12) + comm) * 0.15, '999,999') "SALARY 15% UP"
FROM emp;


------------------------------------------------------------------------------------------------
-- T0_NUMBER() �Լ� : ����ó�� ���� ���ڸ� ���ڷ� �ٲپ� �ִ� �Լ�
-- TO_NUMBER('����ó�� ���� ����')
------------------------------------------------------------------------------------------------
SELECT TO_NUMBER('5') FROM dual;
SELECT ASCII('A') FROM dual;


------------------------------------------------------------------------------------------------
-- TO_DATE() �Լ� : ��¥ó�� ���� ���ڸ� ��¥�� �ٲ��ִ� �Լ�
-- TO_DATE('����')
------------------------------------------------------------------------------------------------
SELECT TO_DATE('14/05/31') FROM dual;
SELECT TO_DATE('2014/05/31') FROM dual;




--==============================================================================================
-- 5. �Ϲ� �Լ�
-- �Լ��� �ԷµǴ� ���� ����, ����, ��¥ ���� ���� �� ����� �� �ִ� �Լ�
--==============================================================================================
-- NVL() �Լ� : NULL ���� ������ �ٸ� ������ ġȯ�ؼ� ����ϴ� �Լ�
-- NVL(�÷�, ġȯ�� ��)
------------------------------------------------------------------------------------------------
SELECT ename, comm, NVL(comm,0),        -- comm �÷� ���� null�� ��� null ��� 0���� ġȯ 
                    NVL(comm, 100)      -- comm �÷� ���� null�� ��� null ��� 100���� ġȯ
FROM emp
WHERE deptno = 30;

-- NVL �Լ� ����
SELECT profno, name, pay, bonus, TO_CHAR((pay * 12) + NVL(bonus, 0), '999,999') "TOTAL"
FROM professor
WHERE deptno = 201;


------------------------------------------------------------------------------------------------
-- NVL2() �Լ� : NVL �Լ��� Ȯ������ NULL���� �ƴ� ��� ����� ���� ������ �� �ִ�
-- NVL2(COL1, COL2, COL3) => COL1�� ���� NULL�� �ƴϸ� COL2��, NULL�̸� COL3�� ���
------------------------------------------------------------------------------------------------
SELECT empno, ename, sal, comm, NVL2(comm, sal+comm, sal * 0) "NVL2"
FROM emp
WHERE deptno = 30;

-- NVL2 �Լ� ����
SELECT empno, ename, comm, NVL2(comm, 'Exist', 'NULL') "NVL2"
FROM emp
WHERE deptno = 30;

------------------------------------------------------------------------------------------------
-- DECODE() �Լ�
-- ����Ŭ������ ���Ǵ� �Լ��� IF���� ����ؾ� �ϴ� ���ǹ� ó��
------------------------------------------------------------------------------------------------
-- ����1 A�� B�� ��� '1'�� ����ϴ� ���
-- DECODE (A, B, '1', null) (��, ������ null�� ���� �����մϴ�)
SELECT deptno, name, DECODE(deptno, 101, 'Computer Engineering') "DNAME"
FROM professor;

-- ����2 A�� B�� ��� '1'�� ����ϰ� �ƴ� ��� '2'�� ����ϴ� ���
-- DECODE(A, B, '1', '2')
SELECT deptno, name, DECODE(deptno, 101, 'Computer Engineering', 'ETC') "DNAME"
FROM professor;

-- ����3 A�� B�� ��� '1'�� ����ϰ� A�� C�� ��� '2'�� ����ϰ� �� �� �ƴ� ��� '3'�� ����ϴ� ���
-- DEC0DE(A, B, '1', C, '2', '3')
SELECT deptno, name, DECODE(deptno, 101, 'Computer Engineering',
                                    102, 'Multimedia Engineering',
                                    103, 'Software Engineering',
                                    'ETC') "DNAME"
FROM professor;

-- ����4 A�� B�� ��� �߿��� C�� D�� �����ϸ� '1'�� ����ϰ� C�� D�� �ƴ� ��� NULL�� ����ϴ� ���(DECODE �Լ� �ȿ� DECODE �Լ��� ��ø�Ǵ� ���)
-- DECODE (A, B, DECODE(C, D, '1', null))
SELECT deptno, name, DECODE(deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!')) "ETC"
FROM professor;

-- ����5 A�� B�� ��� �߿��� C�� D�� �����ϸ� '1'�� ����ϰ� C�� D�� �ƴ� ��� '2'�� ����ϴ� ���
-- DECODE(A, B, DECODE(C, D, '1', '2'))
SELECT deptno, name, DECODE(deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!', 'GOOD!')) "ETC"
FROM professor;

-- ����6 A�� B�� ��� �߿��� C�� D�� �����ϸ� '1'�� ����ϰ� C�� D�� �ƴ� ��� '2'�� ����ϰ� A�� B�� �ƴ� ��� '3'�� ����ϴ� ���`
SELECT deptno, name, DECODE(deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!', 'GOOD!'), 'N/A') "ETC"
FROM professor;

-- DECODE ����1
SELECT name, jumin, DECODE(SUBSTR(jumin, 7, 1), 1, 'MAN', 2, 'WOMAN') "Gender"
FROM student
WHERE deptno1 = 101;

-- DECODE ����2
SELECT name, tel, DECODE(SUBSTR(tel, 1, INSTR(tel, ')')-1), 02, 'SEOUL', 031, 'GYEONGGI',
                                                            051, 'BUSAN', 052, 'ULSAN', 055, 'GYEONGNAM') "LOC"
FROM student
WHERE deptno1 = 101;


------------------------------------------------------------------------------------------------
-- CASE() ��
-- CASE ���� WHEN ���1 THEN ���1 [WHEN���2 THEN ���2] ELSE ���3 END "�÷���"
-- CASE WHEN {����} THEN {���� ��}
------------------------------------------------------------------------------------------------
-- DECODE�� �����ϰ� '=' �������� ���Ǵ� ���
SELECT name, tel, CASE(SUBSTR(tel, 1, INSTR(tel, ')')-1)) WHEN '02' THEN '����'
                                                          WHEN '031' THEN '����'
                                                          WHEN '051' THEN '�λ�'
                                                          WHEN '052' THEN '���'
                                                          WHEN '055' THEN '�泲'
                                                          ELSE 'ETC' END "LOC"
FROM student
WHERE deptno1 = 201;
-- �ٸ����
SELECT name, tel, CASE WHEN SUBSTR(tel, 1, INSTR(tel, ')')-1) = '02' THEN '����'
                       WHEN SUBSTR(tel, 1, INSTR(tel, ')')-1) = '031' THEN '����'
                       WHEN SUBSTR(tel, 1, INSTR(tel, ')')-1) = '051' THEN '�λ�'
                       WHEN SUBSTR(tel, 1, INSTR(tel, ')')-1) = '052' THEN '���'
                       WHEN SUBSTR(tel, 1, INSTR(tel, ')')-1) = '055' THEN '�泲'
                       ELSE 'ETC' END "LOC"
FROM student;
-- DECODE���� ����ؼ� �ۼ��غ���
SELECT name, tel, DECODE(SUBSTR(tel, 1, INSTR(tel, ')')-1), 02, '����',
                                                             031, '����',
                                                             051, '�λ�',
                                                             052, '���',
                                                             055, '�泲', 'ETC') "LOC"
FROM student
WHERE deptno1 = 201;
-- ���������� �ۼ��غ���

-- �� ������ '='�� �ƴ� ���
SELECT name, SUBSTR(jumin, 3, 2) "MONTH",
    CASE WHEN SUBSTR(jumin, 3, 2) BETWEEN '01' AND '03' THEN '1/4'
         WHEN SUBSTR(jumin, 3, 2) BETWEEN '04' AND '06' THEN '2/4'
         WHEN SUBSTR(jumin, 3, 2) BETWEEN '07' AND '09' THEN '3/4'
         WHEN SUBSTR(jumin, 3, 2) BETWEEN '10' AND '12' THEN '4/4'
    END "Quarter"
FROM student;

-- CASE�� ����
SELECT empno, ename, sal, CASE WHEN sal BETWEEN 1 AND 1000 THEN 'Level 1'       -- WHEN sal <= 1000 THEN 'Level 1' 
                               WHEN sal BETWEEN 1001 AND 2000 THEN 'Level 2'
                               WHEN sal BETWEEN 2001 AND 3000 THEN 'Level 3'
                               WHEN sal BETWEEN 3001 AND 4000 THEN 'Level 4'
                               ELSE 'Level 5' END "LEVEL"
FROM emp
ORDER BY sal DESC;



------------------------------------------------------------------------------------------------
-- �������� �Ͻ� �ڵ�
------------------------------------------------------------------------------------------------
-- NULL���� �ϳ��� ������ ������꿡�� ����� ������ NULL�� ��µ�
SELECT empno, ename, comm, TO_CHAR((sal*12)+comm, '999,999') "SALARY", 
                           TO_CHAR(((sal*12)+comm) * 0.1, '999,999') "TAX"
FROM emp;

-- NVL�� ����ؼ� NULL�� ��� 0���� ġȯ�Ͽ� ����� �� ������ ����
SELECT empno, ename, comm, TO_CHAR((sal*12)+NVL(comm,0), '999,999') "SALARY", 
                           TO_CHAR(((sal*12)+NVL(comm,0)) * 0.1, '999,999') "TAX"
FROM emp;

SELECT empno, ename, sal, comm, TO_CHAR(salary, '999,999') salary,
                                TO_CHAR(salary * 0.1, '999,999') tax
FROM (SELECT emp. *, (sal*12) + NVL(comm,0) salary
      FROM emp);
      
SELECT empno, ename, sal, comm, sal + NVL(comm, 0) salary,
                                NVL2(comm, sal + comm, sal) salary2
FROM emp;


--==============================================================================================
--==============================================================================================
SELECT name, tel, SUBSTR(tel, 1, INSTR(tel, ')')-1) "AREA CODE",
                  SUBSTR(tel, INSTR(tel,')')+1, INSTR(tel, '-') - INSTR(tel, ')')-1) "AREA2" 
FROM student
WHERE deptno1 = 201;

SELECT ename, REPLACE(ename, SUBSTR(ename, 2, 2), '**') " REPLACE"
FROM emp;

SELECT name, jumin, REPLACE(jumin, SUBSTR(jumin, 7, 7), '-/-/-/-') "REPLCAE"
FROM student
WHERE deptno1 = 101;

SELECT name, tel, REPLACE(tel, SUBSTR(tel, 5, 3), '***') "REPLCAE"
FROM student
WHERE deptno1 = 102;

