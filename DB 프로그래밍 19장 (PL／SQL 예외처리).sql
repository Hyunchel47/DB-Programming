-- 2. ���� ó�� ����ϱ�
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
        => ����ο��� �߻��� ������ �̸���� �ش��ϴ� WHEN �� ���� ������� �����ϰ� ��
    - OTHERS
        => ��� ���ܿ��� ������ �ʴ� ��Ÿ ���ܸ� ���ϸ�, �������� ����Ǵ� WHEN���� ���
*/

-- 2_1 ����Ŭ���� �̸� ���ǵ� ���� ����ϱ�
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

-- 2_3 RAISE�� ����Ͽ� ���� ��Ȳ ó���ϱ�
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