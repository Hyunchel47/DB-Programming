-- USING : �ܷ�Ű �̸��� ������ ���
SELECT empno, ename, deptno, dname
FROM emp JOIN dept USING(deptno);

SELECT empno, e.deptno, dname
FROM emp e, dept d
WHERE  e.deptno = d.deptno;

-- ���� �Ϲ����� ���
SELECT empno, e.deptno, dname
FROM emp e JOIN dept d
ON (e.deptno = d.deptno);

SELECT empno, deptno, dname
FROM emp JOIN dept d
USING(deptno);

--==============================================================================================
--==============================================================================================
-- 2. EQUI JOIN(� ����)
-- ���� ���̺��� �����͸� ������ �� ���� �������� �˻��ؼ� ������ ������ ���� �����͸� ���� ���̺��� ���� ���� ���
--------------------------------------------
-- ��� ��1
SELECT empno, ename, dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;
-- ANSI Join ����
SELECT empno, ename, dname
FROM emp e JOIN dept d
ON e.deptno = d.deptno;

-- ��� ��2
SELECT s.name "STU_NAME", p.name "PROF_NAME"
FROM student s, professor p
WHERE s.profno = p.profno;
-- ANSI Join ����
SELECT s.name "STU_NAME", p.name "PROF_NAME"
FROM student s JOIN professor p
ON s.profno = p.profno;
-- USING ���
SELECT s.name "STU_NAME", p.name"PROF_NAME"
FROM student s JOIN professor p USING (profno);

-- ��� ��3
SELECT s.name "STU_NAME", d.dname "DEPT_NAME", p.name "PROF_NAME"
FROM student s, department d, professor p
WHERE s.deptno1 = d.deptno AND s.profno = p.profno;
-- ANSI Join ����
SELECT s.name "STU_NAME", d.dname "DEPT_NAME", p.name "PROF_NAME"
FROM student s JOIN department d
ON s.deptno1 = d.deptno
JOIN professor p
ON s.profno = p.profno;

-- ��� ��4
-- student ���̺��� ��ȸ�Ͽ� 1����(deptno1)�� 101���� �л����� �̸��� �� �л����� �������� �̸��� ����Ͻÿ�.
SELECT s.name "STU_NAME", p.name "PROF_NAME"
FROM student s, professor p
WHERE s.profno = p.profno 
AND s.deptno1 = 101;
-- ANSI Join ����
SELECT s.name "STU_NAME", p.name "PROF_NAME"
FROM student s JOIN professor p
ON s.profno = p.profno 
AND s.deptno1 = 101;

--==============================================================================================
--==============================================================================================
-- 3. Non-Equi Join(�� ����)
-- ���� ������ �ƴ� ũ�ų� �۰ų� �ϴ� ����� �������� ��ȸ�� �ؾ� �� ��� ���
--------------------------------------------
-- ��� ��1
SELECT c.gname "CUST_NAME", c.point "POINT", g.gname "GIFT_NAME"
FROM customer c, gift g
WHERE c.point BETWEEN g.g_start AND g.g_end;
-- ANSI Join ����
SELECT c.gname "CUST_NAME", c.point "POINT", g.gname "GIFT_NAME"
FROM customer c JOIN gift g
ON c.point BETWEEN g.g_start AND g.g_end;
-- �� �����ڸ� ��� --> BETWEEN���� ������ �� ����
SELECT c.gname "CUST_NAME", c.point "POINT", g.gname "GIFT_NAME"
FROM customer c JOIN gift g
ON c.point >= g.g_start
AND c.point <= g.g_end;

-- ��� ��2
SELECT s.name "STU_NAME", o.total "SCORE", h.grade "CREDIT"
FROM student s, score o, hakjum h
WHERE s.studno = o.studno 
AND o.total >= h.min_point
AND o.total <= h.max_point
ORDER BY score asc;
-- ANSI Join ����
SELECT s.name "STU_NAME", o.total "SCORE", h.grade "CREDIT"
FROM student s JOIN score o
ON s.studno = o.studno
JOIN hakjum h
ON o.total >= h.min_point
AND o.total <= h.max_point
ORDER BY score asc;

--==============================================================================================
--==============================================================================================
-- 4. OUTER Join(�ƿ��� ����)
-- ���� ���̺��� �����Ͱ� �ְ�, ���� ���̺� ���� ��� �����Ͱ� �ִ� �� ���̺��� ������ ���� ����ϰ� �ϴ� ���
--------------------------------------------
-- ��� ��1
-- student ���̺�� professor ���̺��� join�Ͽ� �л� �̸��� �������� �̸��� ��� 
-- ��, ���������� �������� ���� �л��� ��ܵ� �Բ� ���
SELECT s.name STU_NAME, p.name PROF_NAME
FROM student s, professor p
WHERE s.profno = p.profno(+);       -- �����Ͱ� ���� �ʿ� (+)
-- ANSI Outer Join ����
SELECT s.name STU_NAME, p.name PROF_NAME
FROM student s LEFT OUTER JOIN professor p      -- ���� �����Ͱ� �����ϴ� ���� ���
ON s.profno = p.profno;

-- ��� ��2
-- student ���̺Ұ� professor ���̺��� join�Ͽ� �л� �̸��� �������� �̸��� ���
-- ��, �����л��� �����Ǵ� ���� ������ ��ܵ� �Բ� ���
SELECT s.name STU_NAME, p.name PROF_NAME
FROM student s, professor p
WHERE s.profno(+) = p.profno;
-- ANSI Outer Join ����
SELECT s.name STU_NAME, p.name PROF_NAME
FROM student s RIGHT OUTER JOIN professor p      
ON s.profno = p.profno;

-- ��� ��3
-- student ���̺�� professor ���̺��� Join�Ͽ� �л� �̸��� �������� �̸��� ���
-- ��, �����л��� ���� �� �� ���� ��ܰ� ���������� ���� �� �� �л� ����� �Ѳ����� ����ϼ���
SELECT s.name STU_NAME, p.name PROF_NAME
FROM student s, professor p
WHERE s.profno(+) = p.profno
UNION
SELECT s.name STU_NAME, p.name PROF_NAME
FROM student s, professor p
WHERE s.profno = p.profno(+);
-- ANSI Full Outer Join ����
SELECT s.name STU_NAME, p.name PROF_NAME
FROM student s FULL OUTER JOIN professor p      
ON s.profno = p.profno;

--==============================================================================================
--==============================================================================================


-- '��ǻ���������к�'�� �Ҽӵ� �а��� �ο����� ����Ͻÿ�. << �۳� ���蹮��
SELECT d.dname, COUNT(*)
FROM student s JOIN department d
ON s.deptno1 = d.deptno
GROUP BY d.dname
HAVING d.dname = 'Computer Engineering';

-- ���蹮��
-- �޿��� sal+comm
-- ����(PRESIDENT)�� ������ ����� ��ձ޿��� 2000�̻���
-- �μ��� �μ���� ��ձ޿��� ���Ͻÿ�
-- ��ձ޿��� �Ҽ��� 1�ڸ����� ǥ��
SELECT dname "�μ���", ROUND(AVG(sal+NVL(comm,0)),1) "��ձ޿�"
FROM emp JOIN dept USING(deptno)
WHERE job NOT IN (SELECT job
                  FROM emp
                  WHERE job = 'PRESIDENT')
GROUP BY dname
HAVING AVG(sal+NVL(comm,0)) >= 2000;

-- '��ǻ�Ͱ��а�'�� �л��� �й�, �г�, �̸�, ��������

select * from student;
select * from department;
select * from emp;
select * from dept;
desc dept
desc emp
desc student
desc professor
desc department
desc gift
desc customer
desc hakjum
desc score
select g_start, g_end from gift;

-- ���蹮��
-- �޿��� sal+comm
-- ����(PRESIDENT)�� ������ ����� ��ձ޿��� 2000�̻���
-- �μ��� �μ���� ��ձ޿��� ���Ͻÿ�
-- ��ձ޿��� �Ҽ��� 1�ڸ����� ǥ��
SELECT dname, ROUND(AVG(sal+NVL(comm, 0)),1) "��� �޿�"
FROM emp JOIN dept USING(deptno)
WHERE job NOT IN (SELECT job
                  FROM emp
                  WHERE job = 'PRESIDENT')
GROUP BY dname
HAVING AVG(sal+NVL(comm, 0)) >= 2000;

-- '��ǻ���������к�'�� �Ҽӵ� �а��� �ο����� ����Ͻÿ�. << �۳� ���蹮��
SELECT dname, COUNT(*) "�а��� �ο���"
FROM student s JOIN department d
ON s.deptno1 = d.deptno
GROUP BY dname
HAVING dname = '��ǻ���������к�';
