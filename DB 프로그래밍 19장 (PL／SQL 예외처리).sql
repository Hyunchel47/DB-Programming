-- 2. 예외 처리 사용하기
------------------------------------------------
/*
    EXCEPTION
    WHEN exception1 [OR exception2 ...] THEN
        statement1;
        statement2;
        ...
    [WHEN exception3 [OR exception4 ...] THEN
        statement3;
        statement4;
    ...]
    [WHEN OTHERS THEN
        statementIN;
        statementIN + 1;
        
    - exception N
        => 실행부에서 발생한 예외의 이름들로 해당하는 WHEN 절 안의 문장들을 수행하게 됨
    - OTHERS
        => 어느 예외에도 속하지 않는 기타 예외를 뜻하며, 마지막에 기술되는 WHEN에만 사용
*/

-- 2_1 오라클에서 미리 정의된 예외 사용하기
SET VERIFY OFF
SELECT ename FROM emp
WHERE ename LIKE '&name';

SET serveroutput ON
DECLARE
    v_ename     emp.ename%TYPE;
BEGIN
    SELECT ename INTO v_ename
    FROM emp
    WHERE ename LIKE'&name%';
    DBMS_OUTPUT.PUT_LINE ('Name is ' || v_ename);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No people !');
    WHEN TOO_MANY_ROWS THEN
        DBMS_OUTPUT.PUT_LINE('More than 2 people !');
END;
/

-- 2_2

-- 2_3 RAISE를 사용하여 예외 상황 처리하기
SET SERVEROUTPUT ON
SET VERIFY OFF
DECLARE
    no_empno    EXCEPTION;
BEGIN
    UPDATE  emp
    SET     sal = 6000
    WHERE   empno = &empno;
    
    IF SQL&NOTFOUND THEN
        RAISE no_empno;
    END IF;
EXCEPTION
    WHEN no_empno THEN
        DBMS_OUTPUT.PUT_LINE('Not Exist your number! ');
END;
/

SELECT * FROM EMP;