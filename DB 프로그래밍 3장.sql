-- 1. GROUP 함수
-----------------------------------
-- 1_1 COUNT() 함수
SELECT COUNT(*), COUNT(COMM)
FROM emp;

-- 1_2 SUM() 함수
SELECT COUNT(comm), SUM(comm)
FROM emp;

-- 1_3 AVG() 함수
SELECT COUNT(comm), SUM(comm), AVG(comm)
FROM emp;

--==============================================================================================
--==============================================================================================
-- 2. GROUP BY 절을 사용해 특정 조건으로 세부적인 그룹화하기
-----------------------------------
SELECT deptno, ROUND(AVG(sal+NVL(comm, 0)),1) AVG_SAL
FROM emp
GROUP BY deptno
ORDER BY AVG_SAL;       

-- ORDER BY에 번호를 사용해도 됨
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
-- 3. HAVING 절을 사용해 그룹핑한 조건으로 검색하기
-- 그룹 함수를 조건으로 사용할 경우 WHERE 대신 HAVIG 사용
-- 예시 1
-- enp 테이블에서 평균 급여가 2000 이상인 부서의 부서 번호와 평균 급여를 구하세요.
SELECT deptno, AVG(NVL(sal, 0))
FROM emp
WHERE deptno > 10
GROUP BY deptno
HAVING AVG (NVL(sal, 0)) >= 2000;

--==============================================================================================
--==============================================================================================
-- 4. 반드시 알아야 하는 다양한 분석 함수들
-- 4_1 ROLLUP() 함수 : 각 기준별 소계를 요약해서 보여 줌
-- 사용 예) 부서와 직업별 평군 급여 및 사원 수와 부서별 평균 급여와 사원수, 전체 사원의 평균 급여와 사원 수를 구하세요.
-- 부서와 직업별 평균 급여 및 사원 수 => GROUP BY deptno, job
-- 부서별 평균 급여와 사원 수        => GROUP BY deptno
-- 전체 사원의 평균 급여와 사원 수   => GROUP BY()
SELECT deptno, job, ROUND(AVG(sal), 1) avg_sal, COUNT(*) cnt_emp
FROM emp
GROUP BY ROLLUP (deptno, job);

-- 4_2 CUBE() 함수 : 소계와 전체 합계까지 출력하는 함수

-- 4_3 GROUPING SETS() 함수 : 그룹핑 조건이 여러 개일 경우
-- 4_4 LISTAGG() 함수 : 쉽게 그룹핑 해주는 함수
-- 4_5 PIVOT() 함수
-- 4_6 UNPIVOT() 함수 : 합쳐 있는 것을 풀어서 보여줌
-- 4_7 LAG() 함수
-- 4_8 RANK() 함수 : 순위 출력 함수
-- 4_11 ROW_NUMBER () 순위함수 : 동일한 값이라도 고유한 순위를 부여함
SELECT empno, ename, job, sal,
        RANK() OVER (ORDER BY sal DESC) sal_rank,
        DENSE_RANK() OVER (ORDER BY sal DESC) sal_dense_rank,
        ROW_NUMBER() OVER (ORDER BY sal DESC) sal_row_num
FROM emp;
--==============================================================================================
--==============================================================================================
