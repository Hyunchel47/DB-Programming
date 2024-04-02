 -- 3. PL/SQL 블록의 기본 구조 살펴보기
 --------------------------------------------
/*
    DECLARE(선언부) : 사용될 변수나 상수 등을 미리 정의하는 부분 (생략 가능함)
    BEGIN (실행부) : 실제 실행될 PL/SQL 코드가 들어감 (생략 불가)
    EXCEPTION (예외처리부) : 예외가 발생했을 경우 처리할 내용을 적는 부분 (생략 가능함)
    SET SERVEROUTPUT ON;    -> 화면 출력기능을 활성화 시킴
    SHOW ERRORS;            -> 오류에 대한 상세 내용을 보여줌
*/

SET SERVEROUTPUT ON;
DECLARE
    v_empno     emp.empno%TYPE;
    v_ename     emp.ename%TYPE;
BEGIN
    SELECT empno, ename INTO v_empno, v_ename
    FROM emp
    WHERE empno =&empno;
        DBMS_OUTPUT.PUT_LINE(v_empno||' - This Member''s name is '|| v_ename);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO Member!');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More Than 2 Member !');
END;
/

--==============================================================================================
--==============================================================================================
-- emp, dept 사용
-- 화면에 나올거는 empno, ename, dname
-- Join 사용 x
SET serveroutput ON     -- 화면 출력기능을 활성화시킴
DECLARE
    v_empno     emp.empno%TYPE;
    v_ename     emp.ename%TYPE;
    v_dname     dept.dname%TYPE;
BEGIN
    SELECT empno, ename, dname
    INTO v_empno, v_ename, v_dname
    FROM emp, dept
    WHERE prono =&prono;
        DBMS_OUTPUT.PUT_LINE(v_prono||' -This Member''s name is '|| v_name);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('NO Member!');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More Than 2 Member !');
END;
/

--==============================================================================================
--==============================================================================================
-- 4. PL/SQL Block에 SQL 문장들 사용하기
 --------------------------------------------
/*
    - PL/SQL 블록이 끝나면 반드시 END로 표시해야 한다.
    - PL/SQL 블록 안에 DDL(데이터 정의어)문을 직접 사용하면 안된다.
    - PL/SQL은 GRANT 또는 REVOKE와 같은 DCL(데이터 정의어)문을 직접 지원하지 않는다.
*/


-- 4_1. PL/SQL 내에서의 SELECT 문장 사용하기
/*
    SELECT select_list INTO {variable_name[, variable_name]...|record_name}
    FROM table
    [WHERE condition];
*/
    -- 예 1. emp 테이블에서 사원번호가 7902번인 사원의 사원번호와 이름을 조회해서 변수에 저장한 후 화면에 출력하세요.
SET serveroutput ON
DECLARE     -- DB에서 조회한 결괏값을 저장할 변수를 미리 선언
    v_empno     emp.empno%TYPE;
    v_ename     emp.ename%TYPE;
BEGIN       -- DB에서 값을 조회한 후 준비된 변수에 넣는다.
    SELECT empno, ename INTO v_empno, v_ename
    FROM emp
    WHERE empno = 7902;
    
    DBMS_OUTPUT.PUT_LINE(v_empno || '- This member''s name is '|| v_ename);     -- 변수에 저장된 값을 화면에 출력
END;
/

    -- 예 2 : 사용자로부터 번호를 입력받는 부분이 추가되었습니다.
    --        사원번호를 입력받은 후 emp 테이블에서 해당 사원의 사번과 이름, 입사일을 출력하세요.
SET serveroutput ON
DECLARE
    v_empno         emp.empno%TYPE;
    v_ename         emp.ename%TYPE;
    v_hiredate      emp.hiredate%TYPE;
BEGIN
    SELECT empno, ename, hiredate
    INTO v_empno, v_ename, v_hiredate
    FROM emp
    WHERE empno = &empno;       -- 사용자에게 값을 입력받아 변수에 할당할 때 사용
    DBMS_OUTPUT.PUT_LINE('EMPNO / ENAME / HIREDATE');
    DBMS_OUTPUT.PUT_LINE('---------------------------');
    DBMS_OUTPUT.PUT_LINE(v_empno || ' / ' || v_ename || ' / ' || v_hiredate);
END;
/


-- 4_2. PL/SQL 내에서의 DML 문장 사용하기
CREATE TABLE t_plsql (
no NUMBER,
name VARCHAR2(10),
tel NUMBER
);

    -- 4_2_1 PL/SQL에서 기본적인 INSERT를 수행합니다.
    SET serveroutput ON
    BEGIN
        INSERT INTO t_plsql VALUES(1, 'AAA', 1111);
    END;
    /
    SELECT * FROM t_plsql;
    COMMIT;
    
    -- 4_2_2 INSERT 문장 수행하기
    -- 예 2 : 사용자로부터 번호(no), 이름(name), 연락처(tel) 값을 입력받은 후 t_plsql 테이블에 입력하는 PL/SQL 문장을 작성하세요.
    SET VERIFY OFF
    DECLARE
        v_no        NUMBER := &no;              -- := 할당 연산자
        v_name      VARCHAR2(10) := '&name';
        v_tel       NUMBER := &tel;
    BEGIN
        INSERT INTO t_plsql VALUES(v_no, v_name, v_tel);
    END;
    /
    SELECT * FROM t_plsql;
    COMMIT;
    
    -- 4_2_3 PL/SQL에서 UPDATE를 수행합니다.
    BEGIN
        UPDATE t_plsql
        SET name = 'CCC'
        WHERE no = 2;
    END;
    /
    SELECT * FROM t_plsql;
    COMMIT;
    
    -- 4_2_4 PL/SQL에서 DELETE를 수행합니다.
    BEGIN
        DELETE FROM t_plsql
        WHERE no = 1;
    END;
    /
    SELECT * FROM t_plsql;
    COMMIT;
    
    -- 4_2_5 PL/SQL에서 MERGE작업을 수행합니다.
    -- 생략


select * from emp;


