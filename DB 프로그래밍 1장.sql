-- 5. DISTINCT 명령어 : 중복된 값을 제거하고 출력하기
SELECT deptno FROM emp;
SELECT DISTINCT deptno
FROM emp;
-- DISTINCT 키워드는 1개의 컬럼에만 적어도 모든 컬럼에 적용됨
-- 반드시 SELECT 키워드 다음에 위치해야함

--==============================================================================================
--==============================================================================================
-- 9. 다양한 연사자를 활용하는 방법
---------------------------------------------------------------
-- = : 비교 대상에서 같은 조건을 검색
-- !=, <> : 비교 대상에서 같지 않은 조건을 검색
-- > : 비교 대상에서 큰 조건을 검색
-- >= : 비교 대상에서 크거나 같은 조건을 검색
-- < : 비교 대상에서 작은 조건을 검색
-- <= : 비교 대상에서 작거나 같은 조건을 검색
-- BETWEEN a AND b : A와 B 사이에 있는 범위 값을 모두 검색
-- IN(a,b,c) : A이거나 B이거나 C인 조건을 검색
-- NOT IN : IN에 있는 값을 제외하고 검색
-- LIKE : 특정 패턴을 가지고 있는 조건을 검색
-- IS NULL / IS NOT NULL : NULL값을 검색 / NULL값이 아닌 값을 검색
-- A AND B : A 조건과 B 조건을 모두 만족하는 값만 검색
-- A OR B : A 조건이나 B 조건 중 한 가지라도 만족하는 값을 검색
-- NOT A : A가 아닌 모든 조건을 검색
---------------------------------------------------------------
-- IN 연산자로 여러 조건을 간편하게 검색하기
SELECT empno, ename, deptno
FROM emp
WHERE deptno IN (10, 20);   -- 10번 부서와 20번 부서에 근무하는 사람