 -- 3. PL/SQL ����� �⺻ ���� ���캸��
 --------------------------------------------
/*
    DECLARE(�����) : ���� ������ ��� ���� �̸� �����ϴ� �κ� (���� ������)
    BEGIN (�����) : ���� ����� PL/SQL �ڵ尡 �� (���� �Ұ�)
    EXCEPTION (����ó����) : ���ܰ� �߻����� ��� ó���� ������ ���� �κ� (���� ������)
    SET SERVEROUTPUT ON;    -> ȭ�� ��±���� Ȱ��ȭ ��Ŵ
    SHOW ERRORS;            -> ������ ���� �� ������ ������
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
-- emp, dept ���
-- ȭ�鿡 ���ðŴ� empno, ename, dname
-- Join ��� x
SET serveroutput ON     -- ȭ�� ��±���� Ȱ��ȭ��Ŵ
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
-- 4. PL/SQL Block�� SQL ����� ����ϱ�
 --------------------------------------------
/*
    - PL/SQL ����� ������ �ݵ�� END�� ǥ���ؾ� �Ѵ�.
    - PL/SQL ��� �ȿ� DDL(������ ���Ǿ�)���� ���� ����ϸ� �ȵȴ�.
    - PL/SQL�� GRANT �Ǵ� REVOKE�� ���� DCL(������ ���Ǿ�)���� ���� �������� �ʴ´�.
*/


-- 4_1. PL/SQL �������� SELECT ���� ����ϱ�
/*
    SELECT select_list INTO {variable_name[, variable_name]...|record_name}
    FROM table
    [WHERE condition];
*/
    -- �� 1. emp ���̺��� �����ȣ�� 7902���� ����� �����ȣ�� �̸��� ��ȸ�ؼ� ������ ������ �� ȭ�鿡 ����ϼ���.
SET serveroutput ON
DECLARE     -- DB���� ��ȸ�� �ᱣ���� ������ ������ �̸� ����
    v_empno     emp.empno%TYPE;
    v_ename     emp.ename%TYPE;
BEGIN       -- DB���� ���� ��ȸ�� �� �غ�� ������ �ִ´�.
    SELECT empno, ename INTO v_empno, v_ename
    FROM emp
    WHERE empno = 7902;
    
    DBMS_OUTPUT.PUT_LINE(v_empno || '- This member''s name is '|| v_ename);     -- ������ ����� ���� ȭ�鿡 ���
END;
/

    -- �� 2 : ����ڷκ��� ��ȣ�� �Է¹޴� �κ��� �߰��Ǿ����ϴ�.
    --        �����ȣ�� �Է¹��� �� emp ���̺��� �ش� ����� ����� �̸�, �Ի����� ����ϼ���.
SET serveroutput ON
DECLARE
    v_empno         emp.empno%TYPE;
    v_ename         emp.ename%TYPE;
    v_hiredate      emp.hiredate%TYPE;
BEGIN
    SELECT empno, ename, hiredate
    INTO v_empno, v_ename, v_hiredate
    FROM emp
    WHERE empno = &empno;       -- ����ڿ��� ���� �Է¹޾� ������ �Ҵ��� �� ���
    DBMS_OUTPUT.PUT_LINE('EMPNO / ENAME / HIREDATE');
    DBMS_OUTPUT.PUT_LINE('---------------------------');
    DBMS_OUTPUT.PUT_LINE(v_empno || ' / ' || v_ename || ' / ' || v_hiredate);
END;
/


-- 4_2. PL/SQL �������� DML ���� ����ϱ�
CREATE TABLE t_plsql (
no NUMBER,
name VARCHAR2(10),
tel NUMBER
);

    -- 4_2_1 PL/SQL���� �⺻���� INSERT�� �����մϴ�.
    SET serveroutput ON
    BEGIN
        INSERT INTO t_plsql VALUES(1, 'AAA', 1111);
    END;
    /
    SELECT * FROM t_plsql;
    COMMIT;
    
    -- 4_2_2 INSERT ���� �����ϱ�
    -- �� 2 : ����ڷκ��� ��ȣ(no), �̸�(name), ����ó(tel) ���� �Է¹��� �� t_plsql ���̺� �Է��ϴ� PL/SQL ������ �ۼ��ϼ���.
    SET VERIFY OFF
    DECLARE
        v_no        NUMBER := &no;              -- := �Ҵ� ������
        v_name      VARCHAR2(10) := '&name';
        v_tel       NUMBER := &tel;
    BEGIN
        INSERT INTO t_plsql VALUES(v_no, v_name, v_tel);
    END;
    /
    SELECT * FROM t_plsql;
    COMMIT;
    
    -- 4_2_3 PL/SQL���� UPDATE�� �����մϴ�.
    BEGIN
        UPDATE t_plsql
        SET name = 'CCC'
        WHERE no = 2;
    END;
    /
    SELECT * FROM t_plsql;
    COMMIT;
    
    -- 4_2_4 PL/SQL���� DELETE�� �����մϴ�.
    BEGIN
        DELETE FROM t_plsql
        WHERE no = 1;
    END;
    /
    SELECT * FROM t_plsql;
    COMMIT;
    
    -- 4_2_5 PL/SQL���� MERGE�۾��� �����մϴ�.
    -- ����


select * from emp;


