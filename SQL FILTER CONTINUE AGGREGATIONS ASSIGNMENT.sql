--1- write a update statement to update city as null for order ids :  CA-2020-161389 , US-2021-156909

select * from orders

update orders
set city = null
where order_id in ('CA-2020-161389' ,'US-2021-156909')

-- write a update statement to update city as null for customer ids :  AB-10600,JR-15670
begin transaction
update orders
set city= null
where customer_id in ('AB-10600','JR-15670')

rollback

--2- write a query to find orders where city is null (13 rows)

select * from orders 
where city is null

--3- write a query to get total profit, first order date and latest order date for each category.

select category, sum(profit) as total_profit, max(order_date) as latest_date, min(order_date) as first_order_date
from orders
group by category

-- 4- write a query to find sub-categories where average profit is more than the half of the max profit in that sub-category

select sub_category ,avg(profit) as avg_profit,max(profit) as max_profit
from orders
group by sub_category
having avg(profit)> max(profit)/2.0

--5- create the exams table with below script;
create table exams (student_id int, subject varchar(20), marks int);

insert into exams values (1,'Chemistry',91),(1,'Physics',91),(1,'Maths',92)
,(2,'Chemistry',80),(2,'Physics',90)
,(3,'Chemistry',80),(3,'Maths',80)
,(4,'Chemistry',71),(4,'Physics',54)
,(5,'Chemistry',79);

select * from exams

--write a query to find students who have got same marks in Physics and Chemistry.
select student_id, marks
from exams 
where subject in ('Chemistry','Physics') 
group by student_id, marks
having count(1)=2

--6- write a query to find total number of products in each category.

select category, count(distinct product_id) as total_number_of_products
from orders
group by category

-- count -- how many number of rows.
--sum -- total number of numeric
--distinct-- remove duplicate
--sum(distinct)-- total of unique values.
--count(distinct)-- count unique values.

--7- write a query to find top 5 sub categories in west region by total quantity sold

select top 5  sub_category,sum(quantity) as total_quantity
from orders
where region = 'West'
group by sub_category
order by total_quantity desc

-- where-- filter rows
-- having -- filter groups(aggregated results)--> count,sum,min,max,avg.

--8- write a query to find total sales for each region and ship mode combination for orders in year 2020
 -- total sale for each region 
 --ship mode  for order 2000
 select * from orders
 select distinct region,ship_mode,order_date, sum(sales) as total_sales
 from orders
 where order_date  between '2020-01-01' and  '2020-12-31'
 group by  region,ship_mode,order_date

