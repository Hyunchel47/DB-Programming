--==============================================================================================
--==============================================================================================
-- 2. 묵시적 커서 (Implicit Cursor)
------------------------------------------------
-- 오라클에서 자동으로 선언해주는 SQL커서 / 사용자 입장에서는 생성 유무를 알 수 없음

-- 2_1 묵시적 커서 속성 (Cursor Attribute)
    /*
        SQL%ROWCOUNT
          -> 해당 커서에서 실행한 총 행의 개수 (가장 마지막 행이 몇 번째 행인지 카운트 합니다)를 반환합니다.
        SQL%FOUND
          -> 해당 커서 안에 아직 수행해야 할 데이터가 있을 경우 TRUE(참) 값을 반환하고
             없을 경우 FALSE (거짓)의 값을 반환하는 속성입니다.
        SQL%NOTFOUND
          -> 해당 커서 안에 수행해야 할 데이터가 없고 TRUE(참) 값을 반환하고
             있을 경우 FALSE(거짓)의 값을 반환하는 속성입니다.
        SQL%ISOPEN
          -> 현재 묵시적 커서가 메모리에 OPEN 되어 있을 경우네는 TRUE(참) 값을,
             그렇지 않을 경우에는 FALSE(거짓) 값을 가지는 속성입니다.
    */
    
-- 2_2 묵시적 커서 사용
    -- 예 : EMP 테이블에서 sal을 조회한 화면
    SELECT sal
    FROM emp
    ORDER BY 1;
    
    DECLARE
    BEGIN
        delete emp
        WHERE sal < 1000;
        DBMS_OUTPUT.PUT_LINE('=================================');
        DBMS_OUTPUT.PUT_LINE('1000 LESS THEN : ' || SQL%ROWCOUNT || ' rows deleted.');
        delete emp
        WHERE sal between 1000 and 2000;
        DBMS_OUTPUT.PUT_LINE('=================================');
        DBMS_OUTPUT.PUT_LINE('1000 - 2000 : ' || SQL%ROWCOUNT || ' rows deleted.');
    END;
    /
    
-- 2_3 묵시적 커서와 FOR LOOP문 활용하기
DECLARE
BEGIN
    DBMS_OUTPUT.PUT_LINE(' Information about department name and location');
    DBMS_OUTPUT.PUT_LINE('-----------------------------------------------');
    FOR dept IN (SELECT dname, build
                 FROM department
                 WHERE build IS NOT NULL
                 ORDER BY 1)
    LOOP
        DBMS_OUTPUT.PUT_LINE(dept.dname || ' ---> ' || dept.build);
    END LOOP;
END;
/
    
--==============================================================================================
--==============================================================================================
-- 3. 명시적 커서 (Explicit Cursor)
------------------------------------------------
-- 3_1 명시적 커서 속성 (Cursor Attribute)
    /*
        커서이름%ROWCOUNT
          -> FETCH 문에 의해 읽힌 데이터 총 행의 수를 가지는 속성입니다.
             가장 마지막에 처리된 행이 몇 번째인지를 반환해줍니다.
        커서이름%FOUND
          -> FETCH 문이 수행되었을 경우, 읽혀진(FETCH) 행이 있다면 TRUE(참) 값을,
             그렇지 않다면 FALSE(거짓) 값을 가지는 속성입니다.
        커서이름%NOTFOUND
          -> FETCH 문이 수행되었을 경우, 읽혀진(FETCH) 행이 없다면 TRUE(참) 값을,
             그렇지 않다면 FALSE(거짓) 값을 가지는 속성입니다.
        커서이름%ISOPEN
          -> 명시적 커서가 메모리에 확보(선언)되어 있을 경우에는 TRUE(참) 값을,
             그렇지 않을 경우 FALSE(거짓) 값을 가지는 속성입니다.
    */

--==============================================================================================
--==============================================================================================
-- 4. 명시적 커서 (Explicit Cursor) 처리 단계
------------------------------------------------


--==============================================================================================
--==============================================================================================

-- 4.4 명시적 커서 사용 예
SET serveroutput ON
DECLARE
    v_empno     NUMBER(5);
    v_ename     VARCHAR2(30);
    v_sal       NUMBER(6);
    CURSOR cur1 IS
        SELECT empno, ename, sal
        FROM emp
        WHERE deptno = 10;
BEGIN
    OPEN cur1;
LOOP
    FETCH cur1 INTO v_empno, v_ename, v_sal;
    EXIT WHEN cur1%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE(v_empno||' '|| v_ename || ' ' || v_sal);
END LOOP;
    CLOSE cur1;
END;
/

-------------------------------------------
/**
    프로시저 명 : show_emp()
    파라미터 : deptno
    실행 : show_emp(10)
          show_emp(20)
          show_emp(30)
    결과 :
    ACCOUNT 부서의 사원은 다음과 같습니다.
**/

SET serveroutput ON
CREATE OR REPLACE PROCEDURE show_emp (deptno IN NUMBER) IS
    v_empno     NUMBER(5);
    v_ename     VARCHAR2(30);
    v_sal       NUMBER(6);
BEGIN
     DBMS_OUTPUT.PUT_LINE(decode(deptno, 10, 'ACCOUNT', 20, 'RESEARCH', 30, 'SALES') || ' 부서의 사원은 다음과 같습니다:');
    FOR emp_rec IN (SELECT empno, ename, sal FROM emp WHERE deptno = deptno) LOOP
        DBMS_OUTPUT.PUT_LINE(emp_rec.empno || ' ' || emp_rec.ename || ' ' || emp_rec.sal);
    END LOOP;
END;
/

--==============================================================================================
--==============================================================================================
-- 6. 파라미터 Explicit Cursor
/*
    CURSOR curosor_name
    [(parameter_name dataTYPE, ...)]
    IS
    select-statement;
*/

SET serveroutput ON
DECLARE
CURSOR prof_cur (v_deptno IN NUMBER)
IS SELECT *
    FROM professor
    WHERE deptno = v_deptno;
v_prof  professor%ROWTYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=======================================');
    DBMS_OUTPUT.PUT_LINE('PRINT 101 Dept Professor''s No. And Professor''s Name');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------');  
    OPEN prof_cur(101);
        LOOP
            FETCH prof_cur INTO v_prof;
            EXIT WHEN prof_cur%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(v_prof.profno || ' Professor''s name is ' || v_prof.name);
        END LOOP;
    CLOSE prof_cur;
    DBMS_OUTPUT.PUT_LINE('=======================================');
    DBMS_OUTPUT.PUT_LINE('PRINT 102 Dept Professor''s No. And Professor''s Name');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------');
        OPEN prof_cur(102);
            LOOP
                FETCH prof_cur INTO v_prof;
                EXIT WHEN prof_cur%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(v_prof.profno || ' Professor''s name is ' || v_prof.name);
            END LOOP;
        CLOSE prof_cur;
END;
/

-- FOR문으로 해보기
SET serveroutput ON
DECLARE
    CURSOR prof_bydept (v_deptno IN NUMBER)
    IS 
        SELECT *
        FROM professor
        WHERE deptno = v_deptno;
    
    v_prof  professor%ROWTYPE;
BEGIN
    FOR dept_number IN 101..102 LOOP
        DBMS_OUTPUT.PUT_LINE('=======================================');
        DBMS_OUTPUT.PUT_LINE(dept_number || ' Dept Professor''s No. And Professor''s Name');
        DBMS_OUTPUT.PUT_LINE('---------------------------------------');  
    
        OPEN prof_bydept(dept_number);
        LOOP
            FETCH prof_bydept INTO v_prof;
            EXIT WHEN prof_bydept%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(v_prof.profno || ' Professor''s name is ' || v_prof.name);
        END LOOP;
        CLOSE prof_bydept;
    END LOOP;
END;
/

select * from emp;
select * from dept;
