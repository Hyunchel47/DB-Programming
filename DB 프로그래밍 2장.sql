-- 문제1
SELECT studno || ',' || name ||'''s weight is ' || weight || 'kg, height is ' || height || 'cm' "문제1번"
FROM student;
--문제2
SELECT grade "학년" , studno "학번", 'weight is ' || weight || 'kg, height is ' || height || 'cm' "체중과 키"
FROM student
WHERE grade = 2 or grade = 3;

--==============================================================================================
-- 1. 문자 함수
-- INITCAP : 입력 값의 첫 글자만 대문자로 변환           INITCAR('abcd') -> Abcd
-- LOWER : 입력 값을 전부 소문자로 변환                  LOWER('ABCD') -> abcd   
-- UPPER : 입력 값을 전부 대문자로 변환                  UPPER('abcd') -> ABCD
-- LENGTH : 입력된 문자열의 길이 값을 출력               LENGTH('한글') -> 2
-- LENGTHB : 입력된 문자열의 길이의 바이트 값을 출력      LENGTHB('한글') -> 4
--==============================================================================================
------------------------------------------------------------------------------------------------
-- LENGTH / LENGTHB 함수 :  입력된 문자열의 길이(바이트 수)를 계산해주는 함수
-- LENGTH(컬럼 or 문자열) / LENGTHB(컬럼 or 문자열)
------------------------------------------------------------------------------------------------
SELECT ename, LENGTH(ename) "LENGTH", LENGTHB(ename) "LENGTHB"
FROM emp
WHERE deptno = 20;

-- 한글의 경우
SELECT '서진수' "NAME", LENGTH('서진수') "LENGTH",
                       LENGTHB('서진수') "LENGTHB"
FROM dual;


------------------------------------------------------------------------------------------------
-- CONCAT() 함수 : ||연산자와 동일한 기능
------------------------------------------------------------------------------------------------
SELECT CONCAT(ename, job)
FROM emp
WHERE deptno = 10;


------------------------------------------------------------------------------------------------
-- SUBSTR() 함수 : 주어진 문자열에서 특정 길이의 문자만 골라낼 때 사용하는 함수
-- SUBSTR('문자열' or 컬럼명, 시작위치, 출력개수)
------------------------------------------------------------------------------------------------
SELECT SUBSTR('abcde', 3, 2) "3,2",     -- 3번째에서 2개 추출
       SUBSTR('abcde', -3, 2) "-3,2",   -- 뒤에서부터 3번째에서 2개 추출
       SUBSTR('abcde', -3, 4) "-3,4"    -- 뒤에서부터 3번째에서 4개 추출 -> 문자부족으로 3개만 출력됨
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
-- INSTR() 함수 : 주어진 문자열이나 컬럼에서 특정 글자의 위치를 찾아주는 함수
-- INSTR('문자열 or 컬럼, 찾는글자, 시작위치, 몇번째인지(기본값은 1))
------------------------------------------------------------------------------------------------
select 'A-B-C-D', INSTR('A-B-C-D', '-', 1, 3) "INSTR"
from dual;
select 'A-B-C-D', INSTR('A-B-C-D', '-', 3, 1) "INSTR"
from dual;
select 'A-B-C-D', INSTR('A-B-C-D', '-', -1, 3) "INSTR"  -- 마이너스(-)시 오른쪽에서 왼쪽으로 결괏값 검색
from dual;   

-- Student 테이블의 tel 컬럼을 사용하여 전공번호(deptno1)가 201번인 학생의 이름, 전화번호, ')'가 나오는 위치
select name, tel, INSTR(tel, ')')
from student
where deptno1 = 201;

SELECT name, tel, INSTR(tel, '3')
FROM student
WHERE deptno1 = 101;

-- SUBSTR/INSTR 퀴즈 ///매우중요!!!
SELECT name, tel, SUBSTR(tel, 1, INSTR(tel, ')')-1) "AREA1",
                  SUBSTR(tel, INSTR(tel, ')')+1, INSTR(tel, '-') - INSTR(tel, ')')-1) "AREA2",
                  SUBSTR(tel, INSTR(tel, ')')+1, INSTR(tel, '-')) "test",
                  SUBSTR(tel, INSTR(tel, '-')) "test2",
                  INSTR(tel, '-'),
                  INSTR(tel, '-') - INSTR(tel, ')')-1
FROM student
WHERE deptno1 = 201;


------------------------------------------------------------------------------------------------
-- REPLACE() 함수 : 주어진 문자열 or 컬럼에서 문자1을 문자2로 바꾸어 출력하는 함수
-- REPLACE('문자열' or 컬럼명, '문자1', '문자2')
------------------------------------------------------------------------------------------------
SELECT ename, REPLACE(ename, SUBSTR(ename,1,2), '**') "REPLACE"
FROM emp
WHERE deptno = 10;

--REPLACE퀴즈
SELECT ename, REPLACE(ename, SUBSTR(ename,2,2), '--') "REPLACE"
FROM emp
WHERE deptno = 20;
--REPLACE퀴즈2
SELECT name, jumin, REPLACE(jumin, SUBSTR(jumin,7,7),'-/-/-/-') "REPLCACE"
FROM student
WHERE deptno1 = 101;
--REPLACE퀴즈3
SELECT name, tel, REPLACE(tel, SUBSTR(tel,5,3),'***') "REPLCACE"
FROM student
WHERE deptno1 = 102;
--REPLACE퀴즈4
SELECT name, tel, REPLACE(tel, SUBSTR(tel, INSTR(tel, '-')+1, 4), '****') "REPLACE"
FROM student
WHERE deptno1 = 101;

select * from emp;



--==============================================================================================
-- 2. 숫자 관련 함수
--==============================================================================================
-- ROUND() 함수 : 주어진 숫자를 반올림한 후 출력
-- ROUND(숫자, 출력을 원하는 자릿수)
------------------------------------------------------------------------------------------------
SELECT ROUND(987.654, 2) "ROUND1",      -- 소수점 두번째(5)에서 반올림
       ROUND(987.654, 0) "ROUND2",      -- 소수점(7)에서 반올림
       ROUND(987.654, -1) "ROUND3"      -- 소수점 앞 한칸(8)에서 반올림
FROM dual;
------------------------------------------------------------------------------------------------
-- TRUNC() 함수 : 주어진 숫자를 버림한 후 출력
-- TRUNC(숫자, 출력을 원하는 자릿수)
------------------------------------------------------------------------------------------------
SELECT TRUNC(987.654, 2) "TRUNC1",
       TRUNC(987.654, 0) "TRUNC2",
       TRUNC(987.654, -1) "TRUNC3"
FROM dual;
------------------------------------------------------------------------------------------------
-- MOD(), CEIL(), FLOOR()함수
------------------------------------------------------------------------------------------------
SELECT MOD(121, 10) "MOD",      -- 나머지 값을 구하는 함수
       CEIL(123.45) "CEIL",     -- 주어진 숫자가 가장 가까운 큰 정수를 구하는 함수
       FLOOR(123.45) "FLOOR"    -- 주어진 함수와 가장 가까운 작은 정수를 구하는 함수
FROM dual;
------------------------------------------------------------------------------------------------
-- POWER() 함수 : 숫자1과 숫자2의 승수를 구해주는 함수
-- POWER(숫자1, 숫자2)
------------------------------------------------------------------------------------------------
SELECT POWER(2, 3)
FROM dual;



--==============================================================================================
-- 3. 날짜 관련 함수들
-- ROUND => 주어진 날짜를 반올림
-- TRUNC => 주어진 날짜를 버림
--==============================================================================================
-- SYSDATE 함수
-- 현재 시스템의 시간을 출력해 주는 함수
------------------------------------------------------------------------------------------------
SELECT SYSDATE FROM dual;

------------------------------------------------------------------------------------------------
-- MONTHS_BETWEEN 함수
-- 두 날짜를 입력받아 두 날짜 사이의 개월 수를 출력하는 함수
------------------------------------------------------------------------------------------------
SELECT MONTHS_BETWEEN('14/09/30', '14/08/31')
FROM dual;

------------------------------------------------------------------------------------------------
-- ADD_MONTHS() 함수
-- 주어진 날짜에 숫자만큼의 달을 추가하는 함수
------------------------------------------------------------------------------------------------
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 1)
FROM dual;

------------------------------------------------------------------------------------------------
-- NEXT_DAY() 함수
-- 주어진 날짜를 기준으로 돌아오는 날짜 출력
------------------------------------------------------------------------------------------------
SELECT SYSDATE, NEXT_DAY(SYSDATE, '월')
FROM dual;

------------------------------------------------------------------------------------------------
-- LAST_DAY() 함수
-- 주어진 날짜가 속한 달의 마지막 날짜 출력
------------------------------------------------------------------------------------------------
SELECT SYSDATE, LAST_DAY(SYSDATE), LAST_DAY('14/05/01')
FROM dual;


--==============================================================================================
-- 4. 형 변환 함수
--==============================================================================================
------------------------------------------------------------------------------------------------
-- TO_CHAR() 함수 : 날짜 -> 문자로 형 변환
-- TO_CHAR(원래 날짜, '원하는 모양')
------------------------------------------------------------------------------------------------
SELECT SYSDATE, TO_CHAR(SYSDATE, 'YYYY') "YYYY",    -- 연도를 4자리로 표현
                TO_CHAR(SYSDATE, 'RRRR') "RRRR",    -- 2000년 이후 y2k버그로 인해 등장한 날짜 표기법/연도 4자리 표현
                TO_CHAR(SYSDATE, 'YY') "YY",        -- 연도를 끝의 2자리만 표시 ex)23
                TO_CHAR(SYSDATE, 'RR') "RR",        -- 연도를 마지막 2자리만 표시  ex) 23
                TO_CHAR(SYSDATE, 'YEAR') "YEAR",    -- 연도의 영문 이름 전체를 표시
                
                TO_CHAR(SYSDATE, 'MM') "MM",        -- 월을 숫자 2자리로 표현 ex)10
                TO_CHAR(SYSDATE, 'MON') "MON",      -- 윈도우용 오라클일 경우 MONTH와 동일
                TO_CHAR(SYSDATE, 'MONTH') "MONTH",  -- 월을 뜻하는 이름 전체를 표시
                
                TO_CHAR(SYSDATE, 'DD') "DD",        -- 일을 숫자 2자리로 표현
                TO_CHAR(SYSDATE, 'DAY') "DAY",      -- 요일에 해당하는 명칭을 표시 / 윈도우는 한글로 표현
                TO_CHAR(SYSDATE, 'DDTH') "DDTH"     -- 몇 번째 날인지를 표시
FROM dual;

-- 형 변환 함수 퀴즈 : 날짜 변환하기1
SELECT studno, name, birthday
FROM student
WHERE TO_CHAR(birthday, 'MM') = '01';
-- 형 변환 함수 퀴즈 : 날짜 변환하기2
SELECT empno, ename, hiredate
FROM emp
WHERE TO_CHAR(hiredate, 'MM') IN(1,2,3);    --WHERE TO_CHAR(hiredate, 'MM') BETWEEN 1 AND 3;
------------------------------------------------------------------------------------------------
-- TO_CHAR() 함수 : 숫자 -> 문자로 형 변환
-- TO_CHAR(1234,'99999') => 1234         9의 개수만큼 자릿수
-- TO_CHAR(1234,'099999') => 001234      빈자리를 0으로 채움
-- TO_CHAR(1234,'$9999') => $1234        $표시를 붙여서 표시
-- TO_CHAR(1234,'9999.99') => 1234.00    소수점 이하를 표시
-- TO_CHAR(12345,'99,999') => 12,345     천 단위 구분 기호를 표시
------------------------------------------------------------------------------------------------
-- 사용 예1 // 1분반 시험문제 + tax10% 구하기
SELECT empno, ename, sal, comm, TO_CHAR((sal*12) + comm, '999,999') "SALARY",
                                TO_CHAR(((sal*12) + comm) * 0.1, '999,999')"TAX"
FROM emp;
-- 사용 예2 // 2분반 시험문제
SELECT name, pay, bonus, TO_CHAR((pay * 12) + bonus, '999,999') "TOTAL"
FROM professor;

-- 형 변환 함수 퀴즈3
SELECT empno, ename, hiredate, '$' || sal "SAL", '$' || TO_CHAR((sal * 12) + comm, '999,999') "SALARY",
                                                 '$' || TO_CHAR(((sal * 12) + comm) + ((sal * 12) + comm) * 0.15, '999,999') "SALARY 15% UP"
FROM emp;


------------------------------------------------------------------------------------------------
-- T0_NUMBER() 함수 : 숫자처럼 생긴 문자를 숫자로 바꾸어 주는 함수
-- TO_NUMBER('숫자처럼 생긴 문자')
------------------------------------------------------------------------------------------------
SELECT TO_NUMBER('5') FROM dual;
SELECT ASCII('A') FROM dual;


------------------------------------------------------------------------------------------------
-- TO_DATE() 함수 : 날짜처럼 생긴 문자를 날짜로 바꿔주는 함수
-- TO_DATE('문자')
------------------------------------------------------------------------------------------------
SELECT TO_DATE('14/05/31') FROM dual;
SELECT TO_DATE('2014/05/31') FROM dual;




--==============================================================================================
-- 5. 일반 함수
-- 함수의 입력되는 값이 숫자, 문자, 날짜 구분 없이 다 사용할 수 있는 함수
--==============================================================================================
-- NVL() 함수 : NULL 값을 만나면 다른 값으로 치환해서 출력하는 함수
-- NVL(컬럼, 치환할 값)
------------------------------------------------------------------------------------------------
SELECT ename, comm, NVL(comm,0),        -- comm 컬럼 값이 null일 경우 null 대신 0으로 치환 
                    NVL(comm, 100)      -- comm 컬럼 값이 null일 경우 null 대신 100으로 치환
FROM emp
WHERE deptno = 30;

-- NVL 함수 퀴즈
SELECT profno, name, pay, bonus, TO_CHAR((pay * 12) + NVL(bonus, 0), '999,999') "TOTAL"
FROM professor
WHERE deptno = 201;


------------------------------------------------------------------------------------------------
-- NVL2() 함수 : NVL 함수의 확장으로 NULL값이 아닐 경우 출력할 값을 지정할 수 있다
-- NVL2(COL1, COL2, COL3) => COL1의 값이 NULL이 아니면 COL2를, NULL이면 COL3을 출력
------------------------------------------------------------------------------------------------
SELECT empno, ename, sal, comm, NVL2(comm, sal+comm, sal * 0) "NVL2"
FROM emp
WHERE deptno = 30;

-- NVL2 함수 퀴즈
SELECT empno, ename, comm, NVL2(comm, 'Exist', 'NULL') "NVL2"
FROM emp
WHERE deptno = 30;

------------------------------------------------------------------------------------------------
-- DECODE() 함수
-- 오라클에서만 사용되는 함수로 IF문을 사용해야 하는 조건문 처리
------------------------------------------------------------------------------------------------
-- 유형1 A가 B일 경우 '1'을 출력하는 경우
-- DECODE (A, B, '1', null) (단, 마지막 null은 생략 가능합니다)
SELECT deptno, name, DECODE(deptno, 101, 'Computer Engineering') "DNAME"
FROM professor;

-- 유형2 A가 B일 경우 '1'을 출력하고 아닐 경우 '2'를 출력하는 경우
-- DECODE(A, B, '1', '2')
SELECT deptno, name, DECODE(deptno, 101, 'Computer Engineering', 'ETC') "DNAME"
FROM professor;

-- 유형3 A가 B일 경우 '1'을 출력하고 A가 C일 경우 '2'를 출력하고 둘 다 아닐 경우 '3'을 출력하는 경우
-- DEC0DE(A, B, '1', C, '2', '3')
SELECT deptno, name, DECODE(deptno, 101, 'Computer Engineering',
                                    102, 'Multimedia Engineering',
                                    103, 'Software Engineering',
                                    'ETC') "DNAME"
FROM professor;

-- 유형4 A가 B일 경우 중에서 C가 D를 만족하면 '1'을 출력하고 C가 D가 아닐 경우 NULL을 출력하는 경우(DECODE 함수 안에 DECODE 함수가 중첩되는 경우)
-- DECODE (A, B, DECODE(C, D, '1', null))
SELECT deptno, name, DECODE(deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!')) "ETC"
FROM professor;

-- 유형5 A가 B일 경우 중에서 C가 D를 만족하면 '1'을 출력하고 C가 D가 아닐 경우 '2'를 출력하는 경우
-- DECODE(A, B, DECODE(C, D, '1', '2'))
SELECT deptno, name, DECODE(deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!', 'GOOD!')) "ETC"
FROM professor;

-- 유형6 A가 B일 경우 중에서 C가 D를 만족하면 '1'을 출력하고 C가 D가 아닐 경우 '2'를 출력하고 A가 B가 아닐 경우 '3'을 출력하는 경우`
SELECT deptno, name, DECODE(deptno, 101, DECODE(name, 'Audie Murphy', 'BEST!', 'GOOD!'), 'N/A') "ETC"
FROM professor;

-- DECODE 퀴즈1
SELECT name, jumin, DECODE(SUBSTR(jumin, 7, 1), 1, 'MAN', 2, 'WOMAN') "Gender"
FROM student
WHERE deptno1 = 101;

-- DECODE 퀴즈2
SELECT name, tel, DECODE(SUBSTR(tel, 1, INSTR(tel, ')')-1), 02, 'SEOUL', 031, 'GYEONGGI',
                                                            051, 'BUSAN', 052, 'ULSAN', 055, 'GYEONGNAM') "LOC"
FROM student
WHERE deptno1 = 101;


------------------------------------------------------------------------------------------------
-- CASE() 문
-- CASE 조건 WHEN 결과1 THEN 출력1 [WHEN결과2 THEN 출력2] ELSE 출력3 END "컬럼명"
-- CASE WHEN {조건} THEN {리턴 값}
------------------------------------------------------------------------------------------------
-- DECODE와 동일하게 '=' 조건으로 사용되는 경우
SELECT name, tel, CASE(SUBSTR(tel, 1, INSTR(tel, ')')-1)) WHEN '02' THEN '서울'
                                                          WHEN '031' THEN '광주'
                                                          WHEN '051' THEN '부산'
                                                          WHEN '052' THEN '울산'
                                                          WHEN '055' THEN '경남'
                                                          ELSE 'ETC' END "LOC"
FROM student
WHERE deptno1 = 201;
-- 다른방식
SELECT name, tel, CASE WHEN SUBSTR(tel, 1, INSTR(tel, ')')-1) = '02' THEN '서울'
                       WHEN SUBSTR(tel, 1, INSTR(tel, ')')-1) = '031' THEN '광주'
                       WHEN SUBSTR(tel, 1, INSTR(tel, ')')-1) = '051' THEN '부산'
                       WHEN SUBSTR(tel, 1, INSTR(tel, ')')-1) = '052' THEN '울산'
                       WHEN SUBSTR(tel, 1, INSTR(tel, ')')-1) = '055' THEN '경남'
                       ELSE 'ETC' END "LOC"
FROM student;
-- DECODE문을 사용해서 작성해보기
SELECT name, tel, DECODE(SUBSTR(tel, 1, INSTR(tel, ')')-1), 02, '서울',
                                                             031, '광주',
                                                             051, '부산',
                                                             052, '울산',
                                                             055, '경남', 'ETC') "LOC"
FROM student
WHERE deptno1 = 201;
-- 서브쿼리로 작성해보기

-- 비교 조건이 '='가 아닌 경우
SELECT name, SUBSTR(jumin, 3, 2) "MONTH",
    CASE WHEN SUBSTR(jumin, 3, 2) BETWEEN '01' AND '03' THEN '1/4'
         WHEN SUBSTR(jumin, 3, 2) BETWEEN '04' AND '06' THEN '2/4'
         WHEN SUBSTR(jumin, 3, 2) BETWEEN '07' AND '09' THEN '3/4'
         WHEN SUBSTR(jumin, 3, 2) BETWEEN '10' AND '12' THEN '4/4'
    END "Quarter"
FROM student;

-- CASE문 퀴즈
SELECT empno, ename, sal, CASE WHEN sal BETWEEN 1 AND 1000 THEN 'Level 1'       -- WHEN sal <= 1000 THEN 'Level 1' 
                               WHEN sal BETWEEN 1001 AND 2000 THEN 'Level 2'
                               WHEN sal BETWEEN 2001 AND 3000 THEN 'Level 3'
                               WHEN sal BETWEEN 3001 AND 4000 THEN 'Level 4'
                               ELSE 'Level 5' END "LEVEL"
FROM emp
ORDER BY sal DESC;



------------------------------------------------------------------------------------------------
-- 교수님이 하신 코드
------------------------------------------------------------------------------------------------
-- NULL값이 하나라도 있으면 산술연산에서 결과는 무조건 NULL로 출력됨
SELECT empno, ename, comm, TO_CHAR((sal*12)+comm, '999,999') "SALARY", 
                           TO_CHAR(((sal*12)+comm) * 0.1, '999,999') "TAX"
FROM emp;

-- NVL을 사용해서 NULL값 대신 0으로 치환하여 결과가 다 나오게 수정
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

