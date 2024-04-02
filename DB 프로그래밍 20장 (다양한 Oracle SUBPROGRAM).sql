-- 1. PROCEDURE (���ν���)
------------------------------------------------
-- ����ڰ� � �۾��� ó���ϱ� ���� ����� PL/SQL ���
/*
    ��������
    CREATE OR REPLACE PROCEDURE procedure_name
    [( parameter1 [mode1] datatype1,
       parameter2 [mode2] datatype2,
       ... )]
    IS | AS
    PL/SQL Block;
*/
    -- �� 1. �μ���ȣ�� 30���� ������� JOB�� 'MANAGER'�� �����ϴ� ���ν���
    CREATE OR REPLACE PROCEDURE update_30
    IS
    BEGIN
        UPDATE emp
        SET job = 'MANAGER'
        WHERE deptno = 30;
    END;
    /

    -- �� 2. ����� �Է¹޾� �޿��� �λ��ϴ� PROCEDURE

    -- �� 3. ����� �Է¹޾� �� ����� �̸��� �޿��� ����ϴ� ���ν���
    CREATE OR REPLACE PROCEDURE ename_sal
        (vempno     emp.empno%TYPE)     -- ����ڷκ��� �Է¹޴� ���� ������ ���� ����
    IS
        vename  emp.ename%TYPE;     -- DB���� ������ ���� ������ ���� ����
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
    
    -- �� 4. OUT��� �Ķ���� ��� ��
    CREATE OR REPLACE PROCEDURE info_emp
        (v_empno    IN  emp.empno%TYPE,
         v_ename    OUT emp.ename%TYPE,     -- �̸����� ������ ����
         v_sal      OUT emp.sal%TYPE)       -- �޿��� ������ ����
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
        �� 1) ���� ������ �����ϴ� �Լ� �����
              - �μ���ȣ�� �Է¹޾� �ش� �μ��� �ְ� �޿����� ����ϴ� �Լ�
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
        RETURN max_sal;     -- ������ ���� 3������ ���� ���ƾ� �Ѵ�
    END;
    /
    
    SELECT max_sal(10) FROM dual;
    
    SELECT deptno, max_sal(deptno)
    FROM emp
    GROUP BY deptno
    ORDER BY 1;
    
    /*
        �� 2) ��¥ ������ �����ϴ� �Լ� �����
              - �μ���ȣ�� �Է¹��� �� �ش� �μ����� �ټӳ���� ���� ���� ����� �̸��� �Ի����� ����ϴ� �Լ��� �ۼ��ϼ���.
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
        �� 3. ���� ������ �����ϴ� �Լ� �����
              - ������ȣ�� �Է¹޾� �ش� ������ �μ����� �˷��ִ� �Լ� �ۼ��ϱ�
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
        �� 4. ������ �Լ� ��ȸ�ϱ�
    */
    SELECT text
    FROM user_source
    WHERE type = 'FUNCTION'
    AND name = 'MAX_SAL';
    
    
    -- �ٸ� ��
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
-- 3. Oracle PACKAGE (��Ű��)
------------------------------------------------
    /*
        �� ) member ���̺� ��ϵ� ȸ������ ������ ���̵� �˻��� ��й�ȣ�� �˻��� �ִ� ��Ű���Դϴ�
            - ����� �̸��� �Է¹��� �� �������� ���������� �����ϴ� find_sex ���ν���,
            - ����� �̸��� �ֹι�ȣ�� �Է¹޾� ȸ���� ���̵� ã���ִ� find_id ���ν���,
            - ����� ���̵�� ����ܾ �Է¹޾� ȸ���� ��й�ȣ�� �˷��ִ� find_pwd ���ν���
    */
    SELECT * FROM member;
    
    -- STEP 1 : PACKAGE ����θ� �����մϴ�.
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
    
    -- STEP 2 : PACKAGE BODY�θ� �����մϴ�.
    CREATE OR REPLACE PACKAGE BODY member_mg
    AS
        PROCEDURE find_sex (v_name  member.name%TYPE)   -- ������ ��ȸ�ϴ� ���ν���
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
    PROCEDURE find_sex (v_name  member.name%TYPE)   -- ������ ��ȸ�ϴ� ���ν���
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

    
    -- STEP 3 : ������ PACKAGE�� �׽�Ʈ�մϴ�.
    -- find_sex Procedure�� �׽�Ʈ�մϴ�.
    SET serveroutput ON
    EXEC member_mg.find_sex('Nicholas Cage');
    EXEC member_mg.find_sex('Jodie Foster');
    
    -- ��ϵ��� ���� �̸��� �Է��� �� ������ Ȯ���մϴ�.
    SET serveroutput ON
    EXEC member_mg.find_sex('Meg Ryan');
    BEGIN member_mg.find_sex('Meg Ryan'); END;
    
    -- find_id PROCEDURE�� �׽�Ʈ�մϴ�.
    -- �� ���ν����� �̸��� �ֹι�ȣ�� �Է��ϸ� ���̵� �˻��ϴ� ����� �մϴ�.


--==============================================================================================
--==============================================================================================
-- 4. TRIGGER (Ʈ����)
------------------------------------------------
-- Ư�� ����� �߻��� ������ ������(�ڵ�)���� ������ PL/SQL Ʈ���� ����� �����ϴ� ���
-- Ʈ���Ŵ� ���� ���� X, ���� Ʈ���� ���� �� ������ Ư����ǿ� ���ؼ��� �������� �ڵ������

-- 4_3 TRIGGER ����
/*
    CREATE [OR REPLACE] TRIGGER tigger_name
    timing
        event1 [OR event2 OR event3 ...]
    ON {table_name | view_name | SCHEMA | DATABASE}
    [REFERENCING OLD AS old | NEW AS new]
    [FOR EACH ROW [WHEN (condition)]]
        TRIGGER_BODY
        
    - timing : Ʈ���Ű� ����Ǵ� ������ ���� | event �߻� ���ĸ� �ǹ��ϴ� BEFORE, AFTER�� ����
               Ʈ���Ű� Ư�� �信 ���� DMS�� ��� INSTEAD OF�� ���     
*/

-- 4_4 TRIGGER ���� ����
-- TRIGGER�� ����, ���� �� ������ �� �ִ� ����
GRANT CREATE TRIGGER TO SCOTT;      -- ����
GRANT ALTER ANY TRIGGER TO SCOTT;   -- ����
GRANT DROP ANY TRIGGER TO SCOTT;    -- ����
-- �����ͺ��̽����� TRIGGER�� ������ �� �ִ� ����
GRANT ADMIN IS TER DATABASE TRIGGER TO SCOTT;
    /*
        �� 1. ���̺� �����͸� �Է��� �� �ִ� �ð� �����ϱ� 
             (���̺� ��ü�� ����̹Ƿ� ���� ���� TRIGGER�� ����մϴ�)
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
        IF (TO_CHAR(SYSDATE, 'HH24:MI') NOT BETWEEN '16:00' AND '16:50') THEN       -- �Է½ð��� 16:00 ~ 16:50���� ��츸 �Է� ���
            RAISE_APPLICATION_ERROR(-20100, 'Time Error!!');                        -- �� �� �ð��� ��� ������ �߻�
        END IF;
    END;
    /
    
    SELECT SYSDATE FROM DUAL;
    
    INSERT INTO tab_order
    VALUES(1, 'apple', SYSDATE);
    
    /*
        �� 2. ���̺� �Էµ� ������ ���� �����ϰ� �� �� �̿ܿ��� ������ �߻���Ű��
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
    
    -- �ű� ������ �Է��ϴµ� �տ��� ������ ���巹�� Ʈ���ŷ� ���� �Է��� �ȵ˴ϴ�.
    INSERT INTO tab_order
    VALUES(2, 'apple', SYSDATE);
    
    -- ���� �ǽ����� ���� Ʈ���Ÿ� �����մϴ�
    DROP TRIGGER tri_order;
    
    -- Ʋ�� ��ǰ�̸�(cherry)�� �Է��մϴ�.
    INSERT INTO tab_order
    VALUES(3, 'cherry', SYSDATE);
    
    /*
        �� 3. TRIGGER�� �˻� ������ WHEN ������ �� ��ü������ �����ϱ�
              - ORD_NAME�� 'cherry'�� ��ǰ�� ���ؼ��� 18:30 ~ 18:40�б����� �Է��� ����ϴ� Ʈ����
                �ٸ� ��ǰ�ڵ�� �ð��� ���� ���� ���������� �ԷµǾ�� ��
    */
    DROP TRIGGER tri_order3;
    CREATE OR REPLACE TRIGGER tri_order3
    BEFORE INSERT ON tab_order
        FOR EACH ROW
        WHEN (NEW.ord_name = 'cherry')      -- WHEN ������ �ݷ� ��ȣ ( : )�� ������ ��
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
        �� 4. Ư�� ���̺� �Է��� �� �ִ� ������ �����ϱ�
              (���̺� ��ü�� �˻� ����̹Ƿ� ���� TRIGGER�� ����մϴ�)
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
        �� 5. ���� ���̺�(tab_test1)�� �����Ͱ� ������Ʈ�� �� ���� ������ ��� ���̺�(tab_test2)�� �Ű� ���� TRIGGER�� �����մϴ�
              �����Ǵ� Ư�� ���� TRIGGER�� ����̹Ƿ� �� ���� TRIGGER�� ����մϴ�
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
        �� 6. ���� ���̺�(tab_test3)�� �����Ͱ� delete�� �� ���� ������ ��� 
    */

--==============================================================================================
--==============================================================================================


/*
    ������ �Լ� �ۼ��ϱ�
    ����(professor) ���̺� ���
    ������ȣ�� �Է¹޾� ������ �����ϴ� ���α׷����ۼ��Ͻÿ�
    �Լ� �̸� : wage
    bonus2�� Ư���󿩱��̴�
    ���� = pay + bonus + bonus2 - tax
    bonus2�� (pay + bonus)�� 50%
    tax = (pay + bonus + bonus2)�� 20%
    ��³��� : ������ȣ, �̸�, ����, ����
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
        v_����       professor.pay%TYPE;
    BEGIN
        SELECT profno, name, position, wage(profno) "����"
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
               (pay + bonus + ((pay + bonus) * 0.5) - ((pay + bonus + ((pay + bonus) * 0.5)) * 0.2)) "����"
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


