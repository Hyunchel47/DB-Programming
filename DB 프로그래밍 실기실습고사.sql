CREATE TABLE CREDIT23 (
order_date DATE,
customer VARCHAR2(15),
product VARCHAR2(12),
price NUMBER,
amount NUMBER 
);

insert into CREDIT23 values ('2023-07-01', '����', '�����', 350000, 10);
insert into CREDIT23 values ('2023-07-02', '�����ý���', '������', 220000, 5);
insert into CREDIT23 values ('2023-07-02', '�ϳ���ǻ��', '������', 220000, 15);
insert into CREDIT23 values ('2023-07-04', '�Ǿ���', '���콺', 25000, 15);
insert into CREDIT23 values ('2023-07-05', '������', '��ĳ��', 170000, 8);
insert into CREDIT23 values ('2023-07-05', '�Ǿ���', '�����', 350000, 15);
insert into CREDIT23 values ('2023-07-05', '������', '������', 220000, 6);
insert into CREDIT23 values ('2023-07-08', '�Ǿ���', '��ĳ��', 170000, 15);
insert into CREDIT23 values ('2023-07-11', '����', '����Ŀ', 18000, 8);
insert into CREDIT23 values ('2023-10-10', '����', 'Ű����', 1000000, 1); 

SELECT order_date , customer, product, price, amount
FROM CREDIT23;


SELECT order_date "�ŷ�����", product "��ǰ��", price "�ܰ�", amount "����", TO_CHAR(price * amount, '9,999,999') "�ݾ�"
FROM CREDIT23
WHERE customer = '�Ǿ���'
ORDER BY order_date asc;


alter session set nls_date_format='YYYY-MM-DD';
select * from CREDIT23;
drop table CREDIT23 purge ;
