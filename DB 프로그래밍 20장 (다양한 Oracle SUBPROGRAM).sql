-- 1. PROCEDURE (프로시저)
------------------------------------------------
-- 사용자가 어떤 작업을 처리하기 위해 만드는 PL/SQL 블록
/*
    생성문법
    CREATE OR REPLACE PROCEDURE procedure_name
    [( parameter1 [mode1] datatype1,
       parameter2 [mode2] datatype2,
       ... )]
    IS | AS
    PL/SQL Block;
*/
    -- 예 1. 부서번호가 30번인 사람들의 JOB을 'MANAGER'로 변경하는 프로시저
    CREATE OR REPLACE PROCEDURE update_30
    IS
    BEGIN
        UPDATE emp
        SET job = 'MANAGER'
        WHERE deptno = 30;
    END;
    /

    -- 예 2. 사번을 입력받아 급여를 인상하는 PROCEDURE

    -- 예 3. 사번을 입력받아 그 사원의 이름과 급여를 출력하는 프로시저
    CREATE OR REPLACE PROCEDURE ename_sal
        (vempno     emp.empno%TYPE)     -- 사용자로부터 입력받는 값을 저장할 변수 선언
    IS
        vename  emp.ename%TYPE;     -- DB에서 가져온 값을 저장할 변수 선언
        vsal    emp.sal%TYPE;
    BEGIN
        SELECT ename, sal
        INTO vename, vsal
        FROM emp
        WHERE empno = vempno;
        
        DBMS_OUTPUT.PUT_LINE ('Name is ' || vename);
        DBMS_OUTPUT.PUT_LINE ('Sal is ' || vsal);
    END;
    /
    
    EXEC ename_sal(7902);
    
    -- 예 4. OUT모드 파라미터 사용 예
    CREATE OR REPLACE PROCEDURE info_emp
        (v_empno    IN  emp.empno%TYPE,
         v_ename    OUT emp.ename%TYPE,     -- 이름값을 저장할 변수
         v_sal      OUT emp.sal%TYPE)       -- 급여를 저장할 변수
    IS
    BEGIN
        SELECT ename, sal INTO v_ename, v_sal
        FROM emp
        WHERE empno = v_empno;
    END;
    /
    
    DECLARE
        v_ename     emp.ename%TYPE;
        v_sal       emp.sal%TYPE;
    BEGIN
        info_emp(7900, v_ename, v_sal);
        DBMS_OUTPUT.PUT_LINE(v_ename || ' ''s salary is ' || v_sal);
    END;
    /

--==============================================================================================
--==============================================================================================
-- 2. FUNCTION
------------------------------------------------
/*
    CREATE [OR REPLACE] FUNCTION function_name
        [(parameter1 [mode1] datatype1,
          parameter2 [mode2] datatype2,
        ...)]
    RETURN datatype
    IS | AS
    PL/SQL Block;
*/
    /*
        예 1) 숫자 데이터 리턴하는 함수 만들기
              - 부서번호를 입력받아 해당 부서의 최고 급여액을 출력하는 함수
    */
    CREATE OR REPLACE FUNCTION max_sal
        (v_deptno   emp.deptno%TYPE)
    RETURN NUMBER
    IS
        max_sal     emp.sal%TYPE;
    BEGIN
        SELECT max(sal) INTO max_sal
        FROM emp
        WHERE deptno = v_deptno;
        RETURN max_sal;     -- 데이터 형이 3번줄의 형과 같아야 한다
    END;
    /
    
    SELECT max_sal(10) FROM dual;
    
    SELECT deptno, max_sal(deptno)
    FROM emp
    GROUP BY deptno
    ORDER BY 1;
    
    /*
        예 2) 날짜 데이터 리턴하는 함수 만들기
              - 부서번호를 입력받은 후 해당 부서에서 근속년수가 가장 적은 사람의 이름과 입사일을 출력하는 함수를 작성하세요.
    */
    CREATE OR REPLACE FUNCTION max_hiredate
        (v_deptno   NUMBER)
    RETURN DATE
    IS
        v_hiredate      emp.hiredate%TYPE;
    BEGIN
        SELECT max(hiredate) INTO v_hiredate
        FROM emp
        WHERE deptno = v_deptno;
        RETURN v_hiredate;
    END;
    /
    
    ALTER SESSION SET NLS_DATE_FORMAT = 'RRRR-MM-DD';
    SELECT max_hiredate(10) FROM dual;
    
    SELECT deptno, max_hiredate(deptno)
    FROM emp
    GROUP BY deptno
    ORDER BY 1;
    /*
    SELECT d.deptno, ename, max_hiredate(d.deptno)
    FROM emp e, dept d
    WHERE d.deptno = e.deptno(+) AND max_hiredate(d.deptno) = e.hiredate(+)
    GROUP BY d.deptno
    ORDER BY 1;
    */
    
    /*
        예 3. 문자 데이터 리턴하는 함수 만들기
              - 교수번호를 입력받아 해당 교수의 부서명을 알려주는 함수 작성하기
    */
    CREATE OR REPLACE FUNCTION dname
        (v_profno    IN   professor.profno%TYPE)
    RETURN VARCHAR2
    IS
        v_dname     department.dname%TYPE;
    BEGIN
        SELECT dname INTO v_dname
        FROM department
        WHERE deptno = (SELECT deptno
                        FROM professor
                        WHERE profno = v_profno);
        RETURN v_dname;
    END;
    /
    
    SELECT name, dname(profno) dname
    FROM professor;
    
    /*
        예 4. 생성된 함수 조회하기
    */
    SELECT text
    FROM user_source
    WHERE type = 'FUNCTION'
    AND name = 'MAX_SAL';
    
    
    -- 다른 예
    CREATE OR REPLACE FUNCTION min_sal
        (v_deptno   emp.deptno%TYPE)
    RETURN NUMBER
    IS
        min_sal     emp.sal%TYPE;
    BEGIN
        SELECT min(sal) INTO min_sal
        FROM emp
        WHERE deptno = v_deptno;
        RETURN min_sal;
    END;
    /
    CREATE OR REPLACE FUNCTION avg_sal
        (v_deptno   emp.deptno%TYPE)
    RETURN NUMBER
    IS
        avg_sal     emp.sal%TYPE;
    BEGIN
        SELECT avg(sal) INTO avg_sal
        FROM emp
        WHERE deptno = v_deptno;
        RETURN avg_sal;
    END;
    /
    select dname, max_sal(deptno) max_sal
    from dept
    order by 2
    /
    
    select dname, max_sal(deptno) max_sal,
            min_sal(deptno) min_sal,
            avg_sal(deptno) avg_sal
    from dept
    order by deptno
    /
    
--==============================================================================================
--==============================================================================================
-- 3. Oracle PACKAGE (패키지)
------------------------------------------------
    /*
        예 ) member 테이블에 등록된 회원들의 성별과 아이디 검색과 비밀번호를 검색해 주는 패키지입니다
            - 사용자 이름을 입력받은 후 남자인지 여자인지를 구분하는 find_sex 프로시저,
            - 사용자 이름과 주민번호를 입력받아 회원의 아이디를 찾아주는 find_id 프로시저,
            - 사용자 아이디와 연상단어를 입력받아 회원의 비밀번호를 알려주는 find_pwd 프로시저
    */
    SELECT * FROM member;
    
    -- STEP 1 : PACKAGE 선언부를 생성합니다.
    CREATE OR REPLACE PACKAGE member_mg
    IS
    PROCEDURE find_sex (v_name  member.name%TYPE);
    PROCEDURE find_id
        (v_name     member.name%TYPE,
         v_no       member.jumin%TYPE);
    PROCEDURE find_pwd
        (v_id   IN  member.id%TYPE,
         v_an   IN  member.an_key_dap%TYPE);
    END member_mg;
    /
    
    -- STEP 2 : PACKAGE BODY부를 생성합니다.
    CREATE OR REPLACE PACKAGE BODY member_mg
    AS
        PROCEDURE find_sex (v_name  member.name%TYPE)   -- 성별을 조회하는 프로시저
    IS
        v_name2     member.name%TYPE;
        v_gender    CHAR(6);
        v_count     NUMBER := 0;
        exc_noname  EXCEPTION;  
        exc_many    EXCEPTION;
    BEGIN
        SELECT count(*) INTO v_count
        FROM member
        WHERE name = v_name;
        IF v_count = 0 THEN
            RAISE exc_noname;
        ELSIF v_count >= 2 THEN
            RAISE exc_meny;
        ELSE
            SELECT name, CASE WHEN SUBSTR(jumin, 7, 1) IN (1, 3)
                              THEN 'MAN'
                              ELSE 'WOMAN'
                              END
            INTO v_name2, v_gender
            FROM member
            WHERE name = v_name;
                DBMS_OUTPUT.PUT_LINE(v_name2 || ' ''s gender is ' || v_gender);
        END IF;
    EXCEPTION
        WHEN exc_noname THEN
            RAISE_APPLICATION_ERROR(-20001, 'No Name !');
        WHEN exc_many THEN
            RAISE_APPLICATION_EROOR(-20002, 'Many name !! Check Your Name!');
        END find_sex;
    PROCEDURE find_id
        (v_name     member.name%TYPE,
         v_no       member.jumin%TYPE)
    IS
        v_count     NUMBER := 0;
        v_count2    NUMBER := 0;
        v_name2     member.name%TYPE;
        v_id2       member.id%TYPE;
        exc_noname  EXCEPTION ;
        exc_nojumin EXCEPTION;
    BEGIN
        SELECT count(*) INTO v_count
        FROM member
        WHERE name = v_name;
        IF v_count = 0 THEN
            RAISE exc_noname;
        ELSE
            SELECT count(*) INTO v_count2
            FROM member
            WHERE jumin = v_no;
            IF v_count2 = 0 THEN
                RAISE exc_nojumin;
            ELSE
                SELECT name, id INTO v_name2, v_id2
                FROM member
                WHERE name = v_name;
            END IF;
        END IF;
        DBMS_OUTPUT.PUT_LINE(v_name2 || ' ''s ID is ' || v_id2);
    EXCEPTION
        WHEN exc_noname
            THEN RAISE_APPLICATION_ERROR(-20001, 'No Name !');
        WHEN exc_nojumin
            THEN RAISE_APPLICATION_ERROR(-20002, 'No Number!');
    END find_id;
    
    PROCEDURE find_pwd
        (v_id   IN  member.id%TYPE,
         v_an   IN  member.an_key_dap%TYPE)
    IS
        v_count     NUMBER  := 0;
        v_id2       member.id%TYPE;
        v_an_dap    member.an_key_dap%TYPE;
        v_pw        member.passwd%TYPE;
        exc_noid    EXCEPTION;
        exc_noan    EXCEPTION;
    BEGIN
        SELECT count(*) INTO v_count
        FROM member
        WHERE id = v_id;
    IF v_count = 0 THEN
        RAISE exc_noid;
    ELSE
        SELECT an_key_dap INTO v_an_dap
        FROM member
        WHERE id = v_id;
        IF v_an_dap = v_an THEN
            SELECT id, passwd INTO v_id, v_pw
            FROM member
            WHERE id = v_id;
        ELSE RAISE exc_noan;
        END IF;
    END IF;
    DBMS_OUTPUT.PUT_LINE(v_id || ' ''s password is ' || v_pw);
    EXCEPTION
        WHEN exc_noid
            THEN RAISE_APPLICATION_ERROR (-20003, 'No ID !');
        WHEN exc_noan
            THEN RAISE_APPLICATION_ERROR (-20004, 'No Answer !');
    END find_pwd;
    END member_mg;
    /
    
    
    CREATE OR REPLACE PACKAGE BODY member_mg
AS
    PROCEDURE find_sex (v_name  member.name%TYPE)   -- 성별을 조회하는 프로시저
    IS
        v_name2     member.name%TYPE;
        v_gender    CHAR(6);
        v_count     NUMBER := 0;
        exc_noname  EXCEPTION;  
        exc_many    EXCEPTION;
    BEGIN
        SELECT count(*) INTO v_count
        FROM member
        WHERE name = v_name;
        
        IF v_count = 0 THEN
            RAISE exc_noname;
        ELSIF v_count >= 2 THEN
            RAISE exc_many;
        ELSE
            SELECT name, CASE WHEN SUBSTR(jumin, 7, 1) IN ('1', '3')
                              THEN 'MAN'
                              ELSE 'WOMAN'
                              END
            INTO v_name2, v_gender
            FROM member
            WHERE name = v_name;
            
            DBMS_OUTPUT.PUT_LINE(v_name2 || ' ''s gender is ' || v_gender);
        END IF;
    EXCEPTION
        WHEN exc_noname THEN
            RAISE_APPLICATION_ERROR(-20001, 'No Name !');
        WHEN exc_many THEN
            RAISE_APPLICATION_ERROR(-20002, 'No Number!');
    END find_sex;

    PROCEDURE find_id
        (v_name     member.name%TYPE,
         v_no       member.jumin%TYPE)
    IS
        v_count     NUMBER := 0;
        v_count2    NUMBER := 0;
        v_name2     member.name%TYPE;
        v_id2       member.id%TYPE;
        exc_noname  EXCEPTION;
        exc_nojumin EXCEPTION;
    BEGIN
        SELECT count(*) INTO v_count
        FROM member
        WHERE name = v_name;
        
        IF v_count = 0 THEN
            RAISE exc_noname;
        ELSE
            SELECT count(*) INTO v_count2
            FROM member
            WHERE jumin = v_no;
            
            IF v_count2 = 0 THEN
                RAISE exc_nojumin;
            ELSE
                SELECT name, id INTO v_name2, v_id2
                FROM member
                WHERE name = v_name;
            END IF;
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(v_name2 || ' ''s ID is ' || v_id2);
        
    EXCEPTION
        WHEN exc_noname THEN
            RAISE_APPLICATION_ERROR(-20001, 'No Name !');
        WHEN exc_nojumin THEN
            RAISE_APPLICATION_ERROR(-20002, 'No Number!');
    END find_id;

    PROCEDURE find_pwd
        (v_id   IN  member.id%TYPE,
         v_an   IN  member.an_key_dap%TYPE)
    IS
        v_count     NUMBER  := 0;
        v_id2       member.id%TYPE;
        v_an_dap    member.an_key_dap%TYPE;
        v_pw        member.passwd%TYPE;
        exc_noid    EXCEPTION;
        exc_noan    EXCEPTION;
    BEGIN
        SELECT count(*) INTO v_count
        FROM member
        WHERE id = v_id;

        IF v_count = 0 THEN
            RAISE exc_noid;
        ELSE
            SELECT an_key_dap INTO v_an_dap
            FROM member
            WHERE id = v_id;

            IF v_an_dap = v_an THEN
                SELECT id, passwd INTO v_id2, v_pw
                FROM member
                WHERE id = v_id;
            ELSE
                RAISE exc_noan;
            END IF;
        END IF;

        DBMS_OUTPUT.PUT_LINE(v_id || ' ''s password is ' || v_pw);
        
    EXCEPTION
        WHEN exc_noid THEN
            RAISE_APPLICATION_ERROR (-20003, 'No ID !');
        WHEN exc_noan THEN
            RAISE_APPLICATION_ERROR (-20004, 'No Answer !');
    END find_pwd;
    END member_mg;
    /

    
    -- STEP 3 : 생성된 PACKAGE를 테스트합니다.
    -- find_sex Procedure를 테스트합니다.
    SET serveroutput ON
    EXEC member_mg.find_sex('Nicholas Cage');
    EXEC member_mg.find_sex('Jodie Foster');
    
    -- 등록되지 않은 이름을 입력한 후 에러를 확인합니다.
    SET serveroutput ON
    EXEC member_mg.find_sex('Meg Ryan');
    BEGIN member_mg.find_sex('Meg Ryan'); END;
    
    -- find_id PROCEDURE를 테스트합니다.
    -- 이 프로시저는 이름과 주민번호를 입력하면 아이디를 검색하는 기능을 합니다.


--==============================================================================================
--==============================================================================================
-- 4. TRIGGER (트리거)
------------------------------------------------
-- 특정 사건이 발생할 때마다 묵시적(자동)으로 지정된 PL/SQL 트리거 블록을 실행하는 기능
-- 트리거는 별도 실행 X, 오직 트리거 생성 시 정의한 특정사건에 의해서만 묵시적인 자동실행됨

-- 4_3 TRIGGER 구조
/*
    CREATE [OR REPLACE] TRIGGER tigger_name
    timing
        event1 [OR event2 OR event3 ...]
    ON {table_name | view_name | SCHEMA | DATABASE}
    [REFERENCING OLD AS old | NEW AS new]
    [FOR EACH ROW [WHEN (condition)]]
        TRIGGER_BODY
        
    - timing : 트리거가 실행되는 시점을 지정 | event 발생 전후를 의미하는 BEFORE, AFTER가 있음
               트리거가 특정 뷰에 대한 DMS일 경우 INSTEAD OF를 사용     
*/

-- 4_4 TRIGGER 관련 권한
-- TRIGGER를 생성, 변경 및 삭제할 수 있는 권한
GRANT CREATE TRIGGER TO SCOTT;      -- 생성
GRANT ALTER ANY TRIGGER TO SCOTT;   -- 변경
GRANT DROP ANY TRIGGER TO SCOTT;    -- 삭제
-- 데이터베이스에서 TRIGGER를 생성할 수 있는 권한
GRANT ADMIN IS TER DATABASE TRIGGER TO SCOTT;
    /*
        예 1. 테이블에 데이터를 입력할 수 있는 시간 지정하기 
             (테이블 전체가 대상이므로 문장 레벨 TRIGGER를 사용합니다)
    */
    --GRANT create trigger TO scott;
    
    drop table tab_order;
    
    CREATE TABLE tab_order
    (ord_no     NUMBER,
     ord_name   VARCHAR2(10),
     ord_date   DATE);
     
    CREATE OR REPLACE TRIGGER tri_order
    BEFORE INSERT ON tab_order
    BEGIN
        IF (TO_CHAR(SYSDATE, 'HH24:MI') NOT BETWEEN '16:00' AND '16:50') THEN       -- 입력시간이 16:00 ~ 16:50분일 경우만 입력 허용
            RAISE_APPLICATION_ERROR(-20100, 'Time Error!!');                        -- 그 외 시간일 경우 에러를 발생
        END IF;
    END;
    /
    
    SELECT SYSDATE FROM DUAL;
    
    INSERT INTO tab_order
    VALUES(1, 'apple', SYSDATE);
    
    /*
        예 2. 테이블에 입력될 데이터 값을 지정하고 그 값 이외에는 에러를 발생시키기
    */
    DROP TRIGGER tri_order2;
    CREATE OR REPLACE TRIGGER tri_order2
    BEFORE INSERT ON tab_order
    FOR EACH ROW
    BEGIN
        IF :NEW.ord_name != 'apple' THEN
            RAISE_APPLICATION_ERROR(-20200, 'Incorrect Name!');
        END IF;
    END;
    /
    
    -- 신규 내용을 입력하는데 앞에서 생성한 문장레벨 트리거로 입해 입력이 안됩니다.
    INSERT INTO tab_order
    VALUES(2, 'apple', SYSDATE);
    
    -- 앞의 실습에서 만든 트리거를 삭제합니다
    DROP TRIGGER tri_order;
    
    -- 틀린 제품이름(cherry)을 입력합니다.
    INSERT INTO tab_order
    VALUES(3, 'cherry', SYSDATE);
    
    /*
        예 3. TRIGGER의 검사 조건을 WHEN 절에서 더 구체적으로 지정하기
              - ORD_NAME이 'cherry'인 제품에 대해서만 18:30 ~ 18:40분까지만 입력을 허용하는 트리거
                다른 제품코드는 시간과 관계 없이 정상적으로 입력되어야 함
    */
    DROP TRIGGER tri_order3;
    CREATE OR REPLACE TRIGGER tri_order3
    BEFORE INSERT ON tab_order
        FOR EACH ROW
        WHEN (NEW.ord_name = 'cherry')      -- WHEN 절에는 콜론 기호 ( : )는 삭제할 것
    BEGIN
        IF (TO_CHAR(SYSDATE, 'HH24:MI') NOT BETWEEN '18:30' AND '18:40') THEN
            RAISE_APPLICATION_ERROR(-20300, 'cheery time out!');
        END IF;
    END;
    /
    
    SELECT SYSDATE FROM DUAL;
    
    INSERT INTO tab_order
    VALUES (1, 'cherry', SYSDATE);
    
    INSERT INTO tab_order
    VALUES (2, 'banana', SYSDATE);
    
    /*
        예 4. 특정 테이블에 입력할 수 있는 계정을 지정하기
              (테이블 자체가 검사 대상이므로 문장 TRIGGER를 사용합니다)
    */
    CREATE TABLE t_test1 (no NUMBER);
    
    DROP TRIGGER t_usercheck;
    CREATE TRIGGER t_usercheck
    BEFORE INSERT OR UPDATE OR DELETE
    ON t_test1
    BEGIN
        IF USER NOT IN ('SCOTT', 'HR') THEN
            RAISE_APPLICATION_ERROR(-20001, 'Not Permit User !!!');
        END IF;
    END;
    /
    
    conn/ as sysdba
    
    CREATE USER C##user1 IDENTIFIED BY user1
    DEFAULT TABLESPACE users
    TEMPORARY TABLESPACE temp;
    
    GRANT connect, resource TO C##user1;
    
    GRANT INSERT ON scott.t_test1 TO C##user1;
    
    CONN C##user1/user1
    
    INSERT INTO scott.t_test1 VALUES (1);
    
    /*
        예 5. 기존 테이블(tab_test1)에 데이터가 업데이트될 때 기존 내용을 백업 테이블(tab_test2)로 옮겨 놓는 TRIGGER를 생성합니다
              삭제되는 특정 행이 TRIGGER의 대상이므로 행 레벨 TRIGGER를 사용합니다
    */
    CREATE TABLE tab_test1
    (no     NUMBER,
     name   VARCHAR2(10));
    
    CREATE TABLE tab_test2
    AS
        SELECT * FROM tab_test1;
        
    INSERT INTO tab_test1 VALUES (1, 'apple');
    INSERT INTO tab_test1 VALUES (2, 'banana');
    COMMIT;
    
    CREATE OR REPLACE TRIGGER move_data
    BEFORE UPDATE ON tab_test1
    FOR EACH ROW
    BEGIN
        INSERT INTO tab_test2 VALUES (:old.no, :old.name);
    END;
    /
    
    SELECT * FROM tab_test1;
    SELECT * FROM tab_test2;
    
    UPDATE tab_test1
    SET no = 2
    WHERE name = 'apple';
    
    /*
        예 6. 기존 테이블(tab_test3)의 데이터가 delete될 때 기존 내용을 백업 
    */

--==============================================================================================
--==============================================================================================


/*
    스토어드 함수 작성하기
    교수(professor) 테이블 사용
    교수번호를 입력받아 월급을 리턴하는 프로그램을작성하시오
    함수 이름 : wage
    bonus2는 특별상여금이다
    월급 = pay + bonus + bonus2 - tax
    bonus2는 (pay + bonus)의 50%
    tax = (pay + bonus + bonus2)의 20%
    출력내용 : 교수번호, 이름, 직급, 월급
*/
CREATE OR REPLACE FUNCTION bonus2
        (v_profno   professor.profno%TYPE)
    RETURN NUMBER
    IS
        bonus2     professor.profno%TYPE;
    BEGIN
        SELECT (pay + bonus) * 0.5 bonus2 
        INTO bonus2
        FROM professor
        WHERE deptno = v_deptno;
        RETURN min_sal;
    END;
    /

 CREATE OR REPLACE FUNCTION wage
        (v_deptno   NUMBER)
    RETURN DATE
    IS
        v_bonus2    professor.pay%TYPE;
        v_tax       professor.pay%TYPE;
        v_월급       professor.pay%TYPE;
    BEGIN
        SELECT profno, name, position, wage(profno) "월급"
        INTO wage
        FROM professor
        WHERE deptno = v_deptno;
        RETURN v_hiredate;
    END;
    /

select * from professor;
/*
(pay + bonus) * 0.5 "bonus2", 
               (pay + bonus + ((pay + bonus) * 0.5)) * 0.2 "tax",
               (pay + bonus + ((pay + bonus) * 0.5) - ((pay + bonus + ((pay + bonus) * 0.5)) * 0.2)) "월급"
*/


CREATE OR REPLACE FUNCTION max_sal (v_deptno emp.deptno%TYPE)
RETURN NUMBER
IS
    max_sal emp.sal%TYPE ;
BEGIN
    SELECT max(sal) INTO max_sal
    FROM emp
    WHERE deptno=v_deptno;
    RETURN max_sal ;
END;
/

CREATE OR REPLACE FUNCTION min_sal (v_deptno emp.deptno%TYPE)
RETURN NUMBER
IS
    min_sal emp.sal%TYPE ;
BEGIN
    SELECT min(sal) INTO min_sal
    FROM emp
    WHERE deptno=v_deptno;
    RETURN min_sal ;
END;
/

CREATE OR REPLACE FUNCTION avg_sal (v_deptno emp.deptno%TYPE)
RETURN NUMBER
IS
    avg_sal emp.sal%TYPE ;
BEGIN
    SELECT avg(sal) INTO avg_sal
    FROM emp
    WHERE deptno=v_deptno;
    RETURN avg_sal ;
END;
/



SELECT max_sal(10) FROM dual;
------------------------------------------------------------

SELECT deptno, max_sal(deptno)
FROM emp
GROUP BY deptno
ORDER BY 1;
------------------------------------------------------------

SELECT dname, max_sal(deptno) max_sal
FROM dept
ORDER BY 2;
------------------------------------------------------------

SELECT dname, max_sal(deptno) max_sal,
              min_sal(deptno) min_sal,
              avg_sal(deptno) avg_sal
FROM dept
ORDER BY deptno;


