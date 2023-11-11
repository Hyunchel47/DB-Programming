-- 1. GROUP �Լ�
-----------------------------------
-- 1_1 COUNT() �Լ�
SELECT COUNT(*), COUNT(COMM)
FROM emp;

-- 1_2 SUM() �Լ�
SELECT COUNT(comm), SUM(comm)
FROM emp;

-- 1_3 AVG() �Լ�
SELECT COUNT(comm), SUM(comm), AVG(comm)
FROM emp;

--==============================================================================================
--==============================================================================================
-- 2. GROUP BY ���� ����� Ư�� �������� �������� �׷�ȭ�ϱ�
-----------------------------------
SELECT deptno, ROUND(AVG(sal+NVL(comm, 0)),1) AVG_SAL
FROM emp
GROUP BY deptno
ORDER BY AVG_SAL;       

-- ORDER BY�� ��ȣ�� ����ص� ��
SELECT deptno, ROUND(AVG(sal+NVL(comm, 0)),1) AVG_SAL
FROM emp
GROUP BY deptno
ORDER BY 2 DESC;

desc emp
desc dept

select * from dept;

SELECT empno, ename, deptno, dname
FROM emp JOIN dept USING(deptno);

SELECT deptno, dname, ROUND(AVG(sal+NVL(comm, 0)),1) AVG_SAL
FROM emp dept JOIN dept USING(deptno)
GROUP BY deptno, dname
ORDER BY 2 DESC;

--==============================================================================================
--==============================================================================================
-- 3. HAVING ���� ����� �׷����� �������� �˻��ϱ�
-- �׷� �Լ��� �������� ����� ��� WHERE ��� HAVIG ���
-- ���� 1
-- enp ���̺��� ��� �޿��� 2000 �̻��� �μ��� �μ� ��ȣ�� ��� �޿��� ���ϼ���.
SELECT deptno, AVG(NVL(sal, 0))
FROM emp
WHERE deptno > 10
GROUP BY deptno
HAVING AVG (NVL(sal, 0)) >= 2000;

--==============================================================================================
--==============================================================================================
-- 4. �ݵ�� �˾ƾ� �ϴ� �پ��� �м� �Լ���
-- 4_1 ROLLUP() �Լ� : �� ���غ� �Ұ踦 ����ؼ� ���� ��
-- ��� ��) �μ��� ������ �� �޿� �� ��� ���� �μ��� ��� �޿��� �����, ��ü ����� ��� �޿��� ��� ���� ���ϼ���.
-- �μ��� ������ ��� �޿� �� ��� �� => GROUP BY deptno, job
-- �μ��� ��� �޿��� ��� ��        => GROUP BY deptno
-- ��ü ����� ��� �޿��� ��� ��   => GROUP BY()
SELECT deptno, job, ROUND(AVG(sal), 1) avg_sal, COUNT(*) cnt_emp
FROM emp
GROUP BY ROLLUP (deptno, job);

-- 4_2 CUBE() �Լ� : �Ұ�� ��ü �հ���� ����ϴ� �Լ�

-- 4_3 GROUPING SETS() �Լ� : �׷��� ������ ���� ���� ���
-- 4_4 LISTAGG() �Լ� : ���� �׷��� ���ִ� �Լ�
-- 4_5 PIVOT() �Լ�
-- 4_6 UNPIVOT() �Լ� : ���� �ִ� ���� Ǯ� ������
-- 4_7 LAG() �Լ�
-- 4_8 RANK() �Լ� : ���� ��� �Լ�
-- 4_11 ROW_NUMBER () �����Լ� : ������ ���̶� ������ ������ �ο���
SELECT empno, ename, job, sal,
        RANK() OVER (ORDER BY sal DESC) sal_rank,
        DENSE_RANK() OVER (ORDER BY sal DESC) sal_dense_rank,
        ROW_NUMBER() OVER (ORDER BY sal DESC) sal_row_num
FROM emp;
--==============================================================================================
--==============================================================================================
