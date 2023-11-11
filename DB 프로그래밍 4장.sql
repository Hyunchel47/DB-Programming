-- USING : 외래키 이름이 같으면 사용
SELECT empno, ename, deptno, dname
FROM emp JOIN dept USING(deptno);

SELECT empno, e.deptno, dname
FROM emp e, dept d
WHERE  e.deptno = d.deptno;

-- 제일 일반적인 방식
SELECT empno, e.deptno, dname
FROM emp e JOIN dept d
ON (e.deptno = d.deptno);

SELECT empno, deptno, dname
FROM emp JOIN dept d
USING(deptno);

--==============================================================================================
--==============================================================================================
-- 2. EQUI JOIN(등가 조인)
-- 선행 테이블에서 데이터를 가져온 후 조인 조건절을 검사해서 동일한 조건을 가진 데이터를 후행 테이블에서 꺼내 오는 방법
--------------------------------------------
-- 사용 예1
SELECT empno, ename, dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;
-- ANSI Join 문법
SELECT empno, ename, dname
FROM emp e JOIN dept d
ON e.deptno = d.deptno;

-- 사용 예2
SELECT s.name "STU_NAME", p.name "PROF_NAME"
FROM student s, professor p
WHERE s.profno = p.profno;
-- ANSI Join 문법
SELECT s.name "STU_NAME", p.name "PROF_NAME"
FROM student s JOIN professor p
ON s.profno = p.profno;
-- USING 사용
SELECT s.name "STU_NAME", p.name"PROF_NAME"
FROM student s JOIN professor p USING (profno);

-- 사용 예3
SELECT s.name "STU_NAME", d.dname "DEPT_NAME", p.name "PROF_NAME"
FROM student s, department d, professor p
WHERE s.deptno1 = d.deptno AND s.profno = p.profno;
-- ANSI Join 문법
SELECT s.name "STU_NAME", d.dname "DEPT_NAME", p.name "PROF_NAME"
FROM student s JOIN department d
ON s.deptno1 = d.deptno
JOIN professor p
ON s.profno = p.profno;

-- 사용 예4
-- student 테이블을 조회하여 1전공(deptno1)이 101번인 학생들의 이름과 각 학생들의 지도교수 이름을 출력하시오.
SELECT s.name "STU_NAME", p.name "PROF_NAME"
FROM student s, professor p
WHERE s.profno = p.profno 
AND s.deptno1 = 101;
-- ANSI Join 문법
SELECT s.name "STU_NAME", p.name "PROF_NAME"
FROM student s JOIN professor p
ON s.profno = p.profno 
AND s.deptno1 = 101;

--==============================================================================================
--==============================================================================================
-- 3. Non-Equi Join(비등가 조인)
-- 같은 조건이 아닌 크거나 작거나 하는 경우의 조건으로 조회를 해야 할 경우 사용
--------------------------------------------
-- 사용 예1
SELECT c.gname "CUST_NAME", c.point "POINT", g.gname "GIFT_NAME"
FROM customer c, gift g
WHERE c.point BETWEEN g.g_start AND g.g_end;
-- ANSI Join 문법
SELECT c.gname "CUST_NAME", c.point "POINT", g.gname "GIFT_NAME"
FROM customer c JOIN gift g
ON c.point BETWEEN g.g_start AND g.g_end;
-- 비교 연사자를 사용 --> BETWEEN보다 성능이 더 좋음
SELECT c.gname "CUST_NAME", c.point "POINT", g.gname "GIFT_NAME"
FROM customer c JOIN gift g
ON c.point >= g.g_start
AND c.point <= g.g_end;

-- 사용 예2
SELECT s.name "STU_NAME", o.total "SCORE", h.grade "CREDIT"
FROM student s, score o, hakjum h
WHERE s.studno = o.studno 
AND o.total >= h.min_point
AND o.total <= h.max_point
ORDER BY score asc;
-- ANSI Join 문법
SELECT s.name "STU_NAME", o.total "SCORE", h.grade "CREDIT"
FROM student s JOIN score o
ON s.studno = o.studno
JOIN hakjum h
ON o.total >= h.min_point
AND o.total <= h.max_point
ORDER BY score asc;

--==============================================================================================
--==============================================================================================
-- 4. OUTER Join(아우터 조인)
-- 한쪽 테이블에는 데이터가 있고, 한쪽 테이블에 없는 경우 데이터가 있는 쪽 테이블의 내용을 전부 출력하게 하는 방법
--------------------------------------------
-- 사용 예1
-- student 테이블과 professor 테이블을 join하여 학생 이름과 지도교수 이름을 출력 
-- 단, 지도교수가 결정되지 않은 학생의 명단도 함께 출력
SELECT s.name STU_NAME, p.name PROF_NAME
FROM student s, professor p
WHERE s.profno = p.profno(+);       -- 데이터가 없는 쪽에 (+)
-- ANSI Outer Join 문법
SELECT s.name STU_NAME, p.name PROF_NAME
FROM student s LEFT OUTER JOIN professor p      -- 왼쪽 데이터가 존재하는 행을 출력
ON s.profno = p.profno;

-- 사용 예2
-- student 테이불과 professor 테이블을 join하여 학생 이름과 지도교수 이름을 출력
-- 단, 지도학생이 결정되는 않은 교수의 명단도 함께 출력
SELECT s.name STU_NAME, p.name PROF_NAME
FROM student s, professor p
WHERE s.profno(+) = p.profno;
-- ANSI Outer Join 문법
SELECT s.name STU_NAME, p.name PROF_NAME
FROM student s RIGHT OUTER JOIN professor p      
ON s.profno = p.profno;

-- 사용 예3
-- student 테이블과 professor 테이블을 Join하여 학생 이름과 지도교수 이름을 출력
-- 단, 지도학생이 결정 안 된 교수 명단과 지도교수가 결정 안 된 학생 명단을 한꺼번에 출력하세요
SELECT s.name STU_NAME, p.name PROF_NAME
FROM student s, professor p
WHERE s.profno(+) = p.profno
UNION
SELECT s.name STU_NAME, p.name PROF_NAME
FROM student s, professor p
WHERE s.profno = p.profno(+);
-- ANSI Full Outer Join 문법
SELECT s.name STU_NAME, p.name PROF_NAME
FROM student s FULL OUTER JOIN professor p      
ON s.profno = p.profno;

--==============================================================================================
--==============================================================================================


-- '컴퓨터정보공학부'에 소속된 학과의 인원수를 출력하시오. << 작년 시험문제
SELECT d.dname, COUNT(*)
FROM student s JOIN department d
ON s.deptno1 = d.deptno
GROUP BY d.dname
HAVING d.dname = 'Computer Engineering';

-- 시험문제
-- 급여는 sal+comm
-- 사장(PRESIDENT)을 제외한 사원의 평균급여가 2000이상인
-- 부서의 부서명과 평균급여를 구하시오
-- 평균급여는 소숫점 1자리까지 표시
SELECT dname "부서명", ROUND(AVG(sal+NVL(comm,0)),1) "평균급여"
FROM emp JOIN dept USING(deptno)
WHERE job NOT IN (SELECT job
                  FROM emp
                  WHERE job = 'PRESIDENT')
GROUP BY dname
HAVING AVG(sal+NVL(comm,0)) >= 2000;

-- '컴퓨터공학과'에 학생에 학번, 학년, 이름, 지도교수

select * from student;
select * from department;
select * from emp;
select * from dept;
desc dept
desc emp
desc student
desc professor
desc department
desc gift
desc customer
desc hakjum
desc score
select g_start, g_end from gift;

-- 시험문제
-- 급여는 sal+comm
-- 사장(PRESIDENT)을 제외한 사원의 평균급여가 2000이상인
-- 부서의 부서명과 평균급여를 구하시오
-- 평균급여는 소숫점 1자리까지 표시
SELECT dname, ROUND(AVG(sal+NVL(comm, 0)),1) "평균 급여"
FROM emp JOIN dept USING(deptno)
WHERE job NOT IN (SELECT job
                  FROM emp
                  WHERE job = 'PRESIDENT')
GROUP BY dname
HAVING AVG(sal+NVL(comm, 0)) >= 2000;

-- '컴퓨터정보공학부'에 소속된 학과의 인원수를 출력하시오. << 작년 시험문제
SELECT dname, COUNT(*) "학과의 인원수"
FROM student s JOIN department d
ON s.deptno1 = d.deptno
GROUP BY dname
HAVING dname = '컴퓨터정보공학부';
