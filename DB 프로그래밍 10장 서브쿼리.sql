-- Sub Query(서브 쿼리)

-- Sub Query 예
SELECT ename, comm
FROM emp
WHERE comm < (SELECT comm
                FROM emp
                WHERE ename = 'WARD');
-- 'WARD'보다 월급(sal)을 많이 받는 사원의 이름, 월급, 부서명을 출력하시오.  << 시험문제!!
SELECT ename, sal, dname
FROM emp e JOIN dept d
ON e.deptno = d.deptno
AND sal > (SELECT  sal
            FROM emp
            WHERE ename = 'WARD');

-- 사장을 제외한 평균월급(sal)보다 작게 받는 사원의 이름, 월급, 부서명을 출력하시오.  << 저번 시험문제!!
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