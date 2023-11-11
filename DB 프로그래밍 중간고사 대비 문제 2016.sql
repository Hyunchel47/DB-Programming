-- 1번 문제
CREATE TABLE STUDENT2019 (
stdno NUMBER(10) PRIMARY KEY,
name VARCHAR(10) NOT NULL,
grade NUMBER(3) DEFAULT 1,
kor NUMBER(5) NOT NULL,
eng NUMBER(5) NOT NULL,
math NUMBER(5) NOT NULL,
toeic NUMBER(5) NOT NULL
);

insert into STUDENT2019 values(201695112, '전인하', 1, 60, 90, 70, 300);
insert into STUDENT2019 values(201695109, '박미경', 1, 60, 50, 50, 400);
insert into STUDENT2019 values(201695107, '이동훈', 1, 60, 70, 80, 700);
insert into STUDENT2019 values(201395114, '김진영', 2, 90, 80, 40, 500);
insert into STUDENT2019 values(201395101, '오유석', 2, 90, 90, 90, 900);
insert into STUDENT2019 values(201295111, '이몽룡', 3, 80, 80, 70, 500);
insert into STUDENT2019 values(201295105, '성춘향', 4, 50, 60, 70, 700);
insert into STUDENT2019 values(201095125, '박지수', 4, 90, 90, 90, 900);
insert into STUDENT2019 values(201995090, '조현철', 3, 100, 100, 100, 900);

-- 2번 문제
SELECT stdno "학번", name "이름", grade "학년", toeic, ROUND((kor+eng+math)/3, 1) "평균성적", ROUND(((kor+eng+math)/3 * 0.8) + (toeic / 10 * 0.2), 0) "총점"
FROM STUDENT2019
ORDER BY "평균성적" DESC;

-- 3번 문제
-- 사원들의 평균인건비(급여(sal) + 수당(comm))가 가장 높은 부서에 소속된 직원들의
-- 사원번호, 이름, 급여(sal)+수당(comm), 직종, 부서명을 출력하시오
-- 단, 월급(급여+수당)은 NULL로 표시하면 안됨. 부서번호가 아니고 부서명을 출력해야함
SELECT empno "사원번호", ename "이름", sal + NVL(comm, 0) "월급", job "직종", dname "부서명"
FROM emp JOIN dept USING (deptno)
WHERE deptno = (SELECT deptno
                FROM emp
                GROUP BY deptno
                HAVING MAX(sal + NVL(comm, 0)) > 4000 );

-- 4번 문제
-- 학생의 학번, 이름, 키, 몸무게, 표준체중, 비만정도(비만/과체중/정상)를 출력해라
-- 표준체중을 키에서 110을 뺀것이라고 하자 / 비만은 몸무게가 표준체중보다 20%이상, 10~20%는 과체중, 그 이하는 정상
-- 비만지수 = ((현재 체중 - 표준 체중)/표준 체중) * 100(%)
SELECT studno, name, height, weight, height-110 "표준체중",
        CASE WHEN ((weight - (height-110))/(height-110)) * 100 >= 20 THEN '비만'
             WHEN ((weight - (height-110))/(height-110)) * 100 >= 10 THEN '과체중'
             ELSE '정상' END "비만정도"
FROM student;

--======================================================================
SELECT ename, deptno, dname, sal, comm, NVL(sal + comm, 0) "평균인건비"
FROM emp join dept USING (deptno)
ORDER BY deptno
;

select deptno,dname, MAX(sal + NVL(comm, 0)) "평균인건비"
from emp join dept using(deptno)
group by deptno, dname
order by "평균인건비" DESC;

select * from STUDENT2019;
select * from emp;
select * from student;