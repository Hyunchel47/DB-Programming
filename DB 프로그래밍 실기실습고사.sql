CREATE TABLE CREDIT23 (
order_date DATE,
customer VARCHAR2(15),
product VARCHAR2(12),
price NUMBER,
amount NUMBER 
);

insert into CREDIT23 values ('2023-07-01', '앤컴', '모니터', 350000, 10);
insert into CREDIT23 values ('2023-07-02', '금정시스템', '프린터', 220000, 5);
insert into CREDIT23 values ('2023-07-02', '하나컴퓨터', '프린터', 220000, 15);
insert into CREDIT23 values ('2023-07-04', '피씨컴', '마우스', 25000, 15);
insert into CREDIT23 values ('2023-07-05', '세븐컴', '스캐너', 170000, 8);
insert into CREDIT23 values ('2023-07-05', '피씨컴', '모니터', 350000, 15);
insert into CREDIT23 values ('2023-07-05', '세븐컴', '프린터', 220000, 6);
insert into CREDIT23 values ('2023-07-08', '피씨컴', '스캐너', 170000, 15);
insert into CREDIT23 values ('2023-07-11', '앤컴', '스피커', 18000, 8);
insert into CREDIT23 values ('2023-10-10', '앤컴', '키보드', 1000000, 1); 

SELECT order_date , customer, product, price, amount
FROM CREDIT23;


SELECT order_date "거래일자", product "제품명", price "단가", amount "수량", TO_CHAR(price * amount, '9,999,999') "금액"
FROM CREDIT23
WHERE customer = '피씨컴'
ORDER BY order_date asc;


alter session set nls_date_format='YYYY-MM-DD';
select * from CREDIT23;
drop table CREDIT23 purge ;
