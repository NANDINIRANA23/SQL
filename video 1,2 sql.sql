create table teachers(t_id int,t_name varchar(100),t_subject varchar(100),t_salary int)
select * from teachers
insert into teachers values(1,'smisha','english',6000),(2,'priya','maths',4000),(3,'chandni','commerce',8000)
-- DDL---JO STRUCTURE OF DATA DEFINE KRTI H.  

delete from teachers -- rows delete ho gyi
drop table teachers

--DML-- delete,insert,select,update.
-- selecteing limiting row--

select t_name,t_subject 
from teachers;

--limiting rows--
select top 1 * from teachers;

--sorting data --select teacher salary desc order.
select * from teachers
order by t_salary desc,t_subject asc;

insert into teachers values(4,'ekta','english',6000)

create table amazon_orders1
(
order_id varchar,
order_date date,
product_name varchar(100),
total_price decimal(6,2),
payment_method varchar(20)
);
SELECT * FROM AMAZON_ORDERS1

--DML -> MODIFY DATA INSIDE TABLE.-->INSERT,UPDATE,SELETE,DELETE.

--DDL -> DEFINE STRUCTURE OF DATA/TABLE/SCHEMA.--> CREATE,DROP,RENAME,ALTER,TRUNCATE.

INSERT INTO AMAZON_ORDERS1 VALUES(1,'2026-12-04 12:00:00','MOBILE',1000.00,'UPI'),('2','2026-02-12 10:12:00','TV',6000,'CREDIT CARD'),
('3','2026-01-01 02:02:02','PRINTER',4000,'DEBIT CARD')
DELETE FROM amazon_orders1
DROP TABLE amazon_orders1
alter table amazon_orders alter column order_date date; --DDL
alter table amazon_orders alter column order_id int; --DDL data type should be compatible
alter table amazon_orders alter column product_name varchar(20); --DDL data type should be compatible
alter table amazon_orders alter column order_date datetime; --DDL data type should be compatible

ALTER TABLE AMAZON_ORDERS1 ADD NAME VARCHAR(20) -- we can't add multiple col in one statement.--
SELECT * FROM amazon_orders1

INSERT INTO AMAZON_ORDERS1 VALUES(4,'2026-12-04 12:00:00','MOBILE',1000.00,'UPI','NULL'),(5,'2026-12-04 12:00:00','MOBILE',1000.00,'UPI',' ')
update amazon_orders1
set name = 'ishu'
where order_id=1

update amazon_orders1
set name = 'nandini'
where order_id=2

drop table amazon_orders1

--constraints--
--1. null constraint -- should not null.
--2.primary key-- not null,not duplicate, table should have 1 pk,can combine(pk+col)
--3. unique key-- null,not dup,i table can have multiple uk.
--4.default
--5.fk.

create table a_orders
(order_id int ,
order_date date ,
product_name varchar(100),
total_price decimal(6,2),
payment_method varchar (20) check(payment_method in ('credit card','upi')) default 'upi',
discount int check (discount >= 50 ),
category varchar (50) default 'women wear',
primary key (order_id,product_name)
)

select * from a_orders

insert into a_orders values(1,'2026-06-12','chair',100.00,'credit card',50,'kids')
insert into a_orders (order_id,order_date,product_name,total_price,payment_method,discount,category)values (3,'2026-06-13','hair color',80.00,'credit card',60,default)
-- for above command you can dothat one time only--
update a_orders
set category = 'men wear'
where order_id = 2

insert into a_orders values(' ','2026-06-12','chair',100.00,'credit card',50,'kids')
insert into a_orders values(4,'2026-06-12','chair',100.00,'credit card',50,'kids')

delete from a_orders where order_id=0