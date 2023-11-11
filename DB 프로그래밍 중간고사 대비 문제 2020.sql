-- 1번 문제
CREATE TABLE ORDER2020 (
orderno VARCHAR2(5),    -- 주문번호
bookno NUMBER(5),       -- 도서번호
orderdate DATE NOT NULL,    -- 주문날짜
price NUMBER(6) DEFAULT 5000,   -- 단가
volume NUMBER(3) DEFAULT 1,     -- 수량
PRIMARY KEY (orderno, bookno)   -- 복합 기본 키 설정
);

insert into ORDER2020 values('A100', 1122, '2019-03-03', 9500, 2);
insert into ORDER2020 values('A100', 1234, '2019-03-03', 9000, 2);
insert into ORDER2020 values('A200', 2345, '2019-04-06', 7000, 3);
insert into ORDER2020 values('A200', 1122, '2019-04-06', 9500, 2);
insert into ORDER2020 values('A300', 1122, '2019-05-10', 9500, 4);
insert into ORDER2020 values('A300', 3456, '2019-05-10', 10000, 3);
insert into ORDER2020 values('A400', 2345, '2019-06-15', 7000, 2);
insert into ORDER2020 values('A400', 1122, '2019-06-15', 9500, 2);
-- 기본값을 사용하여 데이터 삽입 (단가와 수량은 기본값이 사용됨)
--INSERT INTO ORDER2020 (orderno, bookno, orderdate) VALUES ('A300', 1122, '2019-05-10');

-- 2번 문제
-- ORDER2020에서 주문별 결제액을 구하라.
-- 출력내용 : 주문번호, 판매액, 배송료, 결제액 / 배송료는 2,500원 (5만원 이상 무료)
-- 금액은 천원 단위로 콤포(,) 표시
SELECT orderno "주문번호", TO_CHAR(SUM(price * volume), '999,999') "판매액",
                CASE WHEN SUM(price * volume) >= 50000 THEN '무료'
                     ELSE '2,500' END "배송료",
                CASE WHEN SUM(price * volume) >= 50000 THEN TO_CHAR(SUM(price * volume), '999,999')
                ELSE TO_CHAR(SUM(price * volume + 2500), '999,999')
                END "결재액"
FROM ORDER2020
GROUP BY orderno;

-- 3번 문제
-- '포항본사'에 근무하지 않는 사원들의 고용형태 별로 평균연봉을 출력
-- 고용형태, 평균연봉을 출력하라 / 단, 평균연봉은 소수점 1자리 표시
SELECT e.emp_type "고용형태", ROUND(AVG(pay), 1) "평균연봉"
FROM emp2 e JOIN dept2 d
ON e.deptno = d.dcode
WHERE d.AREA NOT IN (SELECT d2.area
                    FROM dept2 d2
                    WHERE d2.AREA = '포항본사'
                    )
GROUP BY e.emp_type;

-- 4번 문제
-- professor 테이블에 '컴퓨터정보학부' 소속 전공의 학생들을 출력하라.
-- 출력 : 학번, 이름, 학년, 전공명
-- 전공순으로 출력, 저학년 순, 학번 순
SELECT studno "학번", name "이름", grade "학년", dname "전공명"
FROM student s JOIN department d
ON s.deptno1 = d.deptno
--WHERE dname = '컴퓨터정보학부'
ORDER BY "전공명" ,"학년", "학번";




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
WHERE d.area != '포항본사'
ORDER BY e.emp_type desc;

SELECT EMP_TYPE, ROUND(AVG(PAY), 1) AS "평균연봉"
FROM EMP2
WHERE DEPTNO NOT IN (
    SELECT DCODE
    FROM DEPT2
    WHERE DNAME = '포항본사'
) OR DEPTNO IS NULL
GROUP BY EMP_TYPE
ORDER BY EMP_TYPE;