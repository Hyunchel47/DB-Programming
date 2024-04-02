-- Sub Query(���� ����)

-- Sub Query ��
SELECT ename, comm
FROM emp
WHERE comm < (SELECT comm
                FROM emp
                WHERE ename = 'WARD');
-- 'WARD'���� ����(sal)�� ���� �޴� ����� �̸�, ����, �μ����� ����Ͻÿ�.  << ���蹮��!!
SELECT ename, sal, dname
FROM emp e JOIN dept d
ON e.deptno = d.deptno
AND sal > (SELECT  sal
            FROM emp
            WHERE ename = 'WARD');

-- ������ ������ ��տ���(sal)���� �۰� �޴� ����� �̸�, ����, �μ����� ����Ͻÿ�.  << ���� ���蹮��!!
SELECT ename, sal, dname
FROM emp e JOIN dept d
ON e.deptno = d.deptno
AND job != 'PRESIDENT'
AND sal < (SELECT AVG(sal)
            FROM emp);
            
select ename, sal from emp;
SELECT ename, job
FROM emp
WHERE job != 'PRESIDENT';

SELECT * FROM EMP;