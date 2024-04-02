--==============================================================================================
--==============================================================================================
-- 2. ������ Ŀ�� (Implicit Cursor)
------------------------------------------------
-- ����Ŭ���� �ڵ����� �������ִ� SQLĿ�� / ����� ���忡���� ���� ������ �� �� ����

-- 2_1 ������ Ŀ�� �Ӽ� (Cursor Attribute)
    /*
        SQL%ROWCOUNT
          -> �ش� Ŀ������ ������ �� ���� ���� (���� ������ ���� �� ��° ������ ī��Ʈ �մϴ�)�� ��ȯ�մϴ�.
        SQL%FOUND
          -> �ش� Ŀ�� �ȿ� ���� �����ؾ� �� �����Ͱ� ���� ��� TRUE(��) ���� ��ȯ�ϰ�
             ���� ��� FALSE (����)�� ���� ��ȯ�ϴ� �Ӽ��Դϴ�.
        SQL%NOTFOUND
          -> �ش� Ŀ�� �ȿ� �����ؾ� �� �����Ͱ� ���� TRUE(��) ���� ��ȯ�ϰ�
             ���� ��� FALSE(����)�� ���� ��ȯ�ϴ� �Ӽ��Դϴ�.
        SQL%ISOPEN
          -> ���� ������ Ŀ���� �޸𸮿� OPEN �Ǿ� ���� ���״� TRUE(��) ����,
             �׷��� ���� ��쿡�� FALSE(����) ���� ������ �Ӽ��Դϴ�.
    */
    
-- 2_2 ������ Ŀ�� ���
    -- �� : EMP ���̺��� sal�� ��ȸ�� ȭ��
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
    
-- 2_3 ������ Ŀ���� FOR LOOP�� Ȱ���ϱ�
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
-- 3. ����� Ŀ�� (Explicit Cursor)
------------------------------------------------
-- 3_1 ����� Ŀ�� �Ӽ� (Cursor Attribute)
    /*
        Ŀ���̸�%ROWCOUNT
          -> FETCH ���� ���� ���� ������ �� ���� ���� ������ �Ӽ��Դϴ�.
             ���� �������� ó���� ���� �� ��°������ ��ȯ���ݴϴ�.
        Ŀ���̸�%FOUND
          -> FETCH ���� ����Ǿ��� ���, ������(FETCH) ���� �ִٸ� TRUE(��) ����,
             �׷��� �ʴٸ� FALSE(����) ���� ������ �Ӽ��Դϴ�.
        Ŀ���̸�%NOTFOUND
          -> FETCH ���� ����Ǿ��� ���, ������(FETCH) ���� ���ٸ� TRUE(��) ����,
             �׷��� �ʴٸ� FALSE(����) ���� ������ �Ӽ��Դϴ�.
        Ŀ���̸�%ISOPEN
          -> ����� Ŀ���� �޸𸮿� Ȯ��(����)�Ǿ� ���� ��쿡�� TRUE(��) ����,
             �׷��� ���� ��� FALSE(����) ���� ������ �Ӽ��Դϴ�.
    */

--==============================================================================================
--==============================================================================================
-- 4. ����� Ŀ�� (Explicit Cursor) ó�� �ܰ�
------------------------------------------------


--==============================================================================================
--==============================================================================================

-- 4.4 ����� Ŀ�� ��� ��
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
    ���ν��� �� : show_emp()
    �Ķ���� : deptno
    ���� : show_emp(10)
          show_emp(20)
          show_emp(30)
    ��� :
    ACCOUNT �μ��� ����� ������ �����ϴ�.
**/

SET serveroutput ON
CREATE OR REPLACE PROCEDURE show_emp (deptno IN NUMBER) IS
    v_empno     NUMBER(5);
    v_ename     VARCHAR2(30);
    v_sal       NUMBER(6);
BEGIN
     DBMS_OUTPUT.PUT_LINE(decode(deptno, 10, 'ACCOUNT', 20, 'RESEARCH', 30, 'SALES') || ' �μ��� ����� ������ �����ϴ�:');
    FOR emp_rec IN (SELECT empno, ename, sal FROM emp WHERE deptno = deptno) LOOP
        DBMS_OUTPUT.PUT_LINE(emp_rec.empno || ' ' || emp_rec.ename || ' ' || emp_rec.sal);
    END LOOP;
END;
/

--==============================================================================================
--==============================================================================================
-- 6. �Ķ���� Explicit Cursor
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

-- FOR������ �غ���
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
