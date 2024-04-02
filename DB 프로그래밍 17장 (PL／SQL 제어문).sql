-- 1. ���ǹ� (IF ��)
------------------------------------------------
-- 1_1 IF~THEN~ELSE~END IF (������ 2���� ��� ���)
/*
    IF (����) THEN
        ���๮��;
    ELSE
        ���๮��;
    END IF;
*/
    /* 
        �� : professor ���̺���, ������ȣ�� �Է¹޾� �� ������ profno, name, bonus�� ����ϵ�
            �ش� ������ bonus ���� 0���� ũ�� bonus�� �ݾ��� ����ϰ�, 0���� �۰ų� ������
            'Bonus is smaller than 0'�̶�� ������ ����ϼ���.
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
    
-- 1_2 IF~END IF ���� (������ 2�� �̻��� ���)
/*
    IF (����) THEN
        ���๮��
    END IF;
    => �� ������ ������ ���� ������ ��� �� ������ ���� �� ����� �ؼ� ������
*/
    /*
        �� : professor ���̺��� profno�� 1001���� ������ profno, name, deptno, dname�� ����ϼ���
            (��, DNAME�� ���� �Ʒ��� �����ϴ�.)
            DEPTNO�� 101�̸� 'Computer Engineering'
            DEPTNO�� 102�̸� 'Multimedia Engineering;
            DEOTNO�� 103�̸� 'Software Engineering'���� ����ϼ���.
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
-- 1_3 IF ~ THEN ~ ELSIF ~ END IF ���� (������ ���� ���� ��� ���� ���)
/*
    IF (����) THEN
        ���๮��;
    ELSIF (����) THEN
        ���๮��;
    ELSIF (����) THEN
        ���๮��;
    END IF;
*/
    /*
        �� : professor ���̺��� profno�� 1001���� ������ prfno, name, deptno, dname�� ����ϼ���
            (��, DNAME�� ���� �Ʒ��� �����ϴ�.)
            DEPTNO�� 101�̸� 'Computer Engineering'
            DEPTNO�� 102�̸� 'Multimedia Engineering;
            DEOTNO�� 103�̸� 'Software Engineering'���� ����ϼ���.
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
-- 2. CASE ��
------------------------------------------------
-- CASE���� IF ����� ���� �� ������ ���� ������ ��� �ξ� �� �����ϰ� �����ϰ� ������ �ľ��ؼ� �б��ų �� �ִ� ���
/*
    CASE [����] 
        WHEN ���� 1 THEN ��� 1 
        WHEN ���� 2 THEN ��� 2
        WHEN ���� n THEN ��� n 
    [ELSE �⺻��] 
    END ;
*/
    /*
        �� : professor ���̺��� profno�� 1001 ���� ������ profno, name, deptno, dnam �� ����ϼ���
            (��, DNAME�� ���� �Ʒ��� �����ϴ�.)
            DEPTNO�� 101�̸� 'Computer Engineering'
            DEPTNO�� 102�̸� 'Multimedia Engineering
            DEOTNO�� 103�̸� 'Software Engineering'���� ����ϼ���.
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
        �� 2 : EMP ���̺��� ����Ͽ� ����ڷκ��� ��� ��ȣ�� �Է¹޾� �ش� ����� empno, ename, sal, deptno, �λ� �� ����(up_sal)�� ����ϼ���.
        ��, �μ���ȣ�� 10�� �μ��� ���� ������ 30% �λ��ϰ�,
        �μ���ȣ�� 20�� , 30�� �μ��� 50% �λ��ϰ�,
        �μ���ȣ�� 30������ Ŭ ��� 20%�� �λ��ϼ���.
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

-- IF-ELSE������ ���

--==============================================================================================
--==============================================================================================
-- 3. �ݺ���
------------------------------------------------
-- 3_1 BASIC LOOP �ݺ���
-- �־��� ������ ���� ��� �ݺ��� �ߴ��� ��� ���� ����
/*
    LOOP 
    P1/SOL ����; 
    P1/SOL ����; 
    EXIT[ ���� ]; 
    END LOOP;
*/
    /*
        BASIC LOOP�� ��� ��
        Loop ���� ����Ͽ� ȭ�鿡 10���� 15������ ���ڸ� ����ϼ���.
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

-- 3_2 WHILE �ݺ���
-- WHILE���� ���ۺ��� ������ ���� �˻��� �� PL/SQL ������ ������
-- BASIC LOOP���� ������ Ʋ���� PL/SQL������ ������ 1ȸ�� ���������, WHILE���� �ƿ� ������� �ʴ´�.
/*
    WHILE ���� LOOP 
        PL/SQL ���� 
        PL/SQL ���� 
    ENDLOOP ;
*/
    /*
        WHILE �ݺ��� ��� �� 
        WHILE �ݺ����� ����Ͽ� ȭ�鿡 10���� 15������ ���ڸ� ����ϼ���.
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

-- 3_3 FOR �ݺ���
-- �ݺ�Ƚ���� ������ �� �ִ�.
/*
    FOR counter IN [REVERSE) start .. end LOOP 
        Statement1; 
        Statement2;
        ...
    END LOOP ; 
*/
    -- �� 1 : 11~15���� ���ڸ� ȭ�鿡 ���
    BEGIN
        FOR i in 10 .. 15 LOOP
            DBMS_OUTPUT.PUT_LINE(i);
        END LOOP;
    END;
    /
    -- �� 2 : ���ڸ� �������� ���
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
