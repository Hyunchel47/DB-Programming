-- 1. 조건문 (IF 문)
------------------------------------------------
-- 1_1 IF~THEN~ELSE~END IF (조건이 2개일 경우 사용)
/*
    IF (조건) THEN
        실행문장;
    ELSE
        실행문장;
    END IF;
*/
    /* 
        예 : professor 테이블에서, 교수번호를 입력받아 그 교수의 profno, name, bonus를 출력하되
            해당 교수의 bonus 값이 0보다 크면 bonus의 금액을 출력하고, 0보다 작거나 없으면
            'Bonus is smaller than 0'이라는 문장을 출력하세요.
    */
    SET VERIFY OFF 
    DECLARE 
        vprofno     professor.profno%TYPE; 
        vname       professor.name%TYPE; 
        vbonus      professor.bonus%TYPE := NULL; 
    BEGIN 
        SELECT profno, name ,bonus INTO vprofno, vname ,vbonus 
        FROM professor 
        WHERE profno =&profno; 
            IF vbonus > 0 THEN 
                DBMS_OUTPUT.PUT_LINE (vname ||' ''s bonus is $' || vbonus); 
            ELSE 
                DBMS_OUTPUT.PUT_LINE (vname ||' ''s bonus is smaller than 0');
            END IF;
    END ;
    /
    
-- 1_2 IF~END IF 문장 (조건이 2개 이상인 경우)
/*
    IF (조건) THEN
        실행문장
    END IF;
    => 이 유형은 조건이 여러 가지일 경우 이 문장을 여러 번 적어야 해서 불편함
*/
    /*
        예 : professor 테이블에서 profno가 1001번인 교수의 profno, name, deptno, dname을 출력하세요
            (단, DNAME의 값은 아래와 같습니다.)
            DEPTNO가 101이면 'Computer Engineering'
            DEPTNO가 102이면 'Multimedia Engineering;
            DEOTNO가 103이면 'Software Engineering'으로 출력하세요.
    */
    SET VERIFY OFF 
    DECLARE 
        v_profno    professor.profno%TYPE;
        v_name      professor.name%TYPE;
        v_deptno    professor.deptno%TYPE;
        v_dname     VARCHAR2(30);
    BEGIN
        SELECT profno, name, deptno
        INTO v_profno, v_name, v_deptno
        FROM professor
        WHERE profno = 1001;
        IF (v_deptno = 101) THEN
            v_dname := 'Computer Engineering';
        END IF;
        IF (v_deptno = 102) THEN
            v_dname := 'Multimedia Engineering';
        END IF;
        IF (v_deptno = 103) THEN
            v_dname := 'Software Engineering';
        END IF;
        DBMS_OUTPUT.PUT_LINE (v_profno || ' / ' || v_name || ' / ' || v_deptno || ' / ' || v_dname);
    END;
    /
-- 1_3 IF ~ THEN ~ ELSIF ~ END IF 문장 (조건이 여러 개일 경우 많이 사용)
/*
    IF (조건) THEN
        실행문장;
    ELSIF (조건) THEN
        실행문장;
    ELSIF (조건) THEN
        실행문장;
    END IF;
*/
    /*
        예 : professor 테이블에서 profno가 1001번인 교수의 prfno, name, deptno, dname을 출력하세요
            (단, DNAME의 값은 아래와 같습니다.)
            DEPTNO가 101이면 'Computer Engineering'
            DEPTNO가 102이면 'Multimedia Engineering;
            DEOTNO가 103이면 'Software Engineering'으로 출력하세요.
    */
    SET VERIFY OFF 
    DECLARE 
        v_profno    professor.profno%TYPE;
        v_name      professor.name%TYPE;
        v_deptno    professor.deptno%TYPE;
        v_dname     VARCHAR2(30);
    BEGIN
        SELECT profno, name, deptno
        INTO v_profno, v_name, v_deptno
        FROM professor
        WHERE profno = 1001;
        IF (v_deptno = 101) THEN
            v_dname := 'Computer Engineering';
        ELSIF (v_deptno = 102) THEN
            v_dname := 'Multimedia Engineering';
        ELSIF (v_deptno = 103) THEN
            v_dname := 'Software Engineering';
        END IF;
        DBMS_OUTPUT.PUT_LINE (v_profno || ' / ' || v_name || ' / ' || v_deptno || ' / ' || v_dname);
    END;
    /

--==============================================================================================
--==============================================================================================
-- 2. CASE 문
------------------------------------------------
-- CASE문은 IF 문장과 같이 비교 조건이 여러 가지일 경우 훨씬 더 간결하고 간단하게 조건을 파악해서 분기시킬 수 있는 제어문
/*
    CASE [조건] 
        WHEN 조건 1 THEN 결과 1 
        WHEN 조건 2 THEN 결과 2
        WHEN 조건 n THEN 결과 n 
    [ELSE 기본값] 
    END ;
*/
    /*
        예 : professor 데이블에서 profno가 1001 번인 교수의 profno, name, deptno, dnam 을 출력하세요
            (단, DNAME의 값은 아래와 같습니다.)
            DEPTNO가 101이면 'Computer Engineering'
            DEPTNO가 102이면 'Multimedia Engineering
            DEOTNO가 103이면 'Software Engineering'으로 출력하세요.
    */
    SET SERVEROUTPUT ON; 
    DECLARE 
        v_profno    professor.profno%TYPE;
        v_name      professor.name%TYPE;
        v_deptno    professor.deptno%TYPE;
        v_dname     VARCHAR2(30);
    BEGIN
        SELECT profno, name, deptno
        INTO v_profno, v_name, v_deptno
        FROM professor
        WHERE profno = 1001;
        v_dname := CASE v_deptno
                    WHEN 101 THEN 'Computer Engineering'
                    WHEN 102 THEN 'Multimedia Engineering'
                    WHEN 103 THEN 'Software Engineering'
                    END;
        DBMS_OUTPUT.PUT_LINE(v_profno || ' / ' || v_name || ' / ' || v_deptno || ' / ' || v_dname);
    END;
    /
    

    /*
        예 2 : EMP 테이블을 사용하여 사용자로부터 사원 번호를 입력받아 해당 사원의 empno, ename, sal, deptno, 인상 후 연봉(up_sal)을 출력하세요.
        단, 부서번호가 10번 부서는 현재 연봉의 30% 인상하고,
        부서번호가 20번 , 30번 부서는 50% 인상하고,
        부서번호가 30번보다 클 경우 20%를 인상하세요.
    */
    SET serveroutput ON
    DECLARE
        vempno      emp.empno%TYPE;
        vename      emp.ename%TYPE;
        vsal        emp.sal%TYPE;
        vdeptno     emp.deptno%TYPE;
        vupsal      emp.sal%TYPE;
    BEGIN
        SELECT empno, ename, sal, deptno
        INTO vempno, vename, vsal, vdeptno
        FROM emp
        WHERE empno =&empno;
            vupsal := CASE
                WHEN vdeptno = 10 THEN vsal * 1.3
                WHEN vdeptno IN (20, 30) THEN vsal * 1.5
                WHEN vdeptno > 30 THEN vsal * 1.2
                ELSE vsal
                END;
            DBMS_OUTPUT.PUT_LINE(vempno||'/'|| vename||'/'||vsal||'/'||vdeptno||'/'||vupsal);
    END;
    /

-- IF-ELSE문으로 사용

--==============================================================================================
--==============================================================================================
-- 3. 반복문
------------------------------------------------
-- 3_1 BASIC LOOP 반복문
-- 주어진 조건이 참일 경우 반복을 중단할 경우 많이 사용됨
/*
    LOOP 
    P1/SOL 문장; 
    P1/SOL 문장; 
    EXIT[ 조건 ]; 
    END LOOP;
*/
    /*
        BASIC LOOP문 사용 예
        Loop 문을 사용하여 화면에 10부터 15까지의 숫자를 출력하세요.
    */
    DECLARE
        no Number := 10;
    BEGIN
        LOOP
            DBMS_OUTPUT.PUT_LINE(no);
            no := no + 1;
            EXIT WHEN no = 16;
        END LOOP;
    END;
    /

-- 3_2 WHILE 반복문
-- WHILE문은 시작부터 조건을 먼저 검사한 후 PL/SQL 문장을 수행함
-- BASIC LOOP문은 조건이 틀려도 PL/SQL문장이 문장이 1회는 실행되지만, WHILE문은 아예 실행되지 않는다.
/*
    WHILE 조건 LOOP 
        PL/SQL 문장 
        PL/SQL 문장 
    ENDLOOP ;
*/
    /*
        WHILE 반복문 사용 예 
        WHILE 반복문을 사용하여 화면에 10부터 15까지의 숫자를 출력하세요.
    */
    DECLARE
        no Number := 10;
    BEGIN
        WHILE no < 16 LOOP
            DBMS_OUTPUT.PUT_LINE(no);
            no := no + 1;
        END LOOP;
    END;
    /

-- 3_3 FOR 반복문
-- 반복횟수를 지정할 수 있다.
/*
    FOR counter IN [REVERSE) start .. end LOOP 
        Statement1; 
        Statement2;
        ...
    END LOOP ; 
*/
    -- 예 1 : 11~15까지 숫자를 화면에 출력
    BEGIN
        FOR i in 10 .. 15 LOOP
            DBMS_OUTPUT.PUT_LINE(i);
        END LOOP;
    END;
    /
    -- 예 2 : 숫자를 역순으로 출력
    BEGIN
        FOR i in REVERSE 10 .. 15 LOOP
            DBMS_OUTPUT.PUT_LINE(i);
        END LOOP;
    END;
    /



SELECT profno, pay, bonus, deptno
FROM professor p JOIN emp e USING (deptno);

select * from professor;
select * from emp;
